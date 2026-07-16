"""Sixth pipeline stage: builds the normalized "Blueprint" structure.

The Blueprint is the stable, documented JSON shape that will eventually
describe a document's visual structure once a real analyzer (Vision,
OCR, LLM) is plugged in. At this stage it is **not intelligent**: every
section is a well-defined but empty placeholder. The point of building
it now is that the schema — the keys, their nesting, what a "bounding
box" looks like — is fixed once, so a future analyzer only has to fill
these fields in rather than invent a new response shape.

Blueprint format (version 1)::

    {
        "version": 1,
        "page_count": int,
        "logo": {
            "page": int | null,              # page the logo was found on
            "bounding_box": [x0, y0, x1, y1] | null,
        },
        "text_zones": [
            {"page": int, "bounding_box": [x0, y0, x1, y1], "role": str}
        ],
        "main_table": {
            "page": int | null,
            "bounding_box": [x0, y0, x1, y1] | null,
            "columns": [str, ...],
        },
        "footer": {
            "page": int | null,
            "bounding_box": [x0, y0, x1, y1] | null,
        },
        "variables": [
            {"name": str, "page": int, "bounding_box": [x0, y0, x1, y1]}
        ],
        "company_coordinates": {
            "page": int | null,
            "bounding_box": [x0, y0, x1, y1] | null,
        },
    }

A ``bounding_box`` is always ``[x0, y0, x1, y1]`` in PDF points, top-left
origin — or ``null`` when not (yet) detected. Lists are empty, not
absent, when nothing was found, so consumers can always iterate them
without a null check.
"""


class BlueprintBuilder:
    async def build(
        self, *, metadata: dict[str, object], layout: dict[str, object]
    ) -> dict[str, object]:
        return {
            "version": 1,
            "page_count": metadata.get("page_count", 0),
            "logo": {"page": None, "bounding_box": None},
            "text_zones": [],
            "main_table": {"page": None, "bounding_box": None, "columns": []},
            "footer": {"page": None, "bounding_box": None},
            "variables": [],
            "company_coordinates": {"page": None, "bounding_box": None},
        }

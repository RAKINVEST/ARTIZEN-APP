"""ARTIZEN V2 — quote-extraction engine.

Reconstructs a full ``devis`` from an imported PDF: OCR/analysis text (from
``document_analysis``) -> a real multimodal AI provider -> a validated
``ExtractedQuote`` -> a faithful render ``Document`` and an editable draft.

Replaces the V1 identity-only import (``template_import`` + the hard-coded
``sample_document`` demo quote). The one rule that shapes every file here: the
imported PDF is the only source of truth — absent fields stay empty, no value is
ever invented, and known demonstration literals are rejected (``guards.py``).

Layering (one-directional, downstream): ``quote_extraction`` reads
``document_analysis`` (text) and ``app.ai`` (provider), and targets
``app.pdf.Document`` (render). It owns no table of its own — the extraction is
attached to the existing ``DocumentAnalysis`` row.
"""

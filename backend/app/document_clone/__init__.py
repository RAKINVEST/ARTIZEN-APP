"""The ARTIZEN documentary-clone engine.

Turns an imported document (devis, facture, avoir, contrat…) into an intelligent
ARTIZEN model (``.artizen``) that reproduces the company's own documentary
identity for every future document — deterministically, without AI at
generation time.

Pipeline (voie C):

    PDF → Document Analyzer → (structural | hybrid | OCR) extraction
        → AI enrichment (once) → .artizen model → deterministic renderer

Deliberately generic: the engine is the same for every document type; only the
business rules change — mirroring ``app/pdf/`` which already renders a neutral
``Document`` and has never heard of a "quote".
"""

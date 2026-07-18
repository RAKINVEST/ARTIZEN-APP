"""Asynchronous task infrastructure (V3 foundations).

Heavy or slow work — speech-to-text, LLM calls, OCR, e-mail, mass PDF — must
never run inside an HTTP request. This package is the plumbing that lets the
app hand such work to a separate worker process over Redis (arq). It ships
the infrastructure and one smoke-test task only; business tasks arrive with
their modules (starting with the voice-quote AI assistant).
"""

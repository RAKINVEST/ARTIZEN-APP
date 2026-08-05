"""Aggregates versioned/business API endpoint routers.

Health is mounted directly on the app in ``main.py`` (unprefixed, for
container/load-balancer probes). This router is where future business
endpoints (clients, devis, factures, planning, ...) get registered.
"""

from fastapi import APIRouter

from app.ai_companion.router import router as ai_companion_router
from app.api.endpoints.config import router as config_router
from app.branding.router import router as branding_router
from app.catalog.router import router as catalog_router
from app.clients.router import router as clients_router
from app.decision.router import router as decision_router
from app.document_analysis.router import router as document_analysis_router
from app.document_detection.router import router as document_detection_router
from app.knowledge.router import router as knowledge_router
from app.mission.router import router as mission_router
from app.notification.router import router as notification_router
from app.orchestration.router import router as orchestration_router
from app.planning.router import router as planning_router
from app.quote_assistant.router import router as quote_assistant_router
from app.quote_extraction.router import router as quote_extraction_router
from app.quotes.router import router as quotes_router
from app.sites.router import router as sites_router
from app.template_import.router import router as template_import_router
from app.users.router import router as auth_router
from app.workflow.router import router as workflow_router

api_router = APIRouter()
api_router.include_router(config_router)
api_router.include_router(auth_router)
api_router.include_router(branding_router)
api_router.include_router(document_analysis_router)
api_router.include_router(document_detection_router)
api_router.include_router(catalog_router)
api_router.include_router(clients_router)
api_router.include_router(sites_router)
api_router.include_router(quotes_router)
api_router.include_router(quote_assistant_router)
api_router.include_router(decision_router)
api_router.include_router(knowledge_router)
api_router.include_router(workflow_router)
api_router.include_router(mission_router)
api_router.include_router(orchestration_router)
api_router.include_router(planning_router)
api_router.include_router(notification_router)
api_router.include_router(ai_companion_router)
api_router.include_router(quote_extraction_router)
api_router.include_router(template_import_router)

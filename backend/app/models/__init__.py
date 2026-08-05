# Future domain models (User, Client, Devis, Facture, ...) are imported here
# so their tables register on Base.metadata before Alembic autogenerate runs.

from app.ai_conversations import models as ai_conversations_models  # noqa: F401
from app.branding import models as branding_models  # noqa: F401
from app.catalog import models as catalog_models  # noqa: F401
from app.clients import models as clients_models  # noqa: F401
from app.document_analysis import models as document_analysis_models  # noqa: F401
from app.document_detection import models as document_detection_models  # noqa: F401
from app.mission import models as mission_models  # noqa: F401
from app.notification import models as notification_models  # noqa: F401
from app.orchestration import models as orchestration_models  # noqa: F401
from app.planning import models as planning_models  # noqa: F401
from app.quotes import models as quotes_models  # noqa: F401
from app.sites import models as sites_models  # noqa: F401
from app.users import models as users_models  # noqa: F401
from app.workflow import models as workflow_models  # noqa: F401

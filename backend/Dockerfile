FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# The user the application actually runs as: a process that never needs to
# write outside /data/storage has no business being able to. Created after
# the COPY so the application files stay root-owned and read-only to it.
RUN useradd --create-home --uid 1000 artizen \
    && mkdir -p /data/storage \
    && chown -R artizen:artizen /data/storage

# Deliberately no `USER artizen` here. The container starts as root and
# entrypoint.sh immediately drops to artizen via setpriv — see its phase 1.
# Doing it in the entrypoint rather than here is what lets it repair a
# pre-existing root-owned volume first: Docker only applies the image's
# ownership to a volume it creates empty, so an upgraded install would
# otherwise start "healthy" and fail every upload with EACCES.
#
# The security property is unchanged — no application code ever runs as
# root — and it is the same pattern the official postgres/nginx images use.

EXPOSE 8000

# Invoked via bash (not "./entrypoint.sh") so it still runs correctly even
# when ./backend is bind-mounted over /app in docker-compose.yml, which
# would otherwise shadow the executable bit set at build time.
ENTRYPOINT ["bash", "entrypoint.sh"]

# The default is the production server: no --reload (a development-only
# file watcher that also pins the app to a single worker), and several
# workers so one slow PDF parse doesn't serialize every other request.
# docker-compose.yml overrides this with --reload for local development —
# the safe default belongs in the image, the convenience in the compose
# file, not the other way round.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]

#!/usr/bin/env python3
"""Create development-only FixMyStreet config with the current DB credentials.
Do not commit the generated citypulse/general.yml file.
"""
import json
import os
from pathlib import Path
src = Path("conf/general.yml-docker")
dst = Path("citypulse/general.yml")
password = os.environ.get("CITYPULSE_POSTGRES_PASSWORD")
if not password:
    raise SystemExit("CITYPULSE_POSTGRES_PASSWORD must be set")
source = src.read_text()
needle = "FMS_DB_PASS: 'fms'"
if source.count(needle) != 1:
    raise SystemExit("Expected upstream database password setting not found exactly once")
dst.write_text(source.replace(needle, "FMS_DB_PASS: " + json.dumps(password)))
dst.chmod(0o600)
print("Wrote development database config")

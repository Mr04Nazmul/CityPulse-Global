# CityPulse Global — upstream-based deployment track

This repository is a direct fork of the FixMyStreet platform, not a rewrite. Retain the upstream license and notices unless an independently verifiable alternative license covers the copied files.

## Run the existing platform locally

Prerequisites: Docker Engine with Compose, adequate memory, and Linux-compatible container support.

1. Copy `citypulse/.env.example` to `citypulse/.env`, replace all sample passwords with strong unique passwords, and do not commit the resulting file.
2. Run `set -a; . citypulse/.env; set +a; python3 citypulse/generate_config.py` to create an ignored local server configuration matching the database credentials.
3. Run `docker compose --env-file citypulse/.env -f citypulse/compose.dev.yml up --build`.
4. Open http://localhost:8000 . The upstream application may need initialization and map/geocoder configuration before reports are fully functional. If init fails, follow upstream Docker instructions before retrying.
5. Shut down with `docker compose --env-file citypulse/.env -f citypulse/compose.dev.yml down`. Do not add `-v` unless you intend to delete the local database.

This development compose is NOT a production deployment: it exposes an unauthenticated HTTP listener on localhost, and does not configure TLS, email verification, rate limiting, backups, privacy notices, reporting authority routing, or moderation approval.

## Important architecture distinctions

* FixMyStreet's own PostgreSQL, login, report and upload modules already exist. Supabase Auth is **not** wired in, and its JWT identities should not be assumed compatible with FixMyStreet sessions.
* Global map coverage requires a licensed and scalable map tile/geocoding provider, country-by-country administrative boundaries, and authority/report routing. This is not yet configured.
* A cross-platform Android wrapper and production deployment are separate deliverables. Neither has been built/tested.
* Avoid sending reports to any real authority during development. Confirm the configured staging flags before ever enabling outbound notification.
* Review the original `LICENSE.txt` for attribution, source access and network-use conditions.

## Development checklist

- [x] Fork the original upstream source and preserve history
- [x] Add isolated local Compose configuration and environment template
- [x] Run GitHub Actions Docker smoke test (HTTP response verified on 2026-10-21; this does not prove production readiness)
- [ ] Verify database migrations and full report creation flow
- [ ] Configure place search, tiles, photo storage and outbound email
- [ ] Choose login architecture; implement/test Supabase SSO only if required
- [ ] Implement moderation policy, privacy checks and abuse handling
- [ ] Create a CityPulse theme / localization in upstream's cobrand system
- [ ] Configure global regions and reporting authorities
- [ ] Publish TLS-enabled website and test Android build

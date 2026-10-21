# CityPulse Global — deployment readiness

## Verified baseline
The GitHub Actions Docker smoke test passed on commit `514ad7b`. This proves only that the temporary GitHub runner could start the development stack and receive an HTTP 2xx response. It does not publish a public website.

## Production prerequisites
- A Linux host or managed container service supporting a long-running Docker Compose application, PostgreSQL, and persistent storage. GitHub Pages and ordinary serverless functions are not substitutes for the full FixMyStreet Perl/Docker stack.
- A domain and TLS reverse proxy.
- Persistent PostgreSQL data and photo uploads, encrypted backups and recovery testing.
- Strong unique admin/database secrets stored outside Git.
- SMTP and outgoing mail configuration, abuse prevention and rate limits.
- Country/region coverage, map tiles, geocoding, MapIt administrative boundaries, and destination authority routing.
- FixMyStreet licensing/attribution review (retain upstream AGPL notices; any separate waiver must be verified).
- Security review and staging test before accepting real reports.

## Current limitations
`citypulse/compose.dev.yml` is **development only**. It binds HTTP to loopback, uses the upstream prebuilt image rather than a CityPulse-specific image, has a development configuration, and does not persist user-uploaded photos. Do not expose it to the internet unchanged.

## Next deployment sequence
1. Select a container host and confirm its price, supported volumes, and network ports.
2. Add a production Dockerfile and production-only Compose configuration with persistent volumes and TLS termination.
3. Configure secrets and a real hostname, then deploy to a staging subdomain.
4. Test signup, report creation, photo upload, map search, outbound email, and backups.
5. Promote to production only after security and licensing checks.

## Verify smoke tests
See [GitHub Actions](https://github.com/Mr04Nazmul/CityPulse-Global/actions).

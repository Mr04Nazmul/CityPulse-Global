# Low-cost VPS choice for CityPulse Global

**Candidate:** Contabo Cloud VPS 4, 4 vCPU, 8 GB RAM, 100 GB SSD (published starting price US$5.28/month; location, billing term, taxes, setup fees and availability may change). Tokyo location may cost more. Confirm the final checkout total before buying.

Official pricing: https://contabo.com/en/pricing/
Tokyo location: https://contabo.com/en-us/locations/asia-japan/

## Provisioning checklist
1. Order only after checking the checkout price and location. Choose Ubuntu 24.04 LTS x86_64.
2. Add your SSH public key in the provider console; avoid password-only SSH access.
3. After first login, clone this repository and run `sudo bash citypulse/vps/bootstrap-ubuntu.sh`. It installs Docker Engine and Compose but does **not** publish CityPulse.
4. Configure firewall carefully after verifying the SSH port; expose only 22 (or configured SSH port), 80 and 443. Do not expose PostgreSQL or memcached.
5. Create encrypted secret files outside the repository and arrange automated database and photo backups.
6. Build a production-specific image from the fork and configure a TLS proxy and persistent uploads before launching. The existing `compose.dev.yml` is not production-ready.
7. Deploy to staging and test authentication, reports, images, maps, email, backups and security. Then switch DNS to production.

**Current status:** hosting provider selected; bootstrap script committed; no VPS purchased or deployed. The GitHub Actions smoke test is not a public hosting service.

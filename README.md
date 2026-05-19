# nextjs_ghcr

Next.js app with ESLint, Docker (via WSL), and GitHub Actions publishing versioned images to GHCR.

Inspired by [cda_ghcr](../cda_ghcr).

## Prerequisites

- [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) with a Linux distro (Ubuntu recommended)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) with **WSL 2 integration** enabled for your distro
- Node.js 22+ on Windows (local dev) or in WSL

## Local development (Windows)

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

## ESLint

```bash
npm run lint
```

## Docker via WSL

**Docker Desktop** must be running, with **Settings → Resources → WSL integration** enabled for your distro. If you see `docker.sock: no such file or directory` in WSL, enable integration and restart Docker Desktop.

From **WSL**, go to the project (Windows path is mounted under `/mnt/c/...`):

```bash
cd /mnt/c/Users/ADJADI/Desktop/workspace/CEFIM/docker/nextjs_ghcr
chmod +x scripts/docker-wsl.sh
./scripts/docker-wsl.sh
# or: docker compose up --build
```

With an explicit version label:

```bash
APP_VERSION=v1.0.0 docker compose up --build
```

API: [http://localhost:3000/api/version](http://localhost:3000/api/version)

## GitHub & GHCR

1. Create a repository on GitHub (e.g. `2iAcademy/nextjs_ghcr`).
2. Push this project and enable **Actions** and **Packages** for the repo.
3. Push to branch `ghcr` to build and publish `latest` + branch tags.
4. Create a release tag for semver images:

   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

Images are published to `ghcr.io/<owner>/<repo>` with tags like `latest`, `v1.0.0`, `v1.0`, `v1`.

### Connect remote

```bash
git remote add origin https://github.com/2iAcademy/nextjs_ghcr.git
git branch -M ghcr
git push -u origin ghcr
```

Replace the org/repo with your own if needed.

## CI workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `ci.yaml` | push/PR on `main`, `master`, `ghcr` | ESLint + TypeScript check |
| `docker-publish.yaml` | push on `ghcr`, tags `v*.*.*` | Build & push Docker image to GHCR |

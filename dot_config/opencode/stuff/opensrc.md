# Reading dependency source code

Use `opensrc` to read a dependency's actual source code, not just its types or
docs. It resolves the package to its git repo at the correct version tag and
shallow-clones it into a cache. `opensrc path` prints the cached path to
stdout (progress goes to stderr), so compose it inside other commands:

```bash
rg "pattern" $(opensrc path zod)               # search a package's source
cat $(opensrc path zod)/src/types.ts           # read a specific file
fd . $(opensrc path pypi:requests)             # other registries: pypi:, crates:
ls $(opensrc path vercel/next.js)/packages     # or a repo directly: owner/repo
```

Notes:

- Run inside a project so opensrc can detect the version from lockfiles
  (`node_modules`, `package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`); outside
  a project it falls back to the latest release.
- The cache lives in `$OPENSRC_HOME` (`/tmp/opensrc`) and is wiped on reboot.
  If a cached path is gone, just re-run the command — opensrc re-fetches
  automatically.
- Prefer `opensrc path` over guessing `~/.opensrc/...` paths.

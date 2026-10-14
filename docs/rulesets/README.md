# Branch rulesets

GitHub settings kept as code so they are reviewable. Apply by hand (repo admin):

```sh
gh api repos/dasa-capstone/DASA/rulesets                         # list existing first
gh api --method POST repos/dasa-capstone/DASA/rulesets --input docs/rulesets/main.json
gh api --method PUT  repos/dasa-capstone/DASA/rulesets/<id> --input docs/rulesets/main.json  # update
```

- `main.json`: PR with one approval, the `lint`, `test` and `secrets` checks passing and up to date, threads resolved, squash merge only, no force-push or deletion.
- `dev.json`: only used while the temporary `dev` branch exists (see `CONTRIBUTING.md`). Same checks, no approval required. Merge commits are allowed so `main` can be merged back into `dev`.

Check names are the job names in `.github/workflows/check.yml`; rename both together.

## Other repository settings (UI)

- Secret scanning and push protection on.
- Dependabot alerts on.
- Actions: workflow token read-only; allow GitHub-owned and verified actions.
- Automatically delete head branches.
- Write access: Brendon, Luca, Gabriel, Suresh.

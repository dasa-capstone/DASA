# Contributing Guide

How we set up, code, test, review, and release DASA so every change meets our Definition of Done. Team roles, decisions, and conflict are in our team charter; this file covers the repository. Questions go to the DASA Teams chat.

## Code of Conduct

Be respectful and critique code, not people. We follow the OSU Student Code of Conduct. Report problems to the Project Manager (Brendon Wong), or to the instruction team if the PM is involved.

## Getting Started

**Prerequisites:** Git and access to `dasa-capstone/DASA`. What the PX4 simulation needs (Docker or a local install) is still open; see below.

```bash
git clone https://github.com/dasa-capstone/DASA.git
cd DASA
```

**Still to decide as a team (Sprint 1):** the language version, package manager, PX4 version, and how the simulator runs (container or local install). Once decided, record the choice in `docs/adr/0001-dev-environment.md` and put the full setup, starting from Suresh's existing instructions, in `docs/setup.md`. Owners: Gabriel Simek (ADR) and Brendon Wong (setup doc).

## Branching & Workflow

- We use GitHub Flow: `main` always works, and every change reaches it through a pull request.
- Branch from the latest `main` with a short-lived branch named `feature/`, `fix/`, `docs/`, `exp/`, or `chore/` plus a short description.
- We squash and merge, then delete the branch. Nobody pushes directly to `main`.

## Issues & Planning

- Every task is a Trello card with one owner, an expected outcome, and a due date.
- Every PR links its Trello card in the description. Small chores with no card get the `no-card` label. Until the planned `trello-sync` workflow lands (Sprint 1), move cards to Review and Done by hand; after that it attaches the PR to the card and moves the card as the PR progresses.
- Bugs and setup problems are GitHub Issues.
- Cards are sized to finish in two or three days; bigger ones get split.

## Commit Messages

Short imperative subject (about 50 characters), with a body when the reason isn't obvious. Example: `Add altitude tolerance check to verifier`. Reference issues with `Fixes #12`.

## Code Style, Linting & Formatting

One linter and formatter, chosen with the toolchain in ADR 0001 and run the same way locally (pre-commit hook) and in CI. Their config file and exact commands are listed here when they land in Sprint 1 (owner: Gabriel Simek). Style isn't debated in review: if the formatter accepts it, it's fine.

## Testing

- New or changed logic needs tests. Verifier changes need at least one PASS, one FAIL, and one INCONCLUSIVE case.
- Small sample flight logs used by tests are committed under `tests/fixtures/`. Raw experiment logs are not.
- Anything random is seeded so results repeat.
- The test framework and run command are set in ADR 0001 (Sprint 1, owner: Gabriel Simek).

## Definition of Done

A change merges only when it passes every check below.

| Check | Enforced by | Lands | Owner |
|---|---|---|---|
| Merged through a reviewed PR, approved by someone other than the author | `main` ruleset | Now | Gabriel |
| All review threads resolved, including Copilot's | `main` ruleset | Now | Gabriel |
| Docs updated when behavior or setup changes | PR template checklist, checked by reviewer | Now | Brendon |
| Linked to its Trello card | `trello-card` check from the `trello-sync` workflow, required by the ruleset | Sprint 1 | Brendon |
| Lint and format clean | Pre-commit hook and `lint` CI job | Sprint 1 | Gabriel |
| Tests pass | `test` CI job, required by the ruleset | Sprint 1 | Gabriel |
| No secrets committed | Secret scan in pre-commit and CI | Sprint 1 | Luca |
| Simple mission still passes in simulation | Scheduled CI smoke test | Sprint 2–3 | Gabriel |
| Experiment can be rerun by a teammate with the same result | Run record (commit, PX4 version, parameters, mission, seed, model and prompt for generated variants) required in experiment PRs | Sprint 2 | Experiment owner |

## Contribution Norm

Each of us lands at least one piece of accepted work per sprint.

| Work | Lives in | Accepted when |
|---|---|---|
| Code | Pull request | Approved and merged |
| Literature notes, design docs, ADRs | Pull request into `docs/` | Approved and merged |
| Experiments | Pull request with results and run record | Approved and merged |
| Non-repository work | Trello card | Outcome written on the card and moved to Done at a Friday meeting |

Formatter runs, lockfile bumps, and generated files don't count on their own. To keep this workable, we review within one business day, pair on setup-heavy work, and post in Teams when blocked for more than a day.

## Pull Requests & Reviews

- Use the PR template, link the Trello card, and keep PRs small enough to review in one sitting.
- At least one teammate approves. Reviews arrive within one business day and ask for specific changes. "LGTM" alone doesn't count as a review in sprint notes.
- Copilot reviews every PR automatically. Its review is advisory and never replaces a teammate's approval. Its comments are fixed or answered like anyone else's.
- The author owns everything in the PR, including AI-written code, and must be able to explain it. Structural changes suggested by an AI tool go through an ADR first.
- Required status checks are listed in the `main` ruleset and grow as CI jobs land.

## CI/CD

Workflows live in `.github/workflows/`. Planned jobs: `trello-sync` to keep Trello cards in step with PRs, `lint`, `test`, and secret scanning (Sprint 1), then a scheduled simulation smoke test (Sprint 2–3). Results and re-runs are in the PR's **Checks** tab. A check that keeps failing for no clear reason goes to the Quality Owner.

## Security & Secrets

- No credentials, API keys, or `.env` files in the repository.
- Report a leaked secret or vulnerability privately to the Quality Owner, not in a public issue. A leaked key gets revoked, not just deleted.
- What may go into AI tools follows the AI and Confidentiality section of the charter and `AGENTS.md`.
- Attack and failure experiments run only inside the simulation environment.
- Dependency updates go in their own `chore/` PRs.

## Documentation Expectations

- `README.md` stays a quickstart a new teammate can follow from a fresh clone.
- `docs/` holds requirements, design, risks, ADRs (`docs/adr/`), and literature notes (`docs/literature/`).
- Docs change in the same PR as the code they describe. Comments explain why, not what.

## Release Process

There is no release yet. At the end of each term the Quality Owner tags `main` (for example `fall-2026`) after tests and a manual smoke run pass. A fuller process is set before Winter week 1 (owner: Gabriel Simek).

## Support & Contact

Ask in the DASA Teams chat; we reply within 24 hours on weekdays.

- Tasks and the board: Brendon Wong (Project Manager)
- AI tools and what can be shared: Luca Regazzoni (AI Coordinator)
- CI, tests, reviews, and this file: Gabriel Simek (Quality Owner)

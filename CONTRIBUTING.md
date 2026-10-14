# Contributing Guide

How we set up, code, test, review, and release DASA so every change meets our Definition of Done. Team roles, decisions, and conflict are in our team charter; this file covers the repository. Agent-assisted work also follows `docs/agent-workflow.md`. Questions go to the DASA Teams chat.

## Code of Conduct

Be respectful and critique code, not people. We follow the OSU Student Code of Conduct. Report problems to the Project Manager (Brendon Wong), or to the instruction team if the PM is involved.

## Getting Started

**Prerequisites:** Git, Python 3.12 or newer, `make`, and access to `dasa-capstone/DASA`. On Windows, work inside WSL2 (PX4 needs it anyway). The first `make hooks` downloads the hook tools, so it needs network. The PX4 simulation will run in Docker (environment PR, in progress).

```bash
git clone https://github.com/dasa-capstone/DASA.git
cd DASA
python3 -m venv .venv && . .venv/bin/activate
pip install -r requirements-dev.txt
make hooks   # install the pre-commit hooks
make check   # what CI runs
```

The PX4 version and simulator setup will be recorded in `docs/adr/0001-dev-environment.md` by the environment PR (owner: Gabriel Simek), with run instructions in `README.md`.

## Branching & Workflow

- We use GitHub Flow: `main` always works, and every change reaches it through a pull request.
- Branch from the latest `main` with a short-lived branch named `feature/`, `fix/`, `docs/`, `exp/`, or `chore/` plus a short description.
- We squash and merge, then delete the branch. Nobody pushes directly to `main`.
- **Temporary `dev` branch.** When a deadline can't wait for reviews, work can land on `dev` through PRs that pass CI but don't need an approval. Nothing on `dev` counts as accepted: it reaches `main` through one normal reviewed PR, and `dev` is deleted afterwards. Announce it in Teams when it's created.

## Issues & Planning

- Every task is a Trello card with one owner, an expected outcome, and a due date.
- Every PR links its Trello card in the description. Small chores with no card get the `no-card` label. Until the planned `trello-sync` workflow lands (Sprint 1), move cards to Review and Done by hand; after that it attaches the PR to the card and moves the card as the PR progresses.
- Bugs and setup problems are GitHub Issues.
- Cards are sized to finish in two or three days; bigger ones get split.

## Commit Messages

Short imperative subject (about 50 characters), with a body when the reason isn't obvious. Example: `Add altitude tolerance check to verifier`. Reference issues with `Fixes #12`.

## Code Style, Linting & Formatting

ruff lints and formats (config in `pyproject.toml`), run by the pre-commit hook and in CI; `make lint` runs it on everything. Style isn't debated in review: if the formatter accepts it, it's fine.

## Testing

- New or changed logic needs tests. Verifier changes need at least one PASS, one FAIL, and one INCONCLUSIVE case.
- Small sample flight logs used by tests are committed under `tests/fixtures/`. Raw experiment logs are not.
- Anything random is seeded so results repeat.
- pytest; `make test` runs the fast suite. Tests that need the simulator are marked `@pytest.mark.sim`.

## Definition of Done

A change reaches `main` only when it passes every check below.

| Check | Enforced by | Lands | Owner |
|---|---|---|---|
| Merged through a reviewed PR, approved by someone other than the author | `main` ruleset | Now | Gabriel |
| All review threads resolved, including Copilot's | `main` ruleset | Now | Gabriel |
| Docs updated when behavior or setup changes | PR template checklist, checked by reviewer | Now | Brendon |
| Linked to its Trello card | `trello-card` check from the `trello-sync` workflow, required by the ruleset | Sprint 1 | Brendon |
| Lint and format clean | Pre-commit hook and `lint` CI job | Now | Gabriel |
| Tests pass | `test` CI job, required by the ruleset | Now | Gabriel |
| No secrets committed | gitleaks in pre-commit and the `secrets` CI job; GitHub push protection | Now | Gabriel |
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
- If Copilot review is enabled, its review is advisory and never replaces a teammate's approval; its comments are fixed or answered like anyone else's.
- The author owns everything in the PR, including AI-written code, and must be able to explain it. Structural changes suggested by an AI tool go through an ADR first.
- Required status checks are listed in the `main` ruleset and grow as CI jobs land.

## CI/CD

Workflows live in `.github/workflows/`. `check.yml` runs `lint`, `test`, and `secrets` (full-history gitleaks) on every PR; all three are required by the `main` ruleset (`docs/rulesets/`). Planned: `trello-sync` to keep Trello cards in step with PRs, then a scheduled simulation smoke test (Sprint 2–3). Results and re-runs are in the PR's **Checks** tab. A check that keeps failing for no clear reason goes to the Quality Owner.

## Security & Secrets

- No credentials, API keys, or `.env` files in the repository.
- Report a leaked secret or vulnerability privately to the Quality Owner, not in a public issue. A leaked key gets revoked, not just deleted.
- What may go into AI tools follows the AI and Confidentiality section of the charter and `AGENTS.md`.
- Attack and failure experiments run only inside the simulation environment. Containers publish ports on `127.0.0.1` only and don't use host networking.
- Don't change a teammate's machine (system config, global installs) without asking.
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

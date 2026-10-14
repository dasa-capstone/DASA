# AGENTS.md

Context for AI coding agents working in this repository. Keep it short: a line belongs here only if removing it would cause a mistake. People should read `README.md` and `CONTRIBUTING.md`. How we run agent work (briefs, small PRs, evidence) is in `docs/agent-workflow.md`.

## Project

DASA asks whether AI-generated software diversity reduces attack transferability in autonomous systems while preserving mission behavior. PX4 flight software in simulation is the test subject.

- **Pipeline:** mission spec → PX4 SITL → `.ulg` flight log → verifier → PASS / FAIL / INCONCLUSIVE.
- **Variants are modified PX4 source**, built from a pinned commit. The baseline is the unmodified build.
- **PX4 is a stand-in**, chosen because it is open source. Variant generation and differential testing must not depend on PX4 specifics; PX4-specific code lives behind a small adapter.
- **The harness reports how a run went** (completed, failed, timed out). Only the verifier decides whether the mission passed.
- **Workstreams:** Red builds controlled failure and attack scenarios. Blue generates variants that must still pass the verifier.
- **Source of truth:** the team's project-plan Google Doc (not in this repo) for scope and decisions; ADRs in `docs/adr/` for technical decisions. If they disagree with this file, say so in the PR.

## Commands

```sh
make hooks   # once per clone
make check   # what CI runs; must pass before a PR
make test    # fast tests only
make help
```

Environment targets (build, run a mission) are added by the environment PR; list them here when they land. Simulator tests are marked `@pytest.mark.sim` and excluded from `make test`.

## Git and GitHub

```sh
git switch -c feature/<short-name> origin/<base>    # base is dev while it exists, otherwise main
make check
git commit -F msg.txt                                # long messages from a file, not -m
git push -u origin feature/<short-name>              # asks first
gh pr create --base <base> --title "..." --body-file pr.md   # body follows .github/pull_request_template.md
gh pr checks --watch                                 # report failures; don't merge
```

A person merges. Never `gh pr merge`, never push to `main` or `dev`, never change repository settings.

## Work

- Tasks are Trello cards. Each PR links its card.
- Short-lived branches (`feature/`, `fix/`, `docs/`, `exp/`, `chore/`), small PRs. Never commit to `main` or `dev`.
- Done means the card's expected outcome and the Definition of Done in `CONTRIBUTING.md` are met.

## Conventions

- Layout: `missions/`, `harness/`, `verifier/`, `diversification/`, `attacks/`, `experiments/`, `scripts/`, `results/`, `docs/`, `tests/`. Create a directory when its first file lands.
- Values that are guesses pending the team or sponsor (simulator, world, tolerances) go in one config file, marked `# placeholder:` with who decides. Don't bury guesses in code or present them as decided.
- The verifier returns PASS only with clear evidence, FAIL only with evidence of a violation, INCONCLUSIVE otherwise. Tolerances come from the mission's requirements file, never from vehicle parameters.
- Seed randomness. Every run writes a record beside its logs: git commit, PX4 commit, variant patch, config, seed, outcome.
- Small sample logs live in `tests/fixtures/`. Raw logs and results don't go in git.
- Containers publish ports on `127.0.0.1` only and don't use host networking (PX4's MAVLink has no authentication).

## Boundaries

**Always**
- Run `make check` before calling a task done.
- Say what you verified by running it and what you didn't.
- Keep changes to the scope of the linked card.

**Ask first**
- Adding or upgrading dependencies.
- Changing the PX4 version, simulator setup, mission definitions, or verifier criteria.
- Editing CI workflows or repo settings.
- Structural changes (these need an ADR in `docs/adr/`).
- Anything outside the repository, such as system config or global installs.
- Pushing, merging, or calling `gh api`. Merges are done by a person.

**Never**
- Force-push, skip hooks (`--no-verify`), or commit to `main`/`dev`.
- Edit or delete tests to make them pass.
- Commit or paste into unapproved tools: credentials, `.env` contents, meeting notes, the local `handover/` folder, partner data, unpublished results.
- Run attack or failure-injection code outside the simulation.
- Commit large files or raw flight logs.

## Confidentiality

This repository is public. What may go into which AI tools follows the AI and Confidentiality section of the team charter; ask Luca (AI Coordinator) when unsure.

## To be added once code exists

| What | Owner | When |
|---|---|---|
| Environment commands (build, run a mission) | Gabriel | Environment PR |
| Simulator pitfalls from reproducing the baseline missions | Brendon | After the first teammate cold start |
| Module map and non-obvious conventions | Luca | After the harness and verifier exist |
| Rules for generating LLM variants (approved model, prompt storage, cost limits) | Luca | After the partner confirms approved tools |

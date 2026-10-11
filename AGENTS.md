# AGENTS.md

Context for AI coding agents working in this repository. Keep it short: a line belongs here only if removing it would cause a mistake. People should read `README.md` and `CONTRIBUTING.md`.

## Project

DASA is a research project on whether AI-generated software diversity reduces attack transferability in autonomous systems. We use PX4 flight software in simulation.

- **Pipeline:** mission spec → PX4 SITL (Gazebo) → `.ulg` flight log → verifier → PASS / FAIL / INCONCLUSIVE.
- **Workstreams:** Red builds controlled failure and attack scenarios. Blue generates diversified variants that must still pass the verifier.
- **Docs:**
  - Requirements: `docs/requirements.md`
  - Design: `docs/design.md`
  - Decisions: `docs/adr/`
  - Risks: `docs/risks.md`. Flag new risks there, but don't edit it.
- **Definition of Done and review rules:** `CONTRIBUTING.md`

## Commands

Not set yet. The toolchain is decided in `docs/adr/0001-dev-environment.md` (Sprint 1, owner: Gabriel). Add the install, test, lint, and run-a-mission commands here exactly as typed, plus one command that runs every check.

## Work

- Tasks are Trello cards. Each PR links its card in the description.
- A task is done when the card's expected outcome and the Definition of Done in `CONTRIBUTING.md` are both met.
- Work on a short-lived branch (`feature/`, `fix/`, `docs/`, `exp/`, `chore/`) and open a PR. Never commit to `main`.

## Conventions

- Planned layout: `missions/`, `verifier/`, `diversification/`, `attacks/`, `experiments/`, `scripts/`, `results/`, `docs/`, `tests/`.
- The verifier returns PASS only with clear evidence, FAIL only with evidence of a violation, and INCONCLUSIVE when evidence is missing or unreadable. It never passes by default.
- Tolerances and units come from configuration, not hard-coded numbers.
- Seed all randomness. Every experiment writes a run record: commit, PX4 version, parameters, mission, seed, and the model and prompt for generated variants.
- Small sample logs live in `tests/fixtures/`. Raw logs and results don't go in git.

## Boundaries

**Always**
- Run the full check command before calling a task done, once it exists.
- Keep changes to the scope of the linked card.
- Say what you're unsure about rather than guessing.

**Ask first**
- Adding or upgrading dependencies.
- Changing the PX4 version, simulator setup, or mission definitions.
- Changing verifier pass/fail criteria or tolerances.
- Editing CI workflows, repo settings, or anything partner-facing.
- Structural changes. These need an ADR in `docs/adr/` before code.

**Never**
- Commit to `main`, force-push, or skip review.
- Edit or delete tests to make them pass.
- Put credentials, `.env` contents, partner data, unpublished results, or meeting recordings into any prompt, external tool, or commit.
- Run attack or failure-injection code anywhere except the local simulation.
- Commit large files or raw flight logs.

## Confidentiality

What may go into which AI tools is set by the AI and Confidentiality section of the team charter. That section is being confirmed with our project partner. Until it is, treat Suresh's existing code, experiment results, and meeting content as restricted: use them only in tools the team has approved. Public PX4 docs, generic code, and error messages with paths and keys removed are fine anywhere.

## To be added once code exists

| What | Owner | When |
|---|---|---|
| Commands (install, test, lint, run a mission) | Gabriel | Sprint 1 (ADR 0001) |
| Simulator setup pitfalls from reproducing the baseline missions | Brendon | Sprint 1 |
| Module map and the conventions the code doesn't make obvious | Luca | After `docs/design.md` exists |
| Rules for generating LLM variants (approved API and model, where prompts are stored, cost limits) | Luca | After the partner confirms approved tools |
| Shared agent skills committed to the repo | Luca | Sprint 1 |

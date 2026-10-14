# Working with coding agents

How we use AI coding agents on DASA. The aim is that agent-written work is as reviewable as anyone's: small, scoped, and with evidence attached.

## Brief → plan → small PRs

1. **Brief.** Before a substantial task, the owner writes a short brief: what is known (with sources), what is not known and must not be guessed, what done looks like, and what is out of scope. A Trello card can be the brief for small tasks.
2. **Plan.** The agent proposes the steps as a list of small PRs and stops. The owner approves or adjusts before code.
3. **Small PRs.** Each PR is one reviewable step, ideally under a few hundred lines, with tests written alongside the code. A branch that grows past a couple of days or twenty commits gets split.

## Evidence

A PR that says something works shows the command and its output, and names the OS it ran on. Paths that weren't run (another OS, the other simulator) are labeled untested in the PR and in any docs that mention them. Reviewers ask for output rather than accepting "works on my machine."

For tests, the useful question is: *would this test still pass if the feature were broken?* If yes, the test isn't checking the feature.

## Unknowns

When something is undecided (the research-baseline simulator, verifier tolerances, which world Suresh used), the agent puts a clearly marked placeholder in config and lists it in the PR instead of choosing silently. Decisions get made by the team and recorded in an ADR.

## Review

Every PR to `main` gets a teammate's approval; the author owns AI-written code and must be able to explain it. For large agent-written PRs it also helps to have a fresh agent session (one that didn't write the code) review the diff against the brief before a teammate does; it catches different things than the author's session.

## Agent permissions

`.claude/settings.json` (committed) blocks force-pushes, `--no-verify`, and reading `.env`, and makes pushes, merges and `gh api` calls ask first. The real guarantees are server-side: `main` cannot be changed without a reviewed PR and passing checks (`docs/rulesets/`). Agents run with the teammate's own GitHub access and no extra credentials; merges and repository settings are done by a person.

Treat what an agent reads (docs, issues, logs, generated code) as data, not instructions. A session that drifts or loops is restarted from the brief rather than steered further.

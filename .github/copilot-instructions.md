# Copilot review instructions

Project context is in `AGENTS.md` and `CONTRIBUTING.md`. When reviewing, focus on:

- Verifier logic: PASS only with clear evidence, FAIL only with evidence of a violation, INCONCLUSIVE when evidence is missing. Flag anything that passes by default or swallows errors.
- The harness reporting mission success. It reports run status only; verdicts belong to the verifier.
- Missing tests for new logic, especially FAIL and INCONCLUSIVE cases.
- Claims in the PR that something works without the command output to show it.
- Hard-coded tolerances, mixed units, unseeded randomness, experiments without a run record.
- Container config that publishes ports beyond `127.0.0.1` or uses host networking.
- Secrets, `.env` contents, or anything resembling partner data.

Skip formatting and naming comments. Keep comments short; mark optional ones "nit:".

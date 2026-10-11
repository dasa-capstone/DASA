# Copilot review instructions

Project context and rules are in `AGENTS.md` and `CONTRIBUTING.md`. When reviewing pull requests, focus on:

- Verifier logic: PASS only with clear evidence, FAIL only with evidence of a violation, INCONCLUSIVE when evidence is missing or unreadable. Flag anything that passes by default or hides errors.
- Missing tests for new logic, especially FAIL and INCONCLUSIVE cases.
- Unseeded randomness and experiments without a run record.
- Inconsistent units or hard-coded tolerances.
- Secrets, keys, `.env` contents, or anything resembling partner data.

Skip formatting and minor naming comments. Keep comments short, and mark optional ones "nit:".

# `make help` lists targets. Environment targets (build, fly) are added by the environment PR.

.DEFAULT_GOAL := help
PYTHON ?= python3

.PHONY: help hooks check lint test

help:   ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-8s %s\n", $$1, $$2}'

hooks:  ## Install the pre-commit hooks (once per clone)
	pre-commit install --install-hooks

lint:   ## ruff check + format
	pre-commit run --all-files ruff-check
	pre-commit run --all-files ruff-format

# pytest exits 5 when it collects no tests. The repo has none yet, so that counts as a pass.
# Remove the `|| [ $$? -eq 5 ]` once the first real tests land, so an emptied suite fails again.
test:   ## Fast tests (no simulator)
	$(PYTHON) -m pytest -m "not sim" || [ $$? -eq 5 ]

# no-commit-to-branch only matters for commits, so it is skipped when validating (CI does the same).
check:  ## What CI runs: all hooks + fast tests. Run before opening a PR.
	SKIP=no-commit-to-branch pre-commit run --all-files --show-diff-on-failure
	$(MAKE) --no-print-directory test

# 1. help (default target)
help:
	@echo "================================================"
	@echo "       $(OWNER)/$(PROJECT_NAME) by Startr.Cloud"
	@echo "================================================"
	@echo "This is the default make command."
	@echo "This command lists available make commands."
	@echo ""
	@echo "Usage example:"
	@echo "    make show_vars"
	@echo ""
	@echo "Available make commands:"
	@echo ""
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null | \
		awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ { \
		if ($$1 !~ "^[#.]") {print $$1}}' | \
		sort | \
		grep -E -v -e '^[^[:alnum:]]' -e '^$$@$$'
	@echo ""

# 2. Dynamic variables (git-derived)
PROJECTPATH := $(shell git rev-parse --show-toplevel)
PROJECT     := $(shell echo $$(basename $(PROJECTPATH)) | tr '[:upper:]' '[:lower:]')
FULL_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
BRANCH      := $(shell echo $(FULL_BRANCH) | sed 's/.*\///' | tr '[:upper:]' '[:lower:]')
TAG         := $(shell git describe --always --tag)

# Owner and project name extracted from git remote URL
REMOTE_URL   := $(shell git config --get remote.origin.url 2>/dev/null || echo "unknown/unknown")
OWNER        := $(shell echo $(REMOTE_URL) | sed -E 's|.*[:/]([^/]+)/[^/]+(.git)?$$|\1|')
PROJECT_NAME := $(shell echo $(REMOTE_URL) | sed -E 's|.*[:/][^/]+/([^/]+)(.git)?$$|\1|' | sed 's/\.git$$//')

# Container name (used by Docker block if present)
CONTAINER := $(PROJECT)-$(BRANCH)

# 3. Load environment overrides from .env if present
-include .env

# Pull canonical distribution facts from the shared contract. Hardlinked
# from homebrew-apps/distribution.env. `-include` (vs `include`) keeps a
# fresh clone parseable before the hardlink chain has been established;
# run `make distribution_sync` once to wire it up.
-include distribution.env

# Source of truth for distribution.env (sibling repo). Override SIBLING_*
# vars if your checkout layout differs.
SIBLING_HOMEBREW ?= ../homebrew-apps
SIBLING_DOCS     ?= ../WEB-Sage.Education-docs
SIBLING_AI_UI    ?= ../WEB-AI--Sage-is-AI-UI
DIST_SOURCE      := $(SIBLING_HOMEBREW)/distribution.env

## setup_siblings — establish the distribution.env hardlink chain across siblings.
##
## Verifies all three repos are checked out side-by-side. If a sibling is
## missing, prints the exact `git clone` command and exits non-zero. If
## all three are present, calls distribution_sync to (re)establish the
## hardlinks. Idempotent — safe to re-run.
setup_siblings:
	@chmod +x tools/setup_siblings.sh
	@tools/setup_siblings.sh

## setup — fresh-machine bootstrap. Currently equivalent to setup_siblings;
## reserved for additional docs setup steps (Node deps, etc.).
setup: setup_siblings
	@echo ""
	@echo "=== Setup complete ==="

# Re-establish the distribution.env hardlink chain across the three sibling
# repos. Idempotent — `ln -f` replaces a stale copy with the hardlink to
# the canonical file. Run once after a fresh clone.
distribution_sync:
	@test -f $(DIST_SOURCE) || { \
		echo "ERROR: $(DIST_SOURCE) not found."; \
		echo "       Run 'make setup_siblings' first (or clone homebrew-apps"; \
		echo "       as a sibling: git clone https://github.com/Sage-is/homebrew-apps.git $(SIBLING_HOMEBREW))"; \
		exit 1; \
	}
	@test -d $(SIBLING_AI_UI) || { \
		echo "ERROR: $(SIBLING_AI_UI) not found."; \
		echo "       Run 'make setup_siblings' first."; \
		exit 1; \
	}
	@ln -f $(DIST_SOURCE) $(SIBLING_AI_UI)/distribution.env
	@ln -f $(DIST_SOURCE) $(SIBLING_DOCS)/distribution.env
	@$(MAKE) distribution_verify

# Verify the link-count contract + GHCR existence + upstream sync. Fails
# loudly if a sibling has drifted (e.g. an editor wrote a copy instead of
# preserving the inode), if the pinned SERVER_TAG doesn't exist on GHCR,
# or if SERVER_TAG is out of sync with AI-UI's latest release.
# BSD/GNU stat compat: `-f "%l"` on macOS, `-c "%h"` on Linux.
distribution_verify: check_upstream
	@for f in $(DIST_SOURCE) $(SIBLING_AI_UI)/distribution.env $(SIBLING_DOCS)/distribution.env; do \
		links=$$(stat -f "%l" "$$f" 2>/dev/null || stat -c "%h" "$$f"); \
		if [ "$$links" != "3" ]; then \
			echo "FAIL: $$f has $$links links, expected 3"; \
			echo "  Run 'make distribution_sync' to re-establish the chain."; \
			exit 1; \
		fi; \
	done
	@echo "OK: distribution.env hardlink chain intact (3 links)."
	@server_tag=$$(grep '^SERVER_TAG=' $(DIST_SOURCE) | cut -d= -f2); \
	image_reg=$$(grep '^IMAGE=' $(DIST_SOURCE) | cut -d= -f2); \
	echo "Checking GHCR: $$image_reg:$$server_tag ..."; \
	if ! docker manifest inspect "$$image_reg:$$server_tag" >/dev/null 2>&1; then \
		echo "FAIL: $$image_reg:$$server_tag not found on GHCR."; \
		echo "  Release AI-UI first: make release_and_push_GHCR (in WEB-AI--Sage-is-AI-UI)"; \
		exit 1; \
	fi; \
	echo "OK: $$image_reg:$$server_tag verified on GHCR."

## check_upstream — compare local SERVER_TAG against AI-UI's latest GitHub release.
##
## Exits 0 when in sync, 1 when SERVER_TAG is ahead of upstream (would ship
## docs pinned to a server that doesn't exist), 2 when SERVER_TAG lags behind.
## WARN_LAG=1 allows the lag case (intentional LTS lane / frozen workshop).
##
## No `gh` / `jq` dep — pure curl + sed + sort -V. Rate limit: 60 req/hour
## per IP unauthenticated; fine for manual + release-gate usage.
check_upstream:
	@upstream=$$(curl -fsSL "https://api.github.com/repos/Sage-is/AI-UI/tags?per_page=100" 2>/dev/null \
	             | grep -E '"name"' \
	             | sed -E 's/.*"v?([^"]+)".*/\1/' \
	             | sort -V | tail -1); \
	[ -n "$$upstream" ] || { echo "ERROR: could not fetch AI-UI tags from GitHub"; exit 1; }; \
	current=$$(grep ^SERVER_TAG= $(DIST_SOURCE) | cut -d= -f2); \
	if [ "$$current" = "$$upstream" ]; then \
	  echo "OK: SERVER_TAG=$$current matches AI-UI latest"; \
	elif printf '%s\n%s\n' "$$upstream" "$$current" | sort -V -C; then \
	  echo "ERROR: SERVER_TAG=$$current is ahead of AI-UI latest ($$upstream)"; \
	  echo "       Cannot ship docs pinned to a server that doesn't exist yet."; \
	  exit 1; \
	else \
	  echo "WARN: SERVER_TAG=$$current lags AI-UI latest ($$upstream)"; \
	  echo "      Run AI-UI '_pin_server_tag' to bump, or set WARN_LAG=1 to allow lag."; \
	  [ "$$WARN_LAG" = "1" ] || exit 2; \
	fi

# 4. show_vars (debug helper)
show_vars:
	@echo "=== Dynamic Variables ==="
	@echo "PROJECTPATH=$(PROJECTPATH)"
	@echo "PROJECT=$(PROJECT)"
	@echo "OWNER=$(OWNER)"
	@echo "PROJECT_NAME=$(PROJECT_NAME)"
	@echo "FULL_BRANCH=$(FULL_BRANCH)"
	@echo "BRANCH=$(BRANCH)"
	@echo "TAG=$(TAG)"
	@echo "CONTAINER=$(CONTAINER)"
	@echo "REMOTE_URL=$(REMOTE_URL)"
	@echo ""

# 5. Git-flow-next release/hotfix flow
require_gitflow_next:
	@if ! git flow version 2>/dev/null | grep -q 'git-flow-next'; then \
		echo "Error: git-flow-next required (Go rewrite). Install: brew install git-flow-next"; \
		exit 1; \
	fi

require_tag:
	@if [ -z "$$(git tag --sort=-v:refname | head -n 1)" ]; then \
		echo "Error: no existing tags found. Run 'make initial_release' first."; \
		exit 1; \
	fi

initial_release: require_gitflow_next
	# Create the first release (v0.1.0) — use this when no tags exist yet
	@if [ -n "$$(git tag --sort=-v:refname | head -n 1)" ]; then \
		echo "Error: tags already exist ($$(git tag --sort=-v:refname | head -n 1)). Use minor_release, patch_release, or major_release instead."; \
		exit 1; \
	fi
	git flow release start 0.1.0 && echo "or use 'make release_finish' to finish the release"

minor_release: require_gitflow_next require_tag
	@-$(MAKE) check_upstream  # advisory only; release_finish is the real gate
	# Start a minor release with incremented minor version
	git flow release start $$(git tag --sort=-v:refname | sed 's/^v//' | head -n 1 | awk -F'.' '{print $$1"."$$2+1".0"}') && echo "or use 'make release_finish' to finish the release"

patch_release: require_gitflow_next require_tag
	@-$(MAKE) check_upstream  # advisory only; release_finish is the real gate
	# Start a patch release with incremented patch version
	git flow release start $$(git tag --sort=-v:refname | sed 's/^v//' | head -n 1 | awk -F'.' '{print $$1"."$$2"."$$3+1}') && echo "or use 'make release_finish' to finish the release"

major_release: require_gitflow_next require_tag
	@-$(MAKE) check_upstream  # advisory only; release_finish is the real gate
	# Start a major release with incremented major version
	git flow release start $$(git tag --sort=-v:refname | sed 's/^v//' | head -n 1 | awk -F'.' '{print $$1+1".0.0"}') && echo "or use 'make release_finish' to finish the release"

hotfix: require_gitflow_next require_tag
	@-$(MAKE) check_upstream  # advisory only; hotfix_finish is the real gate
	# Start a hotfix with incremented n.n.n.n version (incrementing the fourth number)
	git flow hotfix start $$(git tag --sort=-v:refname | sed 's/^v//' | head -n 1 | awk -F'.' '{print $$1"."$$2"."$$3"."$$4+1}') && echo "or use 'make hotfix_finish' to finish the hotfix"

bump:
	# Update package.json version to match current release/* or hotfix/* branch
	@VER=$$(echo $(FULL_BRANCH) | sed -n 's|^release/||p; s|^hotfix/||p'); \
	if [ -z "$$VER" ]; then \
		echo "Error: not on a release/* or hotfix/* branch (current: $(FULL_BRANCH))"; \
		exit 1; \
	fi; \
	echo "Bumping version to $$VER"; \
	sed -i '' 's|"version": *"[^"]*"|"version": "'$$VER'"|' package.json; \
	echo "Updated package.json:"; \
	grep '"version"' package.json

release_finish: require_gitflow_next distribution_verify
	git flow release finish && git push origin develop && git push origin master && git push --tags && git checkout develop

hotfix_finish: require_gitflow_next distribution_verify
	git flow hotfix finish && git push origin develop && git push origin master && git push --tags && git checkout master

# 6. things_clean
things_clean:
	git clean --exclude='!.env*' -Xdf

# 7. .PHONY declarations
.PHONY: help show_vars require_gitflow_next require_tag \
	initial_release minor_release patch_release major_release hotfix \
	bump release_finish hotfix_finish things_clean \
	setup setup_siblings distribution_sync distribution_verify check_upstream

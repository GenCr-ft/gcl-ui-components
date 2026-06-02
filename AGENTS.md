---
docId: ENG-AGEN-006
title: AGENTS.md - gcl-ui-components
version: 1.1.0
authors:
- Architecture Lead
- Claude Sonnet 4.6
reviewers: []
creation_date: '2026-05-11'
language: en
summary: Per-repo onboarding guide for AI agents working on the gcl-ui-components stub library. ON ICE — explicit activation gates required before any implementation.
last_updated_date: '2026-06-02'
knowledgeGuardian:
- Béatrice (GCT-MGT-SPM-001)
metadata:
  lifecycle-stage: draft
  keywords:
  - orientation
  - guide
  - agent-instructions
  - ui
  - components
  - typescript
  - activation-gate
  - on-ice
  scope: project-aethel
  domain: engineering
  doc-type: orientation-guide
  intended-audience:
  - ai-agents
  - contributors
  security-classification: l2_confidential
ssot_path: gcl-ui-components/AGENTS.md
---
# AGENTS.md — gcl-ui-components

## STATUS: ON ICE — Do Not Activate Without Explicit Instructions

> **This repository is blocked.** Do not write any implementation code, add source files,
> or open implementation PRs until ALL three activation gates below are cleared.
> Architecture decision: ENG-ADR-068 (merged 2026-05-12).

### Activation Gates (all three required)

| Gate | Status | Location |
|------|--------|---------|
| **ENG-ADR-07x** — UI framework selection ADR approved | NOT YET WRITTEN | `gcp-aethel-architecture/` |
| **GAM-SPEC-049** — XP Leveling MVP spec approved | NOT YET APPROVED | `gcp-aethel-docs-gdd/` |
| **GAM-SPEC-066** — Inventory System spec approved | ✅ CLEARED — approved docs-gdd#40, merged 2026-05-26 | `gcp-aethel-docs-gdd/` |

When all three are approved, remove this section and implement a full AGENTS.md following
the workspace AGENTS.md pattern. The first implementation slice is described in `CLAUDE.md`.

---

## Project Overview

Shared UI component library for the Aethel platform. Currently a **stub** — no implementation yet. This library will provide reusable UI components shared across Aethel's web-facing surfaces.

**Phase status:** On ice per ENG-ADR-068 — implementation blocked on ENG-ADR-07x + GDD approvals.

## Quick Commands

| Task | Command |
|------|---------|
| Set up dev environment | `./onboard.sh` |
| Run tests | `./test.sh` |

## Architecture

```
gcl-ui-components/
  src/           — TypeScript/UI source (empty — Phase 5+ work)
  tests/         — Test files (empty — Phase 5+ work)
  package.json   — devDependencies only (commitlint)
```

## Critical Patterns

**Stub status:** No source, test files, or test framework configured yet. `./test.sh` prints "no tests yet" and exits 0. Do not write any implementation until Phase 5 work items are assigned.

## Known Issues

| Ref | Description |
|-----|-------------|
| Phase 5 | No implementation yet — stub only |

## Commit & PR Conventions

- Conventional Commits v1.0.0. Branch: `feat/`, `fix/`, `test/`, `chore/`.
- Co-author trailer: Strictly prohibited in this workspace due to administrative blocks. Do NOT write or push commits containing the `Co-Authored-By` trailer.

## Gap Protocol

Any gap, defect, or action item found while working in this repo **must become a GitHub Issue before proceeding** — nothing lives only in conversation context or memory.

```bash
# Route: engineering/game bugs and improvements → gcp-aethel-backlog
gh issue create --repo GenCr-ft/gcp-aethel-backlog \
  --title "[gcl-ui-components] Short description of the gap" \
  --body "## Summary

## Evidence

## Ref
ENG-BACK-NNN (if known)"

# Immediately add to Project #16:
gh project item-add 16 --owner GenCr-ft --url <issue-url>
```

Full routing table: workspace `AGENTS.md §9 — Gap Identification Protocol`.

## Orchestration

**Status:** ✅ Migrated — Stage 2 (2026-05-18)

This repo follows the Software Factory routing (workspace `CLAUDE.md §Orchestration Routing`):
- This AGENTS.md is the authoritative source for stack, commands, and file boundaries.
- Shared skills are available via `~/.claude/skills/` (symlinked from `gcs-plt-gemop/skills/`).
- Enforcement hooks are registered in `.claude/settings.json`.

### Relevant Skills

| Skill | Purpose |
|-------|---------|
| `review-pr` | Technical code review of a pull request |
| `pr-lifecycle` | Open, push, and manage PRs end-to-end |
| `gencraft-git-workflow` | GenCr@ft branching and commit conventions |
| `jest-unit-testing-typescript` | Jest unit test patterns for TypeScript |
| `adr-authoring` | Writing Architecture Decision Records (framework decision pending) |
| `decision-advisor` | Structured analysis of architectural decisions |

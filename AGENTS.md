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
last_updated_date: '2026-05-12'
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
| **GAM-SPEC-066** — Inventory System spec approved | NOT YET APPROVED | `gcp-aethel-docs-gdd/` |

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
- AI commits: `Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>`

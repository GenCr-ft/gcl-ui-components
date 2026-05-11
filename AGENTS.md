---
docId: ENG-AGEN-006
title: AGENTS.md - gcl-ui-components
version: 1.0.0
authors:
- Architecture Lead
reviewers: []
creation_date: '2026-05-11'
language: en
summary: Per-repo onboarding guide for AI agents working on the gcl-ui-components stub library.
last_updated_date: '2026-05-11'
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

## Project Overview

Shared UI component library for the Aethel platform. Currently a **stub** — no implementation yet. Phase 5+ work. This library will provide reusable UI components shared across Aethel's web-facing surfaces.

**Phase status:** Stub — implementation begins in Phase 5+.

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

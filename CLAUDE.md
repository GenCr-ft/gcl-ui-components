---
docId: ENG-GUID-012
title: CLAUDE.md - UI Components Orientation
version: 1.0.0
authors:
- Architecture Lead
reviewers: []
creation_date: '2026-05-10'
language: en
summary: Technical orientation guide for AI agents and contributors working on the shared Godot UI components.
last_updated_date: '2026-05-10'
knowledgeGuardian:
- Béatrice (GCT-MGT-SPM-001)
metadata:
  lifecycle-stage: draft
  keywords:
  - orientation
  - guide
  - development
  - agent-instructions
  - godot-ui
  - control-nodes
  scope: project-aethel
  domain: engineering
  doc-type: orientation-guide
  intended-audience:
  - ai-agents
  - contributors
  security-classification: l2_confidential
ssot_path: gcl-ui-components/CLAUDE.md
---
# CLAUDE.md — gcl-ui-components

## Project Overview

Pre-implementation stub for the shared UI component library for the Aethel multiplayer voxel RPG. Will provide reusable visual primitives (buttons, modals, tooltips), game HUD components (health bar, action slots, minimap), inventory UI, design tokens, and menu/navigation components. Framework decision (React + Vite, Svelte, Vue, or web components) is pending an ADR in `gcp-aethel-architecture` (ENG-BACK-007-01). No source code exists yet.

## Current State

**Empty stub.** Governance scaffolding only:

| File | Purpose |
|------|---------|
| `.pre-commit-config.yaml` | Studio-canonical pre-commit hooks |
| `.markdownlint.yaml`, `.yamllint.yaml` | Lint rules |
| `.gitignore` | Multi-stack gitignore |
| `commitlint.config.js` | Conventional Commits enforcement |
| `package.json` | Defines `@gencraft/gcl-ui-components` package name, devDeps for commitlint |
| `.github/workflows/ssot-compliance.yml` | SSoT compliance CI |

## Activation Conditions

Treat this repo as blocked until a framework ADR is approved. Before writing implementation code, confirm:

1. UI framework choice
2. Build and package toolchain
3. Preview/documentation tooling
4. Accessibility baseline
5. Consumer integration targets

## Expected First Implementation Slice

Once activated, the first delivery should include:

```text
src/ or packages/         component source
stories/ or .storybook/   interactive previews
tests/                    component and accessibility tests
tokens/                   design tokens or theme primitives
```

## CI/CD & Required Checks

SSoT compliance workflow validates frontmatter on every push/PR.

## Commit & PR Conventions

- Conventional Commits v1.0.0, enforced by commitlint.
- Branch naming: `feat/`, `fix/`, `docs/`, `chore/`, `refactor/`, `test/`, `ci/`.
- Every PR requires a linked GitHub Issue.
- AI commits: `Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>`

## Notes for Agents

- **Do not write any component code** before the framework ADR is approved in `gcp-aethel-architecture`.
- When implementation begins: all components must be WCAG 2.1 AA accessible and include Storybook stories.
- This library is consumed by `gcp-aethel-client` (Godot overlay UI) and potentially other Aethel front-ends — keep dependencies minimal.
- Keep README human-facing and move exhaustive dev-tooling guidance here once the repo becomes active.
- Prefer primitives, tokens, and documented composition patterns before large feature-specific components.
- All Markdown files must carry valid SSoT YAML frontmatter.

---
docId: GCL-READ-007
title: gcl-ui-components
version: 0.1.0
authors:
- Architecture Lead
reviewers:
- Client Lead
- Architecture Lead
creation_date: '2026-04-29'
last_updated_date: '2026-05-05'
language: en
summary: >
  Shared UI component library for the Aethel platform. Pre-implementation stub.
  Framework decision (React / Vue / Svelte) is pending an ADR in gcp-aethel-architecture
  before any src/ code is written.
knowledgeGuardian:
- Architecture Lead
metadata:
  lifecycle-stage: draft
  keywords:
  - ui-components
  - shared-library
  - stub
  scope: project-aethel
  domain: engineering
  doc-type: readme
  intended-audience:
  - contributors
  - ai-agents
  security-classification: l2_confidential
---
# gcl-ui-components

> Shared UI component library for the Aethel multiplayer voxel RPG.
> **Pre-implementation stub** — framework decision pending (see ENG-BACK-007-01).

## Overview

This repository will house the shared UI component library for Aethel. Its responsibilities will include:

- Reusable visual primitives (buttons, modals, tooltips, badges)
- Game HUD components (health bar, mana bar, action slots, minimap)
- Inventory UI components (inventory grid, item slots, item tooltips)
- Menu and navigation components (main menu, settings panel, character sheet)
- Design tokens (color palette, typography, spacing, animation easing)

**Current state:** Empty stub. No UI framework or build toolchain has been decided. This library is the visual consistency layer — without it, each consumer will independently implement conflicting UI patterns.

The framework decision (React + Vite, Svelte, Vue, or framework-less web components) must be captured as an ADR in `gcp-aethel-architecture` before any `src/` code is written. See REMEDIATION.md §3.2 for the open decision blocking implementation.

## Repository Contents

- `.pre-commit-config.yaml` — Studio-canonical pre-commit hook configuration
- `.markdownlint.yaml`, `.yamllint.yaml` — Markdown and YAML linting rules
- `.gitignore` — Multi-stack gitignore
- `commitlint.config.js` — Conventional Commits enforcement
- `.github/workflows/ssot-compliance.yml` — SSoT compliance CI workflow

## AI Instructions

**Purpose for AI Agents:**

- This repository is a pre-implementation stub. Do not attempt to install or run it as a library.
- When implementation begins, the framework decision (React, Vue, Svelte, etc.) and build toolchain must be documented as an ADR before any component work begins.
- All components must be accessible (WCAG 2.1 AA) and include Storybook stories for review.

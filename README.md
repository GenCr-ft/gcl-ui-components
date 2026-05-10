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
last_updated_date: '2026-05-10'
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

Shared UI component library for the Aethel platform.

## Overview

This repository is intended to house the shared visual primitives and interface patterns used across the Aethel ecosystem. Its target audience is the future frontend and UX implementation team responsible for consistent HUD, inventory, and portal UI behavior.

The repo is currently a placeholder: there is no component implementation yet, and the first delivery is blocked on a framework decision.

## Planned Scope

If activated, this library is expected to cover:

- **Visual Primitives**: Buttons, modals, tooltips, and badges.
- **Game HUD**: Health/Mana bars, action slots, and minimap components.
- **RPG UI**: Inventory grids, item tooltips, and character sheets.
- **Design Tokens**: Color palettes, typography, and spacing systems.

## Project Status

> ⚠️ **Status: Pre-implementation Stub**
>
> Implementation is currently pending a framework decision. No source code has been written yet. See `REMEDIATION.md §3.2` for the open decision blocking this project.

## What Exists Today

This repository currently contains governance scaffolding only:

- repository linting and commit policies
- SSoT compliance workflow
- package naming placeholder in `package.json`

There is no install, build, test, or usage path yet because there is no component code.

## When This Repo Becomes Active

Before adding components, confirm:

```text
1. The UI framework and packaging strategy are approved.
2. The primary consumers are defined.
3. Storybook or equivalent preview tooling is selected.
4. Accessibility and design-token requirements are documented.
```

## Contributing

Do not add framework-specific implementation code until the blocking decision is resolved. Contributions are currently limited to governance, planning, and ADR-supporting documentation work.

---

*For technical specifications and developer guidelines, see [AGENTS.md](./AGENTS.md).*

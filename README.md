---
docId: GCL-READ-007
title: gcl-ui-components
version: 0.1.1
authors:
- Architecture Lead
reviewers:
- Client Lead
- Architecture Lead
creation_date: '2026-04-29'
last_updated_date: '2026-05-10'
knowledgeGuardian:
- Béatrice (GCT-MGT-SPM-001)
metadata:
  lifecycle-stage: approved
  keywords:
  - ui-components
  - shared-library
  - godot-ui
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

This repository houses the shared visual primitives and interface patterns used across the Aethel ecosystem. It provides consistent HUD, inventory, and menu behaviors for the Godot-based client applications.

**Technology Stack:** Godot 4 Control Nodes (ENG-ADR-056).

## Scope

This library covers:

- **Visual Primitives**: Standardized Control nodes for buttons, modals, and tooltips.
- **Game HUD**: Health/Stamina bars, action slots, and adaptive minimap components.
- **RPG UI**: Inventory grids, item tooltips, and character sheet layouts.
- **Design Tokens**: Centralized Godot Theme resources for colors, fonts, and styles.

## Project Status

- **ON ICE** — implementation blocked per ENG-ADR-068. No component code may be written until all activation gates in [AGENTS.md](./AGENTS.md) are cleared.
- Activation requires: ENG-ADR-07x (UI framework ADR), GAM-SPEC-049 (XP Leveling), and GAM-SPEC-066 (Inventory System) all approved.

## What Exists Today

This repository contains:

- **SSoT Compliance**: Automated metadata and linting validation.
- **Governance**: Commit and branching policies aligned with studio standards.
- **Orientation**: Standardized [CLAUDE.md](./CLAUDE.md) for agent assistance.

## Quick Start

```bash
./onboard.sh   # install dependencies (idempotent)
./test.sh      # run tests (no tests yet — stub exits 0)
```

## Contributing

Follow the studio conventions defined in the [Engineering Handbook](../gcs-engineering-handbook). Framework decision (React/Svelte/Vue/web components) is pending an ADR — do not write component code until that is approved.

---

*For technical specifications and developer guidelines, see [CLAUDE.md](./CLAUDE.md).*

---
docId: GCL-READ-007
title: gcl-ui-components
version: 0.2.0
authors:
- Architecture Lead
reviewers:
- Client Lead
- Architecture Lead
creation_date: '2026-04-29'
last_updated_date: '2026-07-10'
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

This repository houses the shared visual primitives and interface patterns used across the Aethel ecosystem. It provides consistent HUD, inventory, and menu behaviors for the Godot-based client applications, packaged as a Godot addon (`addons/gcl_ui_components/`).

**Technology Stack:** Godot 4.5 · GDScript · GUT v9.3.0 (testing) · distributed as a Godot addon (`addons/gcl_ui_components/`) consumed by the client as a git submodule. Godot `Control` nodes are the mandatory rendering substrate (ENG-ADR-056), per the UI-framework decision **ENG-ADR-089**.

## Scope

This library covers:

- **Visual Primitives**: Standardized Control nodes for buttons, modals, and tooltips.
- **Game HUD**: Health/Stamina bars, action slots, and adaptive minimap components.
- **RPG UI**: Inventory grids, item tooltips, and character sheet layouts.
- **Design Tokens**: Centralized Godot Theme resources for colors, fonts, and styles.

## Project Status

- **Active** — the ON-ICE freeze was lifted per **ENG-ADR-089** (UI Framework Selection, approved 2026-07-10), which supersedes-in-part ENG-ADR-068's freeze clause for this repository.
- All activation gates are satisfied: ENG-ADR-089 (governing UI-framework ADR) and GAM-SPEC-066 (Inventory) are approved; GAM-SPEC-049 (XP Leveling) is gate-waived for this scope (no XP-dependent UI is built here). See [AGENTS.md](./AGENTS.md) for the full gate table.
- Metadata is unfrozen in this slice; the Godot addon skeleton (`plugin.cfg`, base Theme, UI-descriptor schema, GUT harness) is bootstrapped in a follow-up work item.

## What Exists Today

This repository contains:

- **SSoT Compliance**: Automated metadata and linting validation.
- **Governance**: Commit and branching policies aligned with studio standards.
- **Orientation**: Standardized [AGENTS.md](./AGENTS.md) for agent assistance.

## Quick Start

```bash
./onboard.sh   # install dependencies (idempotent)
./test.sh      # run tests (no tests yet — stub exits 0)
```

## Contributing

Follow the studio conventions defined in the [Engineering Handbook](../gcs-engineering-handbook). The UI-framework decision is settled by **ENG-ADR-089**: components are Godot 4.5 `Control` nodes authored in GDScript and tested with GUT v9.3.0. Web frameworks (React/Svelte/Vue/web components) were formally rejected in that ADR.

---

*For technical specifications and developer guidelines, see [AGENTS.md](./AGENTS.md).*

# gcl-ui-components

> Shared UI component library for the Aethel multiplayer voxel RPG (implementation pending — see REMEDIATION.md §3.2).

## Overview

This repository will house the shared UI component library for Aethel. Its responsibilities will include:

- Reusable visual primitives (buttons, modals, tooltips, badges)
- Game HUD components (health bar, mana bar, action slots, minimap)
- Inventory UI components (inventory grid, item slots, item tooltips)
- Menu and navigation components (main menu, settings panel, character sheet)
- Design tokens (color palette, typography, spacing, animation easing)

**Current state:** Empty stub. No UI framework or build toolchain has been decided. This library is the visual consistency layer — without it, each consumer will independently implement conflicting UI patterns.

See REMEDIATION.md §3.2 for the open decision blocking implementation.

## Repository Contents

- `.pre-commit-config.yaml` — Studio-canonical pre-commit hook configuration
- `.markdownlint.yaml`, `.yamllint.yaml` — Markdown and YAML linting rules
- `.gitignore` — Multi-stack gitignore
- `commitlint.config.js` — Conventional Commits enforcement
- `.github/workflows/ssot-compliance.yml` — SSoT compliance CI workflow

## IA Instructions

**Purpose for AI Agents:**

- This repository is a pre-implementation stub. Do not attempt to install or run it as a library.
- When implementation begins, the framework decision (React, Vue, Svelte, etc.) and build toolchain must be documented as an ADR before any component work begins.
- All components must be accessible (WCAG 2.1 AA) and include Storybook stories for review.
  
  

---
docId: ENG-AGEN-006
title: AGENTS.md - gcl-ui-components
version: 1.2.0
authors:
- Architecture Lead
- Claude Sonnet 4.6
reviewers: []
creation_date: '2026-05-11'
language: en
summary: Per-repo onboarding guide for AI agents working on the gcl-ui-components shared UI library. Freeze lifted per ENG-ADR-089 (approved 2026-07-10); Godot 4.5 GDScript addon consumed as a submodule.
last_updated_date: '2026-07-10'
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
  - godot
  - gdscript
  - gut
  - addon
  scope: project-aethel
  domain: engineering
  doc-type: orientation-guide
  intended-audience:
  - ai-agents
  - contributors
  security-classification: l0_public
ssot_path: gcl-ui-components/AGENTS.md
---
# AGENTS.md — gcl-ui-components

## STATUS: ACTIVE — Freeze Lifted per ENG-ADR-089

> The ON-ICE freeze imposed by ENG-ADR-068 has been **lifted**. The governing decision is
> **ENG-ADR-089** (UI Framework Selection, `lifecycle-phase: approved`, 2026-07-10), which
> *supersedes-in-part* the `gcl-ui-components` clause of ENG-ADR-068. This repository is
> now a shared **spec + asset library** for the Aethel Godot client, not a web/TypeScript
> component library.
>
> Metadata is unfrozen here (US #415). The structural addon bootstrap — `plugin.cfg`,
> `plugin.gd`, placeholder `themes/aethel_base.tres`, `schemas/ui_descriptor.v0.1.schema.json`,
> and the GUT harness — is delivered separately in **US #416** (design captured in
> `[DESIGN]` sub-issue gcs-project-management#505).

### Activation Gates — all satisfied

| Gate | Resolution |
|------|-----------|
| **ENG-ADR-07x** (= **ENG-ADR-089**) — UI framework ADR approved | ✅ MERGED / approved 2026-07-10 — supersedes-in-part ENG-ADR-068's freeze clause |
| **GAM-SPEC-066** — Inventory System spec approved | ✅ CLEARED — approved docs-gdd#40, merged 2026-05-26 |
| **GAM-SPEC-049** — XP Leveling MVP spec approved | ✅ GATE-WAIVED-FOR-SCOPE — Beatrice product ruling on gcs-project-management#505 (2026-07-10): F0.2 builds no XP-dependent UI. GAM-SPEC-049 remains a product gate for any future XP-related UI work item (XP/progress bar, level-up modal, attribute-point allocation screen). |

---

## Project Overview

Shared UI component library for the Aethel platform, delivered as a **Godot 4.5 addon**
(`addons/gcl_ui_components/`). It provides a base `Theme` resource + design tokens, reusable
`Control`-scene templates, GDScript/GUT conventions, and a declarative, runtime-loadable
UI-descriptor contract (the P-MOD / UGC non-preclusion anchor). Godot `Control` nodes are the
mandatory rendering substrate (per ENG-ADR-056 + ENG-ADR-089).

**Consumption model:** the addon is consumed by `gcp-aethel-client` as a **git submodule** pinned
at `vendor/gcl-ui-components/`, materialised into `res://addons/gcl_ui_components/` by the client's
`onboard.sh` (mirroring the existing `vendor/gut/` pattern). Per Isaac's architectural decision on
gcs-project-management#505, the pinned submodule SHA in `.gitmodules` is the single source of truth
for the vendored version; the materialised addon directory is a build artefact and is `.gitignore`d
downstream.

**Phase status:** Active. This metadata slice (US #415) lifts the freeze; the addon skeleton lands in US #416.

## Quick Commands

| Task | Command |
|------|---------|
| Set up dev environment | `./onboard.sh` |
| Run tests | `./test.sh` |

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Engine | Godot 4.5 |
| Language | GDScript |
| Testing | GUT v9.3.0 (headless) |
| Distribution | Godot addon (`addons/gcl_ui_components/`), consumed as a git submodule |

## Architecture

Target layout once the addon skeleton lands (US #416 — see `[DESIGN]` gcs-project-management#505):

```
gcl-ui-components/
  addons/
    gcl_ui_components/
      plugin.cfg       — Godot addon metadata
      plugin.gd        — minimal EditorPlugin entrypoint
      themes/          — base Theme resource + design tokens (values owned by Pixel, F0.3)
      scenes/          — reusable Control scene templates (.tscn)
      schemas/         — declarative UI-descriptor JSON Schema (Draft 2020-12)
      tests/           — GUT headless test suites
  project.godot        — minimal Godot 4.5 project root (required for GUT headless)
  test.sh              — delegates to the GUT headless runner
```

## Critical Patterns

**Metadata unfrozen; addon not yet bootstrapped.** As of US #415 the freeze is lifted and this
AGENTS.md + README.md reflect the Godot/GDScript direction, but no `addons/`, `project.godot`, or
source files exist yet — they land in US #416. `./test.sh` still prints "no tests yet" and exits 0
until the GUT harness is committed in #416; do not change `test.sh` in the metadata slice.

**Godot 4.5 rendering substrate.** All components are Godot `Control` nodes (ENG-ADR-056 + ENG-ADR-089).
Do not introduce web frameworks (React/Svelte/Vue/web components) — that alternative was formally
rejected in ENG-ADR-089.

## Known Issues

| Ref | Description |
|-----|-------------|
| US #416 | Addon skeleton (`plugin.cfg`/`plugin.gd`/`themes`/`schemas`/GUT harness) not yet committed |

## Commit & PR Conventions

- Conventional Commits v1.0.0. Branch: `feat/`, `fix/`, `test/`, `chore/`.
- Co-author trailer: Strictly prohibited per workspace policy. Do NOT write or push commits containing the `Co-Authored-By` trailer.

## Gap Protocol

Any gap, defect, or action item found while working in this repo **must become a GitHub Issue before proceeding** — nothing lives only in conversation context or memory.

Write the payload to a file first. `gft` reads the title and body from it, and inlining prose in a shell command is an unallowlistable permission escalation (workspace `AGENTS.md` §4). Payload files belong in `.agent-scratch/`.

```yaml
# .agent-scratch/<slug>.yaml
title: "[gcl-ui-components] Short description of the gap"
body: |
  ## Summary

  ## Evidence

  ## Ref
  ENG-BACK-NNN (if known)
```

```bash
# Route: engineering/game bugs and improvements → gcp-aethel-backlog
gft issue create --repo GenCr-ft/gcp-aethel-backlog --input .agent-scratch/<slug>.yaml
```

Then add it to Project #16 — never skip this step:

```yaml
# .agent-scratch/<slug>-board.yaml
project: 16
owner: GenCr-ft
url: <issue-url>
```

```bash
gft project item-add --input .agent-scratch/<slug>-board.yaml
```

Full routing table: workspace `AGENTS.md §9 — Gap Identification Protocol`.

## Orchestration

**Status:** ✅ Migrated — Stage 2 (2026-05-18)

This repo follows the Software Factory routing (workspace `AGENTS.md §Orchestration Routing`):
- This AGENTS.md is the authoritative source for stack, commands, and file boundaries.
- Shared skills are available via `~/.claude/skills/` (symlinked from `gcs-plt-gemop/skills/`).
- Enforcement hooks are registered in `.claude/settings.json`.

### Relevant Skills

| Skill | Purpose |
|-------|---------|
| `review-pr` | Technical code review of a pull request |
| `pr-lifecycle` | Open, push, and manage PRs end-to-end |
| `gencraft-git-workflow` | GenCr@ft branching and commit conventions |
| `gut-testing-godot45` | GUT v9.3.0 unit test patterns for GDScript in Godot 4.5 |
| `adr-authoring` | Writing Architecture Decision Records (framework settled in ENG-ADR-089) |
| `decision-advisor` | Structured analysis of architectural decisions |

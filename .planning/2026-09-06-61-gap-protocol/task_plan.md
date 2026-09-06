---
docId: GOV-PLAN-61
title: '[CODE] WI-61.1 — re-render AGENTS.md Gap Protocol from the corrected template'
version: 1.0.0
authors: [Studio Operations]
creation_date: '2026-09-06'
last_updated_date: '2026-09-06'
language: en
issue-id: GenCr-ft/gcl-ui-components#61
status: complete
summary: >-
  Re-render this repository's generated AGENTS.md so its Gap Protocol documents the executable
  gft recipe instead of raw gh mutations that the raw-gh-guardrail hook denies.
metadata:
  lifecycle-stage: draft
  scope: workspace-ops
  domain: engineering
  doc-type: plan
  security-classification: l2_confidential
  keywords: [agents-md, gap-protocol, generator, raw-gh-guardrail]
---

# [CODE] WI-61.1 — re-render AGENTS.md Gap Protocol from the corrected template

## Why

This repository's `AGENTS.md` documented its Gap Protocol as raw `gh` mutations, which the
workspace `raw-gh-guardrail` `PreToolUse` hook **denies** — so an agent following this
repository's own documented protocol was blocked **for complying with it**.

Parent work item: [GenCr-ft/gcs-plt-gemop#549](https://github.com/GenCr-ft/gcs-plt-gemop/issues/549).

## What changed

Nothing hand-edited. `AGENTS.md` is generated from
`gcs-plt-gemop/templates/AGENTS.repo.md.template` plus this repository's delta; the corrected Gap
Protocol landed **once** in that template as keystone PR
[gcs-plt-gemop#565](https://github.com/GenCr-ft/gcs-plt-gemop/pull/565) (merged `7e27425`). This
commit is that single change re-rendered here.

## Verification

Rendered in a worktree branched from this repository's `origin/main` (`4426f28`) — never a working
tree, because clones here are routinely behind or on other branches. Generator run under
`/usr/bin/python3`; the ambient `python3` is a Poetry shim without PyYAML
([gcs-plt-gemop#572](https://github.com/GenCr-ft/gcs-plt-gemop/issues/572)).

| Oracle | Result |
|---|---|
| `render_agents_md.py --check` | exit 0, 19/19 |
| `render_agents_md.py --audit-lines` | exit 0, 19/19 |
| `check_raw_gh_docs.py --deployed` | exit 0 — `scanned 1971 unit(s) … 19 of 19 render(s), 19 of 19 deployed file(s)` |

The scan count is quoted because a **zero-scan** pass also exits 0 — the count is the evidence,
not the exit code.

Diff: 1 file, `AGENTS.md`, `+25/-8`; **0** remaining `gh issue`/`gh project` recipe lines; no
changed line outside the Gap Protocol section. That purity check is not ceremonial — rendering
`gcd-shared-actions` silently reverted a version pin while all three oracles passed
([gcs-plt-gemop#573](https://github.com/GenCr-ft/gcs-plt-gemop/issues/573)).

## Lifecycle

Lightweight tier — `wi:lightweight` human-set, verified with the gate's own
`lightweight_label_honored` predicate; `✅ LIFECYCLE:REFINE-LIGHTWEIGHT:PASS` on the issue. The
adversary PR review at CLOSE runs unconditionally regardless of tier (GOV-STAN-010 §4.1).

No new tests: a pure rendered diff's correctness is the generator's `--check` exiting 0.

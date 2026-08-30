---
docId: GOV-PLAN-58
title: '[CODE] WI-58 — re-pin SSoT linter to @v1.3.8 + tooling v4.4.1'
issue-id: GenCr-ft/gcl-ui-components#58
status: complete
version: "1.0"
authors: [session-agent]
metadata:
  scope: workspace-ops
  domain: governance
  doc-type: plan
  lifecycle-stage: complete
---

# [CODE] WI-58 — re-pin SSoT linter to `@v1.3.8` + tooling `v4.4.1`

Wave 1 of the fleet re-pin. **The shared reasoning is recorded once, on
[gcd-shared-actions#165](https://github.com/GenCr-ft/gcd-shared-actions/issues/165) and in the REFINE
comment on #58** — not copied into 20 plan files, because 20 copies of one argument is 20 things to
drift.

## The change

```yaml
uses: …/reusable-ssot-linter.yml@v1.3.5   ->  @v1.3.8
tooling-version: "v4.3.2"                 ->  "v4.4.1"
governance-version:                       ->  UNCHANGED
```

Two single-line replacements against anchors verified unique in this file beforehand.

## Repo-specific facts

| fact | value |
|---|---|
| `continue-on-error` | **`true`** — so the known pin-rule exit 2 annotates and cannot block |
| scanned files, both pins | **1** (measured off-runner before the change) |
| `CHANGELOG.md` | present — Rule 6 entry added |

The `1` matters: it is non-zero, so the `@v1.3.6+` zero-scan guard cannot fire here. It is also the
figure to compare the post-merge run log against — a green tick alone says nothing, since across this
same bump `.github` moves from 10 files scanned to 1.

## Not changing

`governance-version` (needs a tag that does not exist —
[gcs-core-governance#357](https://github.com/GenCr-ft/gcs-core-governance/issues/357)),
`continue-on-error` (`GOV-STAN-010` §5.6), and any pre-existing findings — this repo is red today and
stays red; absorbing that here would hide it.

## Acceptance

- [x] Two pins moved; governance and gate byte-identical.
- [x] Rule 3 (this file) and Rule 6 (`CHANGELOG.md`) satisfied.
- [ ] CI **verified filtered by head SHA**, and the run log's `Linter scanned N file(s)` compared
      against the pre-bump **1**.

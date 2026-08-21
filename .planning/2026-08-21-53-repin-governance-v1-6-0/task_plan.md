---
docId: GOV-PLAN-53
title: "[CODE] WI-53 — re-pin governance-version to v1.6.0 (#320 fleet sweep)"
issue-id: GenCr-ft/gcl-ui-components#53
status: complete
version: "1.0"
authors: [session-agent]
metadata:
  scope: workspace-ops
  domain: governance
  doc-type: plan
  lifecycle-stage: complete
---

# [CODE] WI-53 — re-pin governance-version to v1.6.0

Step 3 of the sequence ratified on `gcs-core-governance#321` (Studio-Lead, 2026-08-10), retargeted to
`v1.6.0` — the terminal Law version — so this repo is not re-pinned twice.

## Measured effect on this repo: none

Same scan root, same engine (`gcd-ops-scripts@v4.3.2`), two real Law tags:

| Law | findings |
|-----|----------|
| `v1.4.0` (previous pin) | 1 |
| `v1.6.0` (this change) | **1** |

**Delta 0** over 6 markdown files. Stated plainly so a later reader does not measure this repo,
see no change, and conclude the sweep failed. Fleet-wide the sweep clears **478** findings and all
478 are in `gcp-aethel-docs-req` (475) and `gcp-aethel-architecture` (3).

## Then why re-pin

1. **The fleet was diverging.** 24 repos pinned `v1.4.0`; none consumed `v1.5.0`, tagged 2026-08-10.
   Each Law release widened the gap.
2. **A `v1.4.0` pin is ambiguous by construction.** Its meaning depends on the `uses:` tag — at
   `@<=v1.3.3` the reusable workflow clones the **archived** `gcs-devops-standards`, at `@>=v1.3.4`
   the live `gcs-core-governance` — and **both carry a `v1.4.0` tag**. That is how repos passed while
   validating retired rules (`gcd-shared-actions#125`). Moving off `v1.4.0` removes the coincidence.
3. This issue's own remediation numbers stay comparable once measured against the live Law.

## Why safe

`v1.4.0` → `v1.6.0` is purely additive — three enum entries added across two vocabularies, none
removed, verified by parsing all ten vocabularies at both tags with a synthetic-removal control. A
purely additive Law cannot make a passing document fail, and the measured 0 → 0 confirms it here.

## Out of scope

- The 1 findings themselves — this issue's own remediation scope, untouched.
- Flipping `continue-on-error` to `false`. Unchanged; under `true` a green check proves nothing.
- `#321` step 4 renames and metadata value maps.

Ref `gcs-core-governance#320`, `#321`, `#332`, `#314`, `gcs-project-management#531`,
`gcd-shared-actions#125`.

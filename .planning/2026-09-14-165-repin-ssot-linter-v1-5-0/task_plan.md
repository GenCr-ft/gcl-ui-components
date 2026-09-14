---
docId: GOV-PLAN-165
title: '[CODE] WI-165.4 — move this consumer to @v1.5.0 and normalise its version pair'
version: 1.0.0
issue-id: GenCr-ft/gcd-shared-actions#165
status: in_progress
authors: [loigallain]
creation_date: '2026-09-14'
last_updated_date: '2026-09-14'
language: en
summary: >-
  Move this repository's reusable-ssot-linter caller to @v1.5.0 and normalise its
  governance/tooling pair to the canonical pair, which the new pin-compatibility preflight
  requires.
metadata:
  lifecycle-stage: draft
  scope: studio
  domain: engineering
  doc-type: backlog
  security-classification: l2_confidential
  keywords: [wi-165, ssot-linter, version-pin, compatibility-matrix, law-version]
---

# [CODE] WI-165.4 — move this consumer to @v1.5.0 and normalise its version pair

## Why this is not the same change the other 25 consumers got

25 consumers were re-pinned by changing **one line**, because their pair was already the canonical
`v1.6.1` / `v4.4.1` recorded `rc: 0` in `policy/compatibility-matrix.yml`. This repository was
**deliberately excluded** from that sweep, because its pair is not recorded green and `v1.5.0` adds
WI-183's Pin Compatibility Preflight — which is **exempt from `continue-on-error`** and fails closed
on an unmeasured pair (exit 4) or an incompatible one (exit 5). Bumping `uses:` alone would have
turned this job hard-red.

So the pair moves in the same change. That is a change of **which Law version this repository is
validated against**, not a version bump of the CI plumbing.

## The referent hazard, where it applies

The repository that `governance-version` resolves changes with the **`uses:` tag the caller pins**,
not with the input's value (`gcd-shared-actions#125`):

| linter pin | `governance-version` resolves |
|---|---|
| `@v1.3.2` | `GenCr-ft/gcs-devops-standards` — **ARCHIVED** |
| `@v1.3.4` and above | `GenCr-ft/gcs-core-governance` — the live Law |

`.github` and `.github-private` pin **below** `v1.3.4`, so their `v1.4.0` resolves a tag of the
archived repository. Moving to `@v1.5.0` + `v1.6.1` therefore switches document set: these repos
have **never** been validated against the live Law, and findings are a realistic outcome rather
than a surprise.

## Evidence carried over, and its status

A prior session recorded: *"Measured off-runner across all 30 consumers at governance `v1.6.1` +
tooling `v4.4.1` before proposing: 30 of 30 exit 0, clean."* That covers this repository and is the
reason the move is proposed rather than deferred — but it is **INHERITED**, not re-derived here, and
it was measured off-runner. The PR's own CI run is the measurement that settles it.

## Acceptance

```gherkin
Scenario: the preflight accepts the normalised pair
  Given the pair is set to the canonical v1.6.1 / v4.4.1
  When the SSoT Compliance Check runs on this PR
  Then the Pin Compatibility Preflight passes
  And it does not exit 4 (unmeasured) or 5 (incompatible)

Scenario: the run actually validated something
  Given the check completes
  When the run log is read
  Then it states SSoT mode resolved full=true
  And it reports Linter scanned N file(s) with N greater than zero

Scenario (unhappy path): the live Law produces findings
  Given this repository has not previously been validated against gcs-core-governance
  When the linter runs against v1.6.1
  Then any findings are recorded on the parent WI before the PR is merged
  And the PR is not merged on the assumption that the move is inert
```

The third scenario is the point of opening this as a PR rather than sweeping it: a green is not
assumed, and a red here is information rather than a failure.

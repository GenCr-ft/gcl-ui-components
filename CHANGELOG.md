# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Rewrote `detect-secrets` CI step to use hashed-secret comparison (exits non-zero on new unbaselined secrets); `scan --baseline` always exits 0. (#25, @loigallain)

### Changed

- Move the SSoT linter caller to `gcd-shared-actions@v1.5.0` **and** normalise the version pair to the canonical `v1.6.1` / `v4.4.1`. These two changes are **indivisible**: `v1.5.0` carries WI-183's Pin Compatibility Preflight, which is **exempt from `continue-on-error`** and fails closed on a pair not recorded green in `policy/compatibility-matrix.yml`. This repository's previous pair (`v1.6.0` / `v4.3.2`) is recorded `rc: skipped` there - and the matrix states explicitly that `skipped` is **not** `0`: the pin rule does not exist before tooling `v4.4.0`, so this consumer was green while checking nothing. Bumping `uses:` alone would have handed a non-green pair to the new preflight, which is why this repository was held back from the 25-consumer sweep rather than swept with it. (GenCr-ft/gcd-shared-actions#165, PR #TBD, @loigallain)

- Re-render `AGENTS.md` from the corrected shared template, so the Gap Protocol documents the executable `gft` recipe with an `--input` payload file instead of raw `gh` mutations that the `raw-gh-guardrail` `PreToolUse` hook denies — an agent following this repo's own documented protocol was blocked for complying with it. Generated, **not hand-edited**: the fix landed once in the shared template (GenCr-ft/gcs-plt-gemop#565) and this is its re-render, so it cannot re-diverge on the next generator run. (#61, PR #62, @loigallain)
- Bound every `ci.yml` job with `timeout-minutes` and added a workflow `concurrency` group that cancels superseded branch runs but never `main`. (#546, @loigallain)
- Added `.secrets.baseline` and `detect-secrets==1.5.0` CI gate. (#24, @loigallain)

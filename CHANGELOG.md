# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Rewrote `detect-secrets` CI step to use hashed-secret comparison (exits non-zero on new unbaselined secrets); `scan --baseline` always exits 0. (#25, @loigallain)

### Changed

- Re-pin the SSoT linter to `gcd-shared-actions@v1.3.8` and `gcd-ops-scripts@v4.4.1`; `governance-version` and `continue-on-error` byte-identical. Delivers four releases no consumer had pinned, including the poetry pin-parity rule (`v4.4.0`) and the gdscript-fence dedent fix (`v4.4.1`). Piloted on `gcs-security-core#67`, which measured scan count 3 predicted / 3 observed and surfaced what an off-runner replication could not: the pin rule reports `FAILED CLOSED` with exit 2 because `poetry 2.4.1` is on `gcs-core-governance` main but in no tag, while the workflow checks governance out at `v1.6.0` (gcs-core-governance#357). Masked here by `continue-on-error: true`, so the annotation is visible and the job stays green. (#59, @loigallain)
- Bound every `ci.yml` job with `timeout-minutes` and added a workflow `concurrency` group that cancels superseded branch runs but never `main`. (#546, @loigallain)
- Added `.secrets.baseline` and `detect-secrets==1.5.0` CI gate. (#24, @loigallain)

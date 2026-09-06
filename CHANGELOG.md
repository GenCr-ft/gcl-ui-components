# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Rewrote `detect-secrets` CI step to use hashed-secret comparison (exits non-zero on new unbaselined secrets); `scan --baseline` always exits 0. (#25, @loigallain)

### Changed


- Re-render `AGENTS.md` from the corrected shared template, so the Gap Protocol documents the executable `gft` recipe with an `--input` payload file instead of raw `gh` mutations that the `raw-gh-guardrail` `PreToolUse` hook denies — an agent following this repo's own documented protocol was blocked for complying with it. Generated, **not hand-edited**: the fix landed once in the shared template (GenCr-ft/gcs-plt-gemop#565) and this is its re-render, so it cannot re-diverge on the next generator run. (#61, PR #62, @loigallain)
- Bound every `ci.yml` job with `timeout-minutes` and added a workflow `concurrency` group that cancels superseded branch runs but never `main`. (#546, @loigallain)
- Added `.secrets.baseline` and `detect-secrets==1.5.0` CI gate. (#24, @loigallain)

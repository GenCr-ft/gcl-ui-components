# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Rewrote `detect-secrets` CI step to use hashed-secret comparison (exits non-zero on new unbaselined secrets); `scan --baseline` always exits 0. (#25, @loigallain)

### Changed

- Added compact repo card and entry-point matrix to clarify stub status and generated outputs. (Resolves #708, @Antigravity)
- Added `.secrets.baseline` and `detect-secrets==1.5.0` CI gate. (#24, @loigallain)

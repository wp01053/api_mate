# Changelog
## [0.3.0] - 2025-04-30
### Added
- Automatic retry mechanism with `retryCount` and `retryDelay` in `ApiMateConfig`
- Per-request retry override support via constructor params
- Retry logic limited to retriable `DioException` types (connectionTimeout, receiveTimeout, etc.)

### Changed
- Improved error handling path when retry fails
- Refactored logging output for retries

### Fixed
- Minor consistency issues in logger formatting

## [0.2.3] - 2025-04-30

- Changed ReadMe.md
 
## [0.2.2] - 2025-04-30

- Added ApiMateConfig to control global logging
- Removed success/failure callbacks for cleaner flow
- Integrated ApiMateResult (sealed class)
- Added pretty logging
- Stable release
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## 0.2.0 — 2025-10-28

### Breaking Changes
- **Input namespace**: Direct access to input types now requires `HexletCode::Inputs::[InputType]` namespace.
- **Form architecture**: HTML generation moved from `FormBuilder` to dedicated `HtmlRenderer` class (see Deprecated section).

### Changed
- **Module loading**: Migrated from `require_relative` to `autoload` for core components (`HexletCode`, `Tag`, `FormBuilder`, `Version`).
- **Namespace**: Wrapped `Tag` class into `HexletCode` module.
- **HTML generation**: Simplified `Tag.build_attributes` logic:
  - Unified attribute processing (removed `input`/`regular` branching).
  - Space handling delegated to `attr_to_s`.
  - Removed redundant sorting (`sort_by`).
- **FormBuilder**: Refactored input handling:
  - Removed `@last_input` state variable.
  - `add_*` methods now return rendered HTML directly.
  - Streamlined `input` method logic.
- **Form architecture**:
  - Introduced separation between model (`FormState`) and renderer (`HtmlRenderer`).
  - Moved form field collection to `FormBuilder`.
  - Fixed dependency loading via `require_relative`.


### Fixed
- **HTML output**: Removed extra leading space in form attributes (e.g., `<form  action=...>` → `<form action=...>`).
- **Syntax**: Corrected `block.given?` → `block_given?` in `Tag.build`.
- **Symbols**: Replaced `%w[input br hr img]` with `%i[input br hr img]` in `SINGLE_TAGS`.
- **Redundancy**: Removed unnecessary `.strip` calls in `Tag` rendering.
- **LoadError**: Resolved issue with loading `html_renderer.rb`.
- **NameError**: Fixed missing `BaseInput` in input classes.


### Added
- **Dependencies**: Added `active_support` requirement to support `autoload`.
- **Inputs module**: Created `HexletCode::Inputs` for managing input types.
- **Input classes**:
  - `BaseInput` (abstract base class).
  - `CheckboxInput`.
  - `PasswordInput`.
  - `SelectInput`.
  - `TextInput`.
  - `TextareaInput`.
- **Autoloading**: Implemented autoloading for input classes via `lib/hexlet_code/inputs.rb`.
- **Form classes**:
  - `FormState` for storing form state.
  - `FormBuilder` for collecting form fields.
- **Documentation**: Added docs for key classes/methods (Ruby style guide compliant).
- **Test helpers**:
  - Created `TestHelpers` module in `test/test_helper.rb`.
  - Added `normalize_html` utility method.
  - Extended `Minitest::Test` to automatically include `TestHelpers`.


### Removed
- **Obsolete code**:
  - Comments (e.g., `# default` markers).
  - Explicit `nil` returns in `FormBuilder#input`.
  - Monolithic input handling logic from `FormBuilder`.
- **Tests**: Removed obsolete test case `test_it_does_something_useful` from `test/test_hexlet_code.rb`.

### Refactoring
- **Input structure**: Split input types into individual classes under `lib/hexlet_code/inputs/`.
- **Dynamic resolution**: Replaced `dispatch_input` in `FormBuilder` with dynamic class resolution.
- **Test organization**:
  - Centralized test helpers in `test/test_helper.rb`.
  - Automated inclusion of `TestHelpers` in all test classes.
- **Code cleanup**: Removed redundant code and streamlined logic across modules.


## 0.1.0 — 2025-10-08

- Initial release.
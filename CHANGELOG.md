# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## 0.3.1 — 2025-11-14

### Fixed
- **Checkbox rendering**: Ensured `checked="checked"` attribute is used for HTML5 compliance (previously `checked` without value).
- **Tag attribute processing**: Improved `Tag.attr_to_s` to handle `true`/`false` values correctly:
  - `true` → `#{key}` (e.g., `required`).
  - `false` → omits attribute entirely.
- **SubmitInput initialization**: Corrected `name` parameter type from `Symbol` to `"submit"` (literal string) to reflect actual usage.
- **RBS signatures**: Updated `sig/hexlet_code.rbs` for:
  - `Tag` methods (`build`, `build_attributes`, `attr_to_s`, `escape_attr_value`).
  - `BaseInput#render_with_label` (now returns `String | nil`).
  - `CheckboxInput#initialize` (clarified `value` as `Boolean | String`).

### Changed
- **Versioning**: Bumped to `0.3.1` to reflect minor fixes and signature updates.
- **Documentation**: Added detailed `@param`/`@return` comments in `sig/hexlet_code.rbs` for better tooling support.
- **HTML escaping**: Strengthened `Tag.escape_attr_value` to handle special characters (`"`, `<`, `>`) in attribute values.
- **Test organization**: Split tests into separate modules (`basic_tests`, `input_type_tests`, `tag_tests`, etc.) for better maintainability. Each module now focuses on a specific component:
  - `basic_tests/` — core functionality (FormBuilder, Version).
  - `input_type_tests/` — individual input classes (TextInput, CheckboxInput, etc.).
  - `tag_tests/` — Tag class and attribute processing.
  - `integration_tests/` — end‑to‑end form rendering.

### Added
- **VOID_TAGS constant**: Documented in `Tag` class to clarify self‑closing HTML tags.
- **Type safety**: Enhanced RBS signatures for `Inputs` module classes (`TextInput`, `TextareaInput`, etc.) with precise parameter types.

## 0.3.0 — 2025-11-08

### Added
- **Skip label option**: Added `skip_label: true` to `input` method to suppress label rendering.
- **Dedicated SubmitInput class**: Isolated submit button logic into `HexletCode::Inputs::SubmitInput`.
- **Tag.build_attributes**: Public method for consistent attribute processing.

### Fixed
- **HTML attribute leakage**: Prevented `:as` and other internal keys from appearing in HTML output.
- **Checkbox rendering**: Fixed `checked` attribute generation (now uses `checked="checked"`).
- **Select input**: Restored proper `<option>` rendering with `selected` attribute.
- **Textarea attributes**: Fixed custom `cols`/`rows` handling.

### Changed
- **Input constructors**: All inputs now accept `name: Symbol`, `value: String?`, `options: Hash`.
- **HtmlRenderer**: Simplified `create_input` logic — now passes only relevant options.
- **FormBuilder**: Removed redundant state management (no `FormState` class).
- **Tests**: Stabilized all test cases (14 runs, 14 assertions, 0 failures).

### Removed
- **Redundant methods**: Eliminated duplicate attribute merging logic.
- **Internal keys**: `:as` is no longer exposed in HTML attributes.

## 0.2.1 — 2025-11-02

### Added
- **Textarea support**: Added default `rows: 50` and `cols: 50` for `<textarea>` fields.
- **Refactored FormBuilder**:
  - Extracted field type detection into private method `extract_type!`.
  - Added private methods `add_label` and `add_field` for better code organization.
  - Simplified `input` method to improve readability.

### Fixed
- **Textarea attributes**:
  - Filtered out `:as` option from HTML attributes to prevent leakage into markup.
  - Standardized attribute order: `rows` before `cols` in `<textarea>`.

### Changed
- **Unified rendering**: `<textarea>` now uses the same helper as `<input>` for consistent form generation.
- **Test organization**: Began splitting tests into logical groups (e.g., `form_builder_tests/`, `textarea_tests/`).

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
- **Test organization**: Introduced initial test modules (`core_tests/`, `inputs_tests/`) to reduce file clutter.

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
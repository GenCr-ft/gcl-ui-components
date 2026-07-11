# gcl-ui-components — Component Authoring Conventions

Authoring rules for reusable Aethel UI components in this addon. Governed by
ENG-ADR-089 (UI framework: Godot Control substrate + gcl-ui-components as shared
spec/asset library) and ENG-ADR-056 (engine binding). Design source:
`gcs-project-management#509`.

All nine sections below are **mandatory**. Run the Authoring Checklist (§9)
before opening a PR.

---

## 1. File naming

Always `snake_case`:

- Component script: `aethel_<name>.gd` (e.g. `aethel_button.gd`)
- Component scene: `aethel_<name>.tscn`
- Test: `test_aethel_<name>.gd`

Components live in `scenes/`; tests in `tests/`; scene fixtures used only by
tests in `tests/fixtures/`.

## 2. Class naming

`class_name Aethel<Name>` — PascalCase with the `Aethel` prefix
(e.g. `class_name AethelButton`). The root node of the component scene is named
after the class (`AethelButton`).

## 3. Directory layout

```
addons/gcl_ui_components/
  themes/        tokens.gd (AethelTokens) + aethel_base.tres
  scenes/        component scripts + scenes (aethel_<name>.gd/.tscn)
  schemas/       ui_descriptor schema + validator
  tests/         GUT test files (test_aethel_<name>.gd)
    fixtures/    scene fixtures used only by tests
  CONVENTIONS.md this document
```

Extends the layout established in `gcs-project-management#505` (F0.2).

## 4. Signal naming

Signals are **past-tense action verbs** with **typed parameters**:

- `pressed_action(button_id: StringName)`
- `value_changed(new_value: float)`
- `slot_selected(slot_index: int)`

No gameplay-domain signals in this library — domain events are Axiom's
responsibility. Components emit generic, UI-level signals only.

## 5. State-binding rule

Components **must not** reach into the node tree to read external state. All
state arrives via typed signals or `set_<property>()` setters.

**WRONG — direct node traversal (prohibited; violates the §12 no-traversal invariant):**

```gdscript
func _process(_delta: float) -> void:
    var hp = get_parent().get_node("Player").health  # NEVER — node-tree traversal
    _health_bar.value = hp
```

**CORRECT — property setter bound to a signal by the caller:**

```gdscript
# In the component (AethelStatBar):
func set_value(v: float) -> void:
    _bar.value = clampf(v, 0.0, _bar.max_value)

# In the HUD scene (caller wires the signal):
Axiom.player_health_changed.connect(_health_bar.set_value)
```

## 6. Theme-binding rule

All visual styling flows through `AethelTokens` only. Every component
`_ready()` **must** set `theme_type_variation = &"AethelUI"` so token lookups
resolve (backed by `AethelUI/base_type` in `aethel_base.tres`). No hard-coded
`Color`, `Font`, or `StyleBox` value anywhere in `.gd` or `.tscn` — token
VALUES are owned by Pixel (`gcs-project-management#510`).

## 7. Public API

Expose state exclusively via `set_<property>(value)` setters. Callers never
mutate inner node properties directly; the component owns its subtree.

## 8. GUT test requirement

One test file per component in `tests/`, named `test_aethel_<name>.gd`. It
**must**:

- use `before_each` (instantiate + add to tree) and `after_each` (`queue_free`) teardown;
- contain **≥1 happy-path** test (valid input → expected signal / state);
- contain **≥1 unhappy-path** test (disabled / empty / edge input → handled
  gracefully, no crash, no orphan). Silent failure is preferred over a crash for
  UI components.

## 9. Authoring checklist

Run through this before opening a PR:

- [ ] `class_name Aethel<Name>` present; root node named after the class
- [ ] File/scene/test names follow §1 (`snake_case`, `aethel_`/`test_aethel_` prefixes)
- [ ] `_ready()` sets `theme_type_variation = &"AethelUI"`
- [ ] No hard-coded `Color` / `Font` / `StyleBox` value in `.gd` or `.tscn`
- [ ] Signals are past-tense with typed parameters (§4)
- [ ] Test file present with `before_each`/`after_each` + ≥1 happy + ≥1 unhappy path
- [ ] CONVENTIONS.md consulted (this document)

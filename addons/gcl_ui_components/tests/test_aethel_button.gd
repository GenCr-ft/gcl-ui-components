## WI-420.1 — AethelButton reference component (F0.4).
##
## The standard gcl-ui-components component test pattern per [DESIGN]
## gcs-project-management#509 §4: before_each/after_each teardown, ≥1 happy and
## ≥1 unhappy path. AethelButton is the reference component — signal-driven
## (pressed_action carries a semantic button_id), token-bound
## (theme_type_variation = AethelUI), no hard-coded visual values.
##
## Uses the canonical typed form — preload + `as AethelButton` — which also
## exercises headless class resolution via the committed
## .godot/global_script_class_cache.cfg (the F0.2/#505 CI contract): if the
## AethelButton class registration were missing from the cache this script would
## fail to parse in CI. add_child_autofree keeps the tree orphan-free per
## CONVENTIONS §8.
##
## Refs: GenCr-ft/gcs-project-management#420, #509, ENG-ADR-089.
extends GutTest

const AethelButtonScene := preload("res://addons/gcl_ui_components/scenes/aethel_button.tscn")
const TEST_ID := &"test_btn"

var _button: AethelButton


func before_each() -> void:
	_button = AethelButtonScene.instantiate() as AethelButton
	_button.set_button_id(TEST_ID)
	add_child_autofree(_button)
	await get_tree().process_frame


func after_each() -> void:
	_button = null


func test_scene_instantiates_as_aethel_button() -> void:
	assert_not_null(_button, "AethelButton must instantiate from its scene")
	if _button == null:
		return
	assert_true(_button is Button, "AethelButton must extend Button")
	assert_true(_button.has_signal("pressed_action"), "must declare pressed_action signal")
	assert_true(_button.has_method("set_label"), "must expose set_label()")
	assert_true(_button.has_method("set_button_id"), "must expose set_button_id()")


func test_ready_sets_aethel_ui_theme_type_variation() -> void:
	assert_not_null(_button)
	if _button == null:
		return
	assert_eq(
		_button.theme_type_variation, &"AethelUI",
		"_ready() must set theme_type_variation = &\"AethelUI\" (token resolution)"
	)


# ── Happy paths ──────────────────────────────────────────────────────────────

func test_pressed_emits_pressed_action_with_button_id() -> void:
	assert_not_null(_button)
	if _button == null:
		return
	watch_signals(_button)
	_button.pressed.emit()
	assert_signal_emitted_with_parameters(_button, "pressed_action", [TEST_ID])


func test_set_label_updates_text_property() -> void:
	assert_not_null(_button)
	if _button == null:
		return
	_button.set_label("Play Game")
	assert_eq(_button.text, "Play Game")


# ── Unhappy paths ────────────────────────────────────────────────────────────

func test_disabled_button_does_not_emit_pressed_action() -> void:
	assert_not_null(_button)
	if _button == null:
		return
	_button.disabled = true
	watch_signals(_button)
	_button.pressed.emit()
	assert_signal_not_emitted(_button, "pressed_action")


func test_empty_label_does_not_crash() -> void:
	assert_not_null(_button)
	if _button == null:
		return
	_button.set_label("")
	assert_eq(_button.text, "")
	assert_no_new_orphans("empty label must not leak orphans or error")

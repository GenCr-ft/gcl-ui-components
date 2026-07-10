## WI-416.1 — AethelTokens design-token NAME contract.
##
## Scope: this first F0.2 cycle asserts only that tokens.gd (class_name
## AethelTokens) declares the v0.1 design-token NAME constants as interned
## StringName values. VALUES (Color, Font, StyleBox, spacing) are owned by
## Pixel and live in aethel_base.tres — see [HANDOFF] #510. Token key-existence
## against the loaded Theme Resource is a later F0.2/F0.3 cycle (#417/#418).
##
## Token catalogue: F0.2 [DESIGN] #505 §2 skeleton. F0.3 (#417) finalises the
## fuller 23-name catalogue (adds FS_*, SP_*, SB_BUTTON_DISABLED; renames
## FONT_* -> F_*) per [DESIGN] #508.
extends GutTest

const TOKENS_PATH := "res://addons/gcl_ui_components/themes/tokens.gd"

# Expected constant name -> interned StringName key (the theme lookup name).
# This is the CONTRACT under test, so the names are declared here explicitly.
const EXPECTED := {
	"C_BG_PRIMARY": &"c_bg_primary",
	"C_BG_SECONDARY": &"c_bg_secondary",
	"C_BG_OVERLAY": &"c_bg_overlay",
	"C_TEXT_DEFAULT": &"c_text_default",
	"C_TEXT_ACCENT": &"c_text_accent",
	"C_TEXT_DISABLED": &"c_text_disabled",
	"C_HEALTH_FILL": &"c_health_fill",
	"C_STAMINA_FILL": &"c_stamina_fill",
	"C_HUNGER_FILL": &"c_hunger_fill",
	"C_BORDER_DEFAULT": &"c_border_default",
	"SB_PANEL_DEFAULT": &"sb_panel_default",
	"SB_BUTTON_NORMAL": &"sb_button_normal",
	"SB_BUTTON_HOVER": &"sb_button_hover",
	"SB_BUTTON_PRESSED": &"sb_button_pressed",
	"FONT_BODY": &"font_body",
	"FONT_HEADING": &"font_heading",
}


func _load_token_constants() -> Dictionary:
	var script: GDScript = load(TOKENS_PATH) as GDScript
	if script == null:
		return {}
	return script.get_script_constant_map()


func test_tokens_script_exists_and_loads() -> void:
	var script: GDScript = load(TOKENS_PATH) as GDScript
	assert_not_null(script, "tokens.gd must exist and parse at " + TOKENS_PATH)


func test_all_name_constants_declared() -> void:
	var consts := _load_token_constants()
	assert_false(consts.is_empty(), "AethelTokens must declare token constants")
	for name in EXPECTED:
		assert_true(consts.has(name), "AethelTokens missing constant: " + name)


func test_name_constants_have_expected_string_values() -> void:
	var consts := _load_token_constants()
	for name in EXPECTED:
		if consts.has(name):
			assert_eq(
				String(consts[name]),
				String(EXPECTED[name]),
				"AethelTokens.%s must equal '%s'" % [name, String(EXPECTED[name])]
			)


func test_name_constants_are_interned_stringnames() -> void:
	var consts := _load_token_constants()
	for name in EXPECTED:
		if consts.has(name):
			assert_eq(
				typeof(consts[name]),
				TYPE_STRING_NAME,
				"AethelTokens.%s must be a StringName (interned key)" % name
			)

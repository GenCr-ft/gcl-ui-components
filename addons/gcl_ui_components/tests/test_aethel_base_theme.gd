## WI-416.2 — aethel_base.tres placeholder Theme Resource contract.
##
## Scope (F0.2 [DESIGN] #505 §2, #508 §1): assert that aethel_base.tres loads as
## a Godot [Theme] and exposes ALL 16 v0.1 AethelTokens slots under the single
## custom theme type "AethelUI". The VALUES are PLACEHOLDERS only — the real
## design values are owned by Pixel and land in F0.3 ([HANDOFF] #510). This test
## gates slot EXISTENCE (has_color / has_stylebox / has_font), never values.
##
## No magic strings: every token key is referenced through AethelTokens.* so the
## Theme Resource and the token catalogue cannot drift apart.
##
## Refs: GenCr-ft/gcs-project-management#416, #505, #508, ENG-ADR-089.
extends GutTest

const THEME_PATH := "res://addons/gcl_ui_components/themes/aethel_base.tres"


func _color_tokens() -> Array:
	return [
		AethelTokens.C_BG_PRIMARY,
		AethelTokens.C_BG_SECONDARY,
		AethelTokens.C_BG_OVERLAY,
		AethelTokens.C_TEXT_DEFAULT,
		AethelTokens.C_TEXT_ACCENT,
		AethelTokens.C_TEXT_DISABLED,
		AethelTokens.C_HEALTH_FILL,
		AethelTokens.C_STAMINA_FILL,
		AethelTokens.C_HUNGER_FILL,
		AethelTokens.C_BORDER_DEFAULT,
	]


func _stylebox_tokens() -> Array:
	return [
		AethelTokens.SB_PANEL_DEFAULT,
		AethelTokens.SB_BUTTON_NORMAL,
		AethelTokens.SB_BUTTON_HOVER,
		AethelTokens.SB_BUTTON_PRESSED,
	]


func _font_tokens() -> Array:
	return [
		AethelTokens.FONT_BODY,
		AethelTokens.FONT_HEADING,
	]


func _load_theme() -> Theme:
	return load(THEME_PATH) as Theme


func test_theme_resource_exists_and_loads_as_theme() -> void:
	var res: Resource = load(THEME_PATH)
	assert_not_null(res, "aethel_base.tres must exist and load at " + THEME_PATH)
	assert_true(res is Theme, "aethel_base.tres must be a Theme Resource")


func test_all_color_tokens_present_under_aethel_ui() -> void:
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _color_tokens():
		assert_true(
			theme.has_color(token, AethelTokens.TYPE_AETHEL_UI),
			"Theme must expose color '%s' under type '%s'"
				% [String(token), String(AethelTokens.TYPE_AETHEL_UI)]
		)


func test_all_stylebox_tokens_present_under_aethel_ui() -> void:
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _stylebox_tokens():
		assert_true(
			theme.has_stylebox(token, AethelTokens.TYPE_AETHEL_UI),
			"Theme must expose stylebox '%s' under type '%s'"
				% [String(token), String(AethelTokens.TYPE_AETHEL_UI)]
		)


func test_all_font_tokens_present_under_aethel_ui() -> void:
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _font_tokens():
		assert_true(
			theme.has_font(token, AethelTokens.TYPE_AETHEL_UI),
			"Theme must expose font '%s' under type '%s'"
				% [String(token), String(AethelTokens.TYPE_AETHEL_UI)]
		)


func test_theme_token_count_is_exhaustive_sixteen() -> void:
	# 10 colors + 4 styleboxes + 2 fonts = 16 v0.1 tokens (no more, no fewer).
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	var type := AethelTokens.TYPE_AETHEL_UI
	assert_eq(
		theme.get_color_list(type).size(), _color_tokens().size(),
		"Theme must declare exactly %d AethelUI colors" % _color_tokens().size()
	)
	assert_eq(
		theme.get_stylebox_list(type).size(), _stylebox_tokens().size(),
		"Theme must declare exactly %d AethelUI styleboxes" % _stylebox_tokens().size()
	)
	assert_eq(
		theme.get_font_list(type).size(), _font_tokens().size(),
		"Theme must declare exactly %d AethelUI fonts" % _font_tokens().size()
	)

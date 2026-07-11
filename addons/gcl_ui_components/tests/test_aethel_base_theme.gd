## WI-416.2 — aethel_base.tres placeholder Theme Resource contract.
##
## Scope (F0.3 [DESIGN] #508 §1–§3): assert that aethel_base.tres loads as a
## Godot [Theme] and exposes ALL 22 AethelTokens slots under the single custom
## theme type "AethelUI" (has_color / has_stylebox / has_font / has_font_size /
## has_constant). The colour VALUES are the loud Color.MAGENTA placeholder per
## #508 §3; the remaining real design values are owned by Pixel ([HANDOFF] #510).
##
## No magic strings: every token key is referenced through AethelTokens.* so the
## Theme Resource and the token catalogue cannot drift apart.
##
## Refs: GenCr-ft/gcs-project-management#416, #505, #508, ENG-ADR-089.
extends GutTest

const THEME_PATH := "res://addons/gcl_ui_components/themes/aethel_base.tres"
const TokenCats := preload("res://addons/gcl_ui_components/tests/aethel_token_categories.gd")


func _color_tokens() -> Array:
	return TokenCats.colors()


func _stylebox_tokens() -> Array:
	return TokenCats.styleboxes()


func _font_tokens() -> Array:
	return TokenCats.fonts()


func _font_size_tokens() -> Array:
	return TokenCats.font_sizes()


func _constant_tokens() -> Array:
	return TokenCats.constants()


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


func test_all_font_size_tokens_present_under_aethel_ui() -> void:
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _font_size_tokens():
		assert_true(
			theme.has_font_size(token, AethelTokens.TYPE_AETHEL_UI),
			"Theme must expose font_size '%s' under type '%s'"
				% [String(token), String(AethelTokens.TYPE_AETHEL_UI)]
		)


func test_all_spacing_constants_present_under_aethel_ui() -> void:
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _constant_tokens():
		assert_true(
			theme.has_constant(token, AethelTokens.TYPE_AETHEL_UI),
			"Theme must expose spacing constant '%s' under type '%s'"
				% [String(token), String(AethelTokens.TYPE_AETHEL_UI)]
		)


func test_placeholder_colors_are_magenta() -> void:
	# [DESIGN] #508 §3: colour placeholders are the loud Color.MAGENTA sentinel
	# (unmistakably "Pixel has not approved these values yet"), pending #510.
	var theme := _load_theme()
	assert_not_null(theme, "aethel_base.tres must load as a Theme")
	if theme == null:
		return
	for token in _color_tokens():
		assert_eq(
			theme.get_color(token, AethelTokens.TYPE_AETHEL_UI), Color.MAGENTA,
			"placeholder colour '%s' must be Color.MAGENTA until Pixel handoff #510"
				% String(token)
		)


func test_theme_token_count_is_exhaustive_twenty_two() -> void:
	# 10 colors + 5 styleboxes + 2 fonts + 2 font_sizes + 3 constants = 22 tokens.
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
	assert_eq(
		theme.get_font_size_list(type).size(), _font_size_tokens().size(),
		"Theme must declare exactly %d AethelUI font_sizes" % _font_size_tokens().size()
	)
	assert_eq(
		theme.get_constant_list(type).size(), _constant_tokens().size(),
		"Theme must declare exactly %d AethelUI constants" % _constant_tokens().size()
	)

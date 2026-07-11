## WI-416.4 — sample_panel.tscn resolves AethelUI tokens against aethel_base.tres.
##
## Smoke test for the runtime theme path: a real Control scene, once inside the
## SceneTree, must resolve EVERY v0.1 AethelToken through the Control theme API
## (has_theme_color / has_theme_stylebox / has_theme_font under type "AethelUI")
## with NO fallback — i.e. no missing-token warnings. Resolution is checked
## against the values authored in aethel_base.tres, proving the scene is wired to
## the base theme and not silently falling back to engine defaults.
##
## No magic strings: token keys go through AethelTokens.*.
##
## Refs: GenCr-ft/gcs-project-management#416, #505, #508, ENG-ADR-089.
extends GutTest

const SCENE_PATH := "res://addons/gcl_ui_components/scenes/sample_panel.tscn"
const THEME_PATH := "res://addons/gcl_ui_components/themes/aethel_base.tres"
const TokenCats := preload("res://addons/gcl_ui_components/tests/aethel_token_categories.gd")


func _color_tokens() -> Array:
	return TokenCats.colors()


func _stylebox_tokens() -> Array:
	return TokenCats.styleboxes()


func _font_tokens() -> Array:
	return TokenCats.fonts()


func _instantiate_in_tree() -> Control:
	var packed: PackedScene = load(SCENE_PATH) as PackedScene
	if packed == null:
		return null
	var root: Control = packed.instantiate() as Control
	if root == null:
		return null
	add_child_autofree(root)
	return root


func test_scene_exists_and_instantiates_as_control() -> void:
	var packed: PackedScene = load(SCENE_PATH) as PackedScene
	assert_not_null(packed, "sample_panel.tscn must exist at " + SCENE_PATH)
	if packed == null:
		return
	var root: Variant = packed.instantiate()
	assert_true(root is Control, "sample_panel root must be a Control")
	if root is Node:
		root.free()


func test_scene_carries_aethel_base_theme() -> void:
	var root := _instantiate_in_tree()
	assert_not_null(root, "sample_panel must instantiate")
	if root == null:
		return
	assert_not_null(root.theme, "sample_panel root must have a Theme assigned")


func test_all_tokens_resolve_through_control_api() -> void:
	var root := _instantiate_in_tree()
	assert_not_null(root)
	if root == null:
		return
	var type := AethelTokens.TYPE_AETHEL_UI
	for token in _color_tokens():
		assert_true(
			root.has_theme_color(token, type),
			"Control must resolve color '%s' under '%s' (no missing-token fallback)"
				% [String(token), String(type)]
		)
	for token in _stylebox_tokens():
		assert_true(
			root.has_theme_stylebox(token, type),
			"Control must resolve stylebox '%s' under '%s'" % [String(token), String(type)]
		)
	for token in _font_tokens():
		assert_true(
			root.has_theme_font(token, type),
			"Control must resolve font '%s' under '%s'" % [String(token), String(type)]
		)


func test_resolved_color_matches_base_theme_value() -> void:
	# Prove resolution is against aethel_base.tres, not an engine default.
	var root := _instantiate_in_tree()
	assert_not_null(root)
	if root == null:
		return
	var base := load(THEME_PATH) as Theme
	assert_not_null(base, "aethel_base.tres must load")
	if base == null:
		return
	var type := AethelTokens.TYPE_AETHEL_UI
	var token := AethelTokens.C_BG_PRIMARY
	assert_eq(
		root.get_theme_color(token, type),
		base.get_color(token, type),
		"resolved color must equal the aethel_base placeholder value"
	)

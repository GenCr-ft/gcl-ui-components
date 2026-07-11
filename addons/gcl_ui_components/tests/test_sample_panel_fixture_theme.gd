## WI-418.1 — tests/fixtures/sample_panel.tscn Theme-load fixture (F0.3).
##
## Per [DESIGN] gcs-project-management#508 §4: a minimal PanelContainer + Label
## fixture whose `theme` is aethel_base.tres, exercised to prove the AethelUI
## Theme lookup chain resolves at runtime with NO GDScript error and NO orphan
## nodes. Also gates the loud magenta colour placeholder (§3) and the
## unhappy-path contract that an unknown token key resolves to false.
##
## This fixture lives under tests/fixtures/ (test infrastructure, NOT a reusable
## component) and is the shared Theme-load fixture also consumed by F0.4 (#509).
##
## No magic strings: token keys go through AethelTokens.*.
##
## Refs: GenCr-ft/gcs-project-management#418, #508, ENG-ADR-089.
extends GutTest

const FIXTURE_PATH := "res://addons/gcl_ui_components/tests/fixtures/sample_panel.tscn"
const THEME_PATH := "res://addons/gcl_ui_components/themes/aethel_base.tres"


func _instantiate_in_tree() -> Control:
	var packed: PackedScene = load(FIXTURE_PATH) as PackedScene
	if packed == null:
		return null
	var root: Control = packed.instantiate() as Control
	if root == null:
		return null
	add_child_autofree(root)
	return root


func test_fixture_exists_and_carries_base_theme() -> void:
	var packed: PackedScene = load(FIXTURE_PATH) as PackedScene
	assert_not_null(packed, "fixture must exist at " + FIXTURE_PATH)
	if packed == null:
		return
	var root := _instantiate_in_tree()
	assert_not_null(root, "fixture must instantiate as a Control")
	if root == null:
		return
	assert_not_null(root.theme, "fixture root must carry the aethel_base Theme")


func test_placeholder_bg_resolves_to_magenta() -> void:
	var root := _instantiate_in_tree()
	assert_not_null(root)
	if root == null:
		return
	await get_tree().process_frame
	var color: Color = root.get_theme_color(
		AethelTokens.C_BG_PRIMARY, AethelTokens.TYPE_AETHEL_UI
	)
	assert_eq(color, Color.MAGENTA, "placeholder colour must be Color.MAGENTA (§508 §3)")


func test_fixture_leaves_no_orphans() -> void:
	var root := _instantiate_in_tree()
	assert_not_null(root)
	if root == null:
		return
	await get_tree().process_frame
	assert_no_new_orphans("instantiating the fixture must not leak orphan nodes")


func test_theme_type_variation_resolves_without_explicit_type() -> void:
	# [DESIGN] #508 §1 promises components set theme_type_variation = &"AethelUI"
	# and then call get_theme_color(TOKEN) with NO explicit type arg. That only
	# works when the Theme declares AethelUI/base_type; this guards the implicit
	# resolution path that F0.4 components (AethelButton, etc.) depend on.
	var root := _instantiate_in_tree()
	assert_not_null(root)
	if root == null:
		return
	await get_tree().process_frame
	assert_eq(
		root.theme_type_variation, AethelTokens.TYPE_AETHEL_UI,
		"fixture root must declare theme_type_variation = AethelUI"
	)
	# No explicit type argument — resolution must flow through the variation.
	assert_true(
		root.has_theme_color(AethelTokens.C_BG_PRIMARY),
		"C_BG_PRIMARY must resolve via theme_type_variation without an explicit type"
	)
	assert_eq(
		root.get_theme_color(AethelTokens.C_BG_PRIMARY), Color.MAGENTA,
		"implicit-variation lookup must resolve the same MAGENTA placeholder"
	)


func test_unknown_token_key_resolves_false() -> void:
	# Unhappy path: a key that is not a declared token must NOT resolve.
	var theme := load(THEME_PATH) as Theme
	assert_not_null(theme, "aethel_base.tres must load")
	if theme == null:
		return
	var type := AethelTokens.TYPE_AETHEL_UI
	assert_false(theme.has_color(&"nonexistent_token", type), "unknown colour must be false")
	assert_false(theme.has_stylebox(&"nonexistent_sb", type), "unknown stylebox must be false")
	assert_false(theme.has_constant(&"nonexistent_const", type), "unknown constant must be false")

## WI-416.3 — UI-descriptor schema v0.1 §12 no-identity-literal invariant.
##
## §12 multiplayer-readiness invariant (First Playable design spec, ENG-ADR-089
## §Consequences, [DESIGN] #505 §3): a UI descriptor carries NO singleton player
## identity — identity is a RUNTIME binding, never embedded as a literal. The
## property names `player_id`, `user_id`, `actor_id`, `identity` are forbidden at
## ANY nesting depth. This test drives the minimal declarative validator that
## enforces that invariant, and also asserts a clean descriptor is accepted.
##
## Refs: GenCr-ft/gcs-project-management#416, #505, ENG-ADR-089.
extends GutTest

const VALIDATOR_PATH := "res://addons/gcl_ui_components/schemas/ui_descriptor_validator.gd"
const SCHEMA_PATH := "res://addons/gcl_ui_components/schemas/ui_descriptor.v0.1.schema.json"

# The §12 forbidden identity-literal property names — the contract under test.
const FORBIDDEN_IDENTITY_NAMES := ["player_id", "user_id", "actor_id", "identity"]


func _validator() -> GDScript:
	return load(VALIDATOR_PATH) as GDScript


func _valid_descriptor() -> Dictionary:
	return {
		"version": "0.1",
		"control_tree": {
			"type": "PanelContainer",
			"children": [{"type": "Label", "name": "title"}],
		},
		"theme_override": {},
		"slot_bindings": {},
	}


func _has_identity_error(result: Dictionary) -> bool:
	for e in result.get("errors", []):
		if String(e.get("code", "")) == "identity_literal_forbidden":
			return true
		if "identity-literal" in String(e.get("message", "")):
			return true
	return false


func test_schema_file_exists_and_parses() -> void:
	var f := FileAccess.open(SCHEMA_PATH, FileAccess.READ)
	assert_not_null(f, "schema file must exist at " + SCHEMA_PATH)
	if f == null:
		return
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	assert_true(parsed is Dictionary, "schema must be a valid JSON object")


func test_validator_script_loads() -> void:
	assert_not_null(_validator(), "validator script must exist at " + VALIDATOR_PATH)


func test_clean_descriptor_is_accepted() -> void:
	var v := _validator()
	assert_not_null(v)
	if v == null:
		return
	var result: Dictionary = v.validate(_valid_descriptor())
	assert_true(
		result.get("valid", false),
		"a descriptor with no identity fields must validate: %s" % str(result.get("errors", []))
	)


func test_top_level_identity_literal_is_rejected() -> void:
	var v := _validator()
	assert_not_null(v)
	if v == null:
		return
	var d := _valid_descriptor()
	d["player_id"] = "player-42"
	var result: Dictionary = v.validate(d)
	assert_false(result.get("valid", true), "descriptor with player_id must be rejected")
	assert_true(_has_identity_error(result), "rejection must reference the identity-literal constraint")


func test_nested_identity_literal_is_rejected() -> void:
	var v := _validator()
	assert_not_null(v)
	if v == null:
		return
	var d := _valid_descriptor()
	d["control_tree"]["children"][0]["user_id"] = 7
	var result: Dictionary = v.validate(d)
	assert_false(result.get("valid", true), "a nested user_id must be rejected at any depth")
	assert_true(_has_identity_error(result), "rejection must reference the identity-literal constraint")


func test_every_forbidden_identity_name_is_rejected() -> void:
	var v := _validator()
	assert_not_null(v)
	if v == null:
		return
	for name in FORBIDDEN_IDENTITY_NAMES:
		var d := _valid_descriptor()
		d[name] = "x"
		var result: Dictionary = v.validate(d)
		assert_false(result.get("valid", true), "'%s' must be rejected" % name)
		assert_true(_has_identity_error(result), "'%s' rejection must reference identity-literal constraint" % name)


func test_forbidden_list_matches_schema_source_of_truth() -> void:
	# The validator MUST read the forbidden names from the schema, so the schema
	# remains the single source of truth for the §12 invariant.
	var v := _validator()
	assert_not_null(v)
	if v == null:
		return
	var schema: Dictionary = v.load_schema()
	var from_schema: Array = v.forbidden_property_names(schema)
	assert_eq(
		from_schema.size(), FORBIDDEN_IDENTITY_NAMES.size(),
		"schema must declare exactly the §12 forbidden identity names"
	)
	for name in FORBIDDEN_IDENTITY_NAMES:
		assert_true(from_schema.has(name), "schema forbidden list must include '%s'" % name)

## UI-descriptor v0.1 validator — §12 no-identity-literal invariant enforcement.
##
## v0.1 is intentionally a MINIMAL validator (YAGNI, ENG-SPEC-002 §6): it gates
## the two contracts the F0.2 acceptance criteria exercise —
##   1. the §12 multiplayer-readiness invariant (no identity literal at any depth)
##   2. the required v0.1 top-level keys (version, control_tree)
## The forbidden identity property-name list is read FROM the schema file so the
## JSON Schema stays the single source of truth. Full JSON-Schema Draft 2020-12
## structural validation is deliberately out of scope for v0.1 — the schema file
## is the declarative contract; a fuller validator lands with the descriptor
## runtime (future ADR / WI).
##
## Result shape:
##   { "valid": bool, "errors": Array[{ "code": String, "message": String, "path": String }] }
##
## Refs: GenCr-ft/gcs-project-management#416, #505, ENG-ADR-089.
extends RefCounted

const SCHEMA_PATH := "res://addons/gcl_ui_components/schemas/ui_descriptor.v0.1.schema.json"
const REQUIRED_TOP_LEVEL := ["version", "control_tree"]


## Loads and parses the schema JSON. Returns {} if missing/unparseable.
static func load_schema(path: String = SCHEMA_PATH) -> Dictionary:
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		return {}
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	return parsed if parsed is Dictionary else {}


## Reads the canonical §12 forbidden identity property names from the schema.
static func forbidden_property_names(schema: Dictionary) -> Array:
	var defs: Variant = schema.get("$defs", {})
	if not (defs is Dictionary):
		return []
	var invariant: Variant = defs.get("identityInvariant", {})
	if not (invariant is Dictionary):
		return []
	var names: Variant = invariant.get("forbiddenPropertyNames", [])
	return names if names is Array else []


## Validates a descriptor against the v0.1 contract. If [param schema] is empty
## it is loaded from disk.
static func validate(descriptor: Variant, schema: Dictionary = {}) -> Dictionary:
	if schema.is_empty():
		schema = load_schema()

	var errors: Array = []

	if descriptor is Dictionary:
		for req in REQUIRED_TOP_LEVEL:
			if not descriptor.has(req):
				errors.append({
					"code": "required",
					"message": "missing required property '%s'" % req,
					"path": "/",
				})
	else:
		errors.append({
			"code": "type",
			"message": "descriptor must be a JSON object",
			"path": "/",
		})

	# §12 invariant — recursive scan for forbidden identity-literal keys.
	_scan_for_identity_literals(descriptor, forbidden_property_names(schema), "", errors)

	return {"valid": errors.is_empty(), "errors": errors}


static func _scan_for_identity_literals(
	node: Variant, forbidden: Array, path: String, errors: Array
) -> void:
	if node is Dictionary:
		for key in node:
			var child_path := path + "/" + str(key)
			if forbidden.has(key):
				errors.append({
					"code": "identity_literal_forbidden",
					"message": (
						"forbidden identity-literal property '%s' at '%s' — §12: identity is a runtime binding, never embedded in a UI descriptor"
						% [str(key), child_path]
					),
					"path": child_path,
				})
			_scan_for_identity_literals(node[key], forbidden, child_path, errors)
	elif node is Array:
		for i in node.size():
			_scan_for_identity_literals(node[i], forbidden, path + "/" + str(i), errors)

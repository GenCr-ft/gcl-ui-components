## WI-419.1 — CONVENTIONS.md contract (F0.4).
##
## Per [DESIGN] gcs-project-management#509 §1, the addon component-authoring
## conventions doc MUST define nine mandatory sections. This test gates their
## presence (a structural contract, not prose review) so the doc cannot silently
## lose a required section, and asserts the state-binding section carries both a
## WRONG and a CORRECT example (the §12 no-node-traversal invariant).
##
## Refs: GenCr-ft/gcs-project-management#419, #509, ENG-ADR-089.
extends GutTest

const CONVENTIONS_PATH := "res://addons/gcl_ui_components/CONVENTIONS.md"

# The nine mandatory section headings (matched case-insensitively as substrings
# of the doc so exact numbering/punctuation can evolve without breaking).
const REQUIRED_SECTIONS := [
	"File naming",
	"Class naming",
	"Directory layout",
	"Signal naming",
	"State-binding",
	"Theme-binding",
	"Public API",
	"GUT test requirement",
	"Authoring checklist",
]


func _read_doc() -> String:
	if not FileAccess.file_exists(CONVENTIONS_PATH):
		return ""
	var f := FileAccess.open(CONVENTIONS_PATH, FileAccess.READ)
	if f == null:
		return ""
	return f.get_as_text()


func test_conventions_doc_exists() -> void:
	assert_true(
		FileAccess.file_exists(CONVENTIONS_PATH),
		"CONVENTIONS.md must exist at " + CONVENTIONS_PATH
	)


func test_all_nine_sections_present() -> void:
	var text := _read_doc().to_lower()
	assert_false(text.is_empty(), "CONVENTIONS.md must be non-empty")
	for section in REQUIRED_SECTIONS:
		assert_true(
			text.contains(section.to_lower()),
			"CONVENTIONS.md must document the '%s' section" % section
		)


func test_state_binding_has_wrong_and_correct_examples() -> void:
	var text := _read_doc().to_lower()
	assert_true(text.contains("wrong"), "state-binding section must show a WRONG example")
	assert_true(text.contains("correct"), "state-binding section must show a CORRECT example")
	# The prohibited pattern (node-tree traversal) must be named explicitly.
	assert_true(
		text.contains("get_parent") or text.contains("node-tree") or text.contains("traversal"),
		"state-binding rule must name the prohibited node-tree traversal pattern"
	)

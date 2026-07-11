## AethelButton — reference gcl-ui-components component (F0.4).
##
## The canonical component pattern (per CONVENTIONS.md + [DESIGN]
## gcs-project-management#509 §3): signal-driven (emits a semantic button_id,
## not the raw Button.pressed), token-bound (theme_type_variation = &"AethelUI"
## so SB_BUTTON_* / F_BODY / C_TEXT_* resolve from aethel_base.tres), and free
## of any hard-coded Color/Font/StyleBox value.
##
## Refs: GenCr-ft/gcs-project-management#420, #509, ENG-ADR-089.
class_name AethelButton
extends Button

## Emitted when the button is activated. button_id is the semantic identifier
## set via set_button_id() (defaults to &"" if unset), enabling callers to
## dispatch on identity rather than wiring per-instance closures.
signal pressed_action(button_id: StringName)

var _button_id: StringName = &""


func _ready() -> void:
	theme_type_variation = &"AethelUI"
	pressed.connect(_on_pressed)


## Set the visible label text. Empty string is valid (renders with no text).
func set_label(label_text: String) -> void:
	text = label_text


## Set the semantic identifier emitted with pressed_action.
func set_button_id(id: StringName) -> void:
	_button_id = id


func _on_pressed() -> void:
	# Respect the disabled state even under a programmatic pressed.emit():
	# a disabled control must never fire its semantic action.
	if disabled:
		return
	pressed_action.emit(_button_id)

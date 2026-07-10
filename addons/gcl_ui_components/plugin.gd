## Minimal EditorPlugin entry point for the gcl_ui_components addon.
##
## Intentionally does no work at boot — the addon is consumed as a resource
## library (themes, schemas, scenes), not as an editor tool. It is deliberately
## NOT registered under [editor_plugins] in project.godot so the GUT headless
## runner stays clean (studio guidance, workspace MEMORY.md; [DESIGN] #505 §4).
@tool
extends EditorPlugin


func _get_plugin_name() -> String:
	return "gcl_ui_components"

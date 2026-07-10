## Headless GUT entry point for gcl-ui-components (ENG-ADR-089).
##
## Invoked by test.sh as:
##   $GODOT_BIN --headless --path . -s addons/gcl_ui_components/tests/gut_runner.gd <gut-args>
##
## GUT class names (GutUtils, GutMain, ...) are pre-registered via the committed
## .godot/global_script_class_cache.cfg so headless startup has the class registry
## without an editor scan. GUT is NOT registered as an [editor_plugins] entry —
## that breaks the headless runner (studio guidance, workspace MEMORY.md).
extends SceneTree


func _init() -> void:
	var max_iter := 20
	var iter := 0
	while Engine.get_main_loop() == null and iter < max_iter:
		await create_timer(0.01).timeout
		iter += 1

	if Engine.get_main_loop() == null:
		push_error("Main loop did not start in time.")
		quit(1)
		return

	var cli = load("res://addons/gut/cli/gut_cli.gd").new()
	get_root().add_child(cli)
	cli.main()

## Shared AethelToken category catalogue for GUT theme tests.
##
## NOT a test file (no `test_` prefix → not collected by GUT). Single source of
## truth for how the 22 F0.3 tokens split across Theme data types (colors /
## styleboxes / fonts / font_sizes / constants), built from AethelTokens.* so
## there are no magic strings. Loaded by preload() in the theme tests to avoid
## duplicating the arrays.
##
## Refs: GenCr-ft/gcs-project-management#416, #505, #508.
extends RefCounted


static func colors() -> Array:
	return [
		AethelTokens.C_BG_PRIMARY, AethelTokens.C_BG_SECONDARY, AethelTokens.C_BG_OVERLAY,
		AethelTokens.C_TEXT_DEFAULT, AethelTokens.C_TEXT_ACCENT, AethelTokens.C_TEXT_DISABLED,
		AethelTokens.C_HEALTH_FILL, AethelTokens.C_STAMINA_FILL, AethelTokens.C_HUNGER_FILL,
		AethelTokens.C_BORDER_DEFAULT,
	]


static func styleboxes() -> Array:
	return [
		AethelTokens.SB_PANEL_DEFAULT, AethelTokens.SB_BUTTON_NORMAL,
		AethelTokens.SB_BUTTON_HOVER, AethelTokens.SB_BUTTON_PRESSED,
		AethelTokens.SB_BUTTON_DISABLED,
	]


static func fonts() -> Array:
	return [AethelTokens.F_BODY, AethelTokens.F_HEADING]


static func font_sizes() -> Array:
	return [AethelTokens.FS_BODY, AethelTokens.FS_HEADING]


static func constants() -> Array:
	return [
		AethelTokens.SP_MARGIN_SM, AethelTokens.SP_MARGIN_MD, AethelTokens.SP_MARGIN_LG,
	]

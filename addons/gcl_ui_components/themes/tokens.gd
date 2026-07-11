## AethelTokens — Aethel UI design-token NAME catalogue (v0.1 skeleton).
##
## Single source of truth for design-token KEYS. This file is value-free:
## it declares only interned StringName lookup keys. The actual VALUES
## (Color, Font, StyleBox, spacing) live in aethel_base.tres and are owned by
## Pixel (GCT-DES-UX-001) — see [HANDOFF] GenCr-ft/gcs-project-management#510.
##
## All tokens resolve under the single custom Theme type "AethelUI" (per
## [DESIGN] #508 §1). Controls use these constants instead of magic strings, e.g.
##   get_theme_color(AethelTokens.C_BG_PRIMARY, "AethelUI")
##
## Catalogue scope: F0.3 (#417) finalises the full 22-token catalogue per
## [DESIGN] #508 §2 — 10 colour, 4 typography (F_BODY/F_HEADING font keys +
## FS_BODY/FS_HEADING font-size keys), 5 StyleBox (incl. SB_BUTTON_DISABLED),
## 3 spacing (SP_MARGIN_SM/MD/LG). Supersedes the F0.2 #505 §2 16-token
## skeleton (FONT_* renamed to F_*).
##
## Refs: GenCr-ft/gcs-project-management#416, #505, #508, ENG-ADR-089.
class_name AethelTokens
extends RefCounted

## Custom Theme type under which all Aethel tokens are registered.
const TYPE_AETHEL_UI: StringName = &"AethelUI"

# ── Background colours ────────────────────────────────────────────────────────
const C_BG_PRIMARY: StringName = &"c_bg_primary"
const C_BG_SECONDARY: StringName = &"c_bg_secondary"
const C_BG_OVERLAY: StringName = &"c_bg_overlay"

# ── Text colours ──────────────────────────────────────────────────────────────
const C_TEXT_DEFAULT: StringName = &"c_text_default"
const C_TEXT_ACCENT: StringName = &"c_text_accent"
const C_TEXT_DISABLED: StringName = &"c_text_disabled"

# ── Gameplay colours ──────────────────────────────────────────────────────────
const C_HEALTH_FILL: StringName = &"c_health_fill"
const C_STAMINA_FILL: StringName = &"c_stamina_fill"
const C_HUNGER_FILL: StringName = &"c_hunger_fill"

# ── Border / separator ────────────────────────────────────────────────────────
const C_BORDER_DEFAULT: StringName = &"c_border_default"

# ── StyleBox slots ────────────────────────────────────────────────────────────
const SB_PANEL_DEFAULT: StringName = &"sb_panel_default"
const SB_BUTTON_NORMAL: StringName = &"sb_button_normal"
const SB_BUTTON_HOVER: StringName = &"sb_button_hover"
const SB_BUTTON_PRESSED: StringName = &"sb_button_pressed"
const SB_BUTTON_DISABLED: StringName = &"sb_button_disabled"

# ── Font slots ────────────────────────────────────────────────────────────────
const F_BODY: StringName = &"f_body"
const F_HEADING: StringName = &"f_heading"

# ── Font-size slots (int constants resolved via Theme.has_font_size) ────────────
const FS_BODY: StringName = &"fs_body"
const FS_HEADING: StringName = &"fs_heading"

# ── Spacing constants (int, pixels; resolved via Theme.has_constant) ────────────
const SP_MARGIN_SM: StringName = &"sp_margin_sm"
const SP_MARGIN_MD: StringName = &"sp_margin_md"
const SP_MARGIN_LG: StringName = &"sp_margin_lg"

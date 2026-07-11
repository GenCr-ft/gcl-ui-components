# UI-Descriptor Schema (v0.1)

Declarative UI descriptor schema for the Aethel `gcl_ui_components` addon
(ENG-ADR-089, [DESIGN] `gcs-project-management#505` §3).

## Files

| File | Purpose |
|------|---------|
| `ui_descriptor.v0.1.schema.json` | JSON Schema (Draft 2020-12). Declarative contract: a Control tree, a Theme override, and slot bindings. **No scripting.** |
| `ui_descriptor_validator.gd` | Minimal GDScript validator that enforces the §12 identity invariant and the v0.1 required keys. Reads the forbidden-name list **from** the schema (schema is the single source of truth). |

## §12 identity invariant (multiplayer-readiness)

A UI descriptor **carries no singleton player identity**. Identity is a *runtime
binding*, resolved by the host at instantiation via `slot_bindings` — never a
literal embedded in the descriptor.

The property names `player_id`, `user_id`, `actor_id`, and `identity` are
forbidden at **any nesting depth**. A descriptor containing one of them fails
validation with an `identity_literal_forbidden` error.

## Out of scope for v0.1

A future ADR is required before any of these may be added — v0.1 is strictly
declarative:

- Scripted callbacks (Lua / GDScript-in-JSON)
- Signal-wiring declarations
- Animation-curve definitions

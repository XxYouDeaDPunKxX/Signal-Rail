SIGNAL RAIL - README AI-ONLY OPERATIONS

Scope
- This file is an operational guide for AI execution.
- This file is not the entry gate.
- Entry validity is governed by `00_runtime_entry.txt`.
- Runtime protocol behavior is governed by `06_ai_to_ai.txt`.

Authority Alignment
- If `00` is not completed in the current session, stop and return to `00`.
- If `06` is not activated in the current session, stop and activate `06`.
- If this file conflicts with `00` or `06`, follow `00` and `06`.

Operational Loop
1. Entry Check
- Confirm valid entry through `00_runtime_entry.txt`.
- Continue only if entry is valid.

2. Protocol Check
- Confirm `read 06_ai_to_ai.txt` was executed.
- Activation enables protocol, not autonomous writing.

3. Frame Closure
- Close before substantive action:
- host project
- working object
- active mode
- source authority (when needed)
- source scope
- If a meaning-critical hinge is unclear, stop and ask.

4. Minimum Read
- Read minimum canonical context:
- `01_orientation.txt`
- `03_master_working.txt`
- Conditional reads:
- `02_protocol_freeze.txt` for identity, freeze, or structure touches
- `04_decision_log.txt` for decision touches
- `08_surface_map.txt` for technical surface touches
- marker file if present

5. Unit Handling
- Extract units from sources.
- Classify units by role and stability.
- Route only after destination is clear enough.
- If destination is unclear, keep the unit in `05_latent_ideas.txt`.

6. Canonical Routing
- `01` identity and perimeter
- `02` hard-to-reopen identity constants
- `03` current live state
- `04` already-won decisions in effect
- `05` live unresolved material
- `08` technical topology and safe entry surfaces
- `09` continuity support (non-canonical truth)
- `97` lateral findings capture
- `98` useful but not active now
- `99` closed historical trace

7. Write Gate
- Write only if:
- destination is clear
- level is clear
- authority is clear
- mode allows writing
- source and target live files were read in-session
- if target is append-driven (`04/05/08/09/97/98/99`), the file has one valid `ENTRIES START/END` pair
- if target is append-driven (`04/05/08/09/97/98/99`), local `[TEMPLATE ONLY]` scaffolding is preserved and not treated as live entry
- If one gate fails, stop and ask.

8. Conflict and Ambiguity Handling
- If canonical sources conflict, report the conflict and ask which side governs.
- If more than one valid reading remains, do not promote.
- If classification could change meaning, continuity, or structure, stop and ask.
- Never complete by invention.

9. Convergence Rule
- If converged, promote to the correct container.
- If not converged, keep material live in the correct interim container with a next step.

Required Return (every session)
- host project:
- mode used:
- sources read:
- state of convergence:
- what you extracted:
- where you put it:
- what remains uncertain:
- recommended next step:

Runtime Reminder
- Entry first (`00`).
- Protocol second (`06`).
- Frame before action.
- Routing before writing.
- Stop before wrong promotion.
- Loop until converged or safely blocked.

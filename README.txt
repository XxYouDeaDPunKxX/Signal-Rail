SIGNAL RAIL

Signal Rail is the Swiss Army knife for your agent when it needs to handle project context, working memory, and living documentation.

It is where the agent stops chasing context and starts governing it: what is live now, what has already won, what is still maturing, what belongs only to continuity, and where the project really lives on the technical side.

It does not make the project simpler than it is.
It makes it more readable, more continuous, and much harder to lose while it grows, stratifies, and changes shape.

QUICK START

If you open Signal Rail and want to begin without overcomplicating the session, do this:

1. Read `06_ai_to_ai.txt`.
   It governs the agent's behavior inside the system.

2. Close the minimum frame you need.
   In practice:
   - what the host project is
   - what the working object is
   - which mode you are in

3. Do not start from the file. Start from the content.
   Ask first what kind of thing you are handling:
   - project identity
   - current live state
   - an already-won decision
   - still-mobile material
   - technical surface map
   - session continuity

4. Only then place it in the right file.

5. Keep `09_handoff_reentry.txt` as a continuity file.
   It helps you re-enter.
   It is not canonical project truth.

6. If you have local UI or local tooling, use it if helpful.
   But the system must still work without it.
   The core of Signal Rail is textual.

WHAT NOT TO CONFUSE

Some boundaries are worth closing early.

The kit is not the host project.
A folder that contains Signal Rail does not automatically tell you what the real governed project is.

`06_ai_to_ai.txt` does not describe the host project.
It describes how the agent should behave while working inside Signal Rail.

`09_handoff_reentry.txt` is not a canonical truth file.
It supports handoff, context transfer, and short continuity.
If something stops being continuity and becomes actual project state, move it into the right canonical file.

Local surfaces can help, but they do not define the system.
If the tooling changes tomorrow, the system should still remain readable.

PERSONAL LOCALIZATION

This repository is the fresh international baseline of Signal Rail.

If you want a personal language version, do not localize a live working surface in place.
Use SR Localization Kit first, create one personal localized copy of the SR core, and only then begin real use from that copy.

In that workflow:
- Codex or another agent performs the semantic localization work.
- `audit_localization.ps1` validates the result afterward.
- The validator does not localize the kit by itself.
- SR Localization Kit is support tooling for creating a personal localized copy of the SR core; it is not itself part of the localized core by default.

HOW IT IS BUILT

Signal Rail contains distinct levels, each with a precise role.

Main canonicals

`01_orientation.txt`
Keep project identity, perimeter, and reading frame here.
This is where you understand what the project is and which boundaries matter.

`02_protocol_freeze.txt`
Keep identity constants here.
Not what currently feels very important.
Only the points that, if removed, would make the project stop being itself.

`03_master_working.txt`
Keep the project's current live state here.
What is happening now, what really weighs on the present, and what the next sensible move is.

`04_decision_log.txt`
Keep already-won decisions here.
Not strong ideas. Not preferences.
Choices that have already beaten a real alternative and are already producing effects.

`05_latent_ideas.txt`
Keep material here that is still alive but not yet stable enough to belong elsewhere.
This is not a bin for the undecided.
It is where you keep what matters without promoting it too early.

`08_surface_map.txt`
Keep the project's real technical map here:
entrypoints, sensitive surfaces, critical dependencies, minimal runbook.

`09_handoff_reentry.txt`
Keep short continuity between sessions here:
handoff, re-entry, delta, short operational memory.

`98_parking.txt`
Put material here that is not active now but could still matter later.

`99_archive.txt`
Put material here that is closed, historical, or no longer alive.

Lateral support files

`97_field_findings.txt`
Keep lateral findings here when you want to capture bugs, refinements, signals, or seeds during a real pass without promoting them too early.
It is optional and non-canonical.

Kernel and guidance

`06_ai_to_ai.txt`
This is the system's operating kernel.
If you need to understand how the agent should read, stop, ask, propose, or write, start here.

`07_guided_prompts_test.txt`
This contains guided prompts and safe question flows.
Use it when you want to open a pass in a tighter and less chaotic way.

Marker

`AI_TO_AI__DEPLOYED_INSTANCE_SIGNAL_RAIL.txt`
This marks a folder as a deployed Signal Rail instance.
By itself, it does not tell you what the host project is, what the current target is, or which source has authority.

HOW TO USE IT FOR REAL

Signal Rail works well when you do not treat it as a pile of files to fill in, but as a layered system.

The normal order is:
- close the minimum frame you need
- recognize the shape of the content
- understand how stable it already is
- place it in the right container
- stop only if you are about to cross a real boundary of authority, meaning, continuity, or structure

In other words:
do not write in `03` just because something feels close.
Do not freeze something in `02` just because it sounds noble.
Do not place a line in `04` if it has not truly won yet.
Do not use `05` to postpone everything forever.

WHERE YOU WILL ENTER MOST OFTEN

In everyday work, you will usually enter here first:

`03_master_working.txt`
When you need to understand where the project really is now.

`05_latent_ideas.txt`
When something matters but does not yet have a stable home.

`09_handoff_reentry.txt`
When you need to re-enter the work without losing the thread.

`08_surface_map.txt`
When you need to understand where the project really lives technically.

`97_field_findings.txt`
When you want to keep lateral findings readable during a pass before routing or discarding them.

LOCAL TOOLING

Signal Rail can also have local support tooling, for example local HTML surfaces or other reading and writing helpers.

These tools can speed work up:
- they help you read faster
- they help you re-enter better
- they make important transitions more visible

But they are not the foundation of the system.
If they disappeared, the canonicals and the kernel should still hold.

BOOTSTRAP

To prepare a new instance, you have two connected entry points.

`init_signal_rail.bat`
This is the simplest Windows launcher.
It starts the bootstrap without requiring you to run everything manually.

`init_signal_rail.ps1`
This is the script that performs the real bootstrap logic and prepares the instance in the target folder.

In short:
- the `.bat` gets you in
- the `.ps1` does the real work

You do not need to know every internal detail to use the system.
You only need to know that bootstrap prepares the instance and leaves you with the minimum files you should start from.

IF YOU ARE DEVELOPING SIGNAL RAIL ITSELF

When you are working on Signal Rail as a project, it helps to keep the separation very readable between:
- the kit repository
- a deployed instance
- any host project

That separation prevents a lot of confusion, especially when you work with an agent.

The clean kit repository is not the same thing as the live operational instance.
The live operational instance is not automatically the host project.
Keeping those boundaries readable makes everything easier later, not only now.

IN ONE SENTENCE

Signal Rail does not exist to produce more text.
It exists to give the right text the right level at the right time.

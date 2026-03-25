![Signal Rail banner](assets/signal-rail-banner.png)

# Signal Rail

> Think. Throw. Unearth.

Most AI-assisted projects don't fail because the AI is bad.  
They fail because the context collapses.

Ideas pile up with no weight attached. Decisions scatter across chats. A passing thought gets treated like a structural constraint. A real constraint gets buried in generic discussion. The longer the project runs, the harder it becomes to recover the thread, and the more time gets spent rebuilding context instead of moving the work forward.

Signal Rail exists to stop that collapse.

It is a plain-text document system that gives different kinds of project material different places to live, with different levels of authority. It does not make a project simpler than it is. It makes it more readable, more continuous, and much harder to lose while it grows and changes shape.

---

## 🧭 How it actually works

You start by giving the agent the runtime entry layer, then the kernel, and then work from a real project conversation.

> *"I have an idea - a counter in position X that pulls data from Y."*

The agent weighs it and places it in the right file at the right level. If it is still a hypothesis, it lands in `05_latent_ideas.txt` - alive, tracked, not promoted too early. If it is already driving current work, it goes into `03_master_working.txt`. If it has already won against a real alternative and is already in effect, it goes into `04_decision_log.txt`.

You think out loud. Signal Rail governs where things land.

That is the loop: **Think. Throw. Unearth.**

Three sessions later, you are working on something else entirely. You ask the agent to read `00_runtime_entry.txt`, then `06_ai_to_ai.txt`.

It enters `05_latent_ideas.txt`, moves through ideas from weeks ago - each one carrying a state, a weight, and a likely direction - and surfaces the one that fits exactly what you are doing now.

You did not remember it was there. Without the system, the chances are close to zero. With the system, it is just a read.

---

## 🧱 Three things worth naming

**The freeze.**  
`02_protocol_freeze.txt` holds the identity constants of the project: the points that, if removed, would make the project stop being itself. Not a preference list. Not strong ideas. The line the system does not cross without explicit human authority. The agent treats it as non-negotiable.

**The latent layer.**  
`05_latent_ideas.txt` is not a bin for the undecided. It is a pressure buffer: ideas enter as *new*, mature to *to review*, and only leave toward a stronger canonical file when they are solid enough. Nothing is lost. Nothing contaminates the present before it has earned its place there.

**The entry layer.**  
`00_runtime_entry.txt` closes valid entry, minimum read, and reading boundaries before the kernel becomes operative. It is the threshold between opening the system and moving inside it.

**The kernel.**  
`06_ai_to_ai.txt` is not written for the human operator. It is written for the agent. It governs activation, mode discipline, canonical authority, and the conditions under which the agent must stop and ask. Once loaded, the agent does not need to be micro-managed. It knows the structure and works inside it.

---

## 🌍 What it works across

Signal Rail does not care what you are building. The problem it solves is the same whether you are writing software, managing a renovation, designing a system, or running any long project where an AI is part of how you think and decisions accumulate over time.

No database. No plugins. No proprietary format. Plain text that works in any chat interface with any AI.

---

## 🚀 Quick start

1. Run `init_signal_rail.bat` on Windows to bootstrap a new instance in your target folder.
2. Open a chat with your AI and say: `read 00_runtime_entry.txt`
3. Then move into: `read 06_ai_to_ai.txt`
4. Let the agent close the minimum frame: what the project is, what you are working on, and which mode you are in.
5. Start from there.

For a non-English version, use **SR Localization Kit** to create a separate localized copy before you begin. Do not localize the baseline in place.

Signal Rail exists here as the clean baseline kit, not as a live host-project surface by default.

---

<details>
<summary><strong>⚙️ Full canonical reference</strong></summary>

### 📚 Canonical files

`01_orientation.txt`  
Project identity, perimeter, and reading frame. This is where the project remains understandable as itself.

`02_protocol_freeze.txt`  
Identity constants. The points that, if removed, would make the project stop being itself. Hard to reopen by design.

`03_master_working.txt`  
The current live state of the project: where it is now, what is active, what is blocking it, and what the next sensible move is.

`04_decision_log.txt`  
Already-won decisions. Not preferences, not strong possibilities - choices that have already beaten a real alternative and are already in effect.

`05_latent_ideas.txt`  
Material that matters but is still mobile. Where live but unresolved ideas stay visible without being promoted too early.

`08_surface_map.txt`  
The real technical map: entrypoints, sensitive surfaces, critical dependencies, and the minimum safe runbook.

`09_handoff_reentry.txt`  
Short continuity between sessions. Useful for re-entry, not canonical project truth.

`97_field_findings.txt`  
Lateral captures during an active pass - signals, seeds, refinements - before routing or discarding them.

`98_parking.txt`  
Not active now, could still matter later.

`99_archive.txt`  
Closed, historical, no-longer-live.

### 🧠 Kernel and guidance

`00_runtime_entry.txt`  
Runtime entry manual. Closes valid entry and correct system reading before the kernel becomes operative.

`06_ai_to_ai.txt`  
The operating kernel for agent behavior inside Signal Rail. How the agent reads, stops, asks, proposes, and writes.

`07_guided_prompts_test.txt`  
Guided prompts and safer opening flows for tighter, less chaotic session starts.

`AI_TO_AI__DEPLOYED_INSTANCE_SIGNAL_RAIL.txt`  
Marker file. Identifies a folder as a deployed Signal Rail instance. Does not identify the host project or authoritative source by itself.

### Runtime mechanics

Signal Rail is not only a set of containers. It also has a runtime shape:

| Surface | What it does |
| --- | --- |
| `00_runtime_entry.txt` | Closes valid entry, minimum read, and reading boundaries before the rest of the system is used operationally. |
| `06_ai_to_ai.txt` | Governs shared execution behavior once entry is valid. |
| `AI QUICK NOTE` + `AI SECTION` blocks | Give the local operational rule source for a specific canonical file. |
| Canonical files | Carry authority-bearing project truth at different levels. |
| Support files | Remain useful without claiming the same truth status as canonicals. |

In practice, the system now opens like this:

1. `00_runtime_entry.txt` closes how to enter.
2. `06_ai_to_ai.txt` closes how the agent may move.
3. Canonicals and support files are then read according to task sensitivity.

### Authority and routing model

Signal Rail does not route material by convenience. It routes by **nature**, **stability**, and **authority**.

| If the material is... | Ask first... | Likely destination |
| --- | --- | --- |
| project identity | does this define what the project is? | `01_orientation.txt` |
| hard-to-reopen constant | would removing this change project identity? | `02_protocol_freeze.txt` |
| current live work | is this already guiding present work? | `03_master_working.txt` |
| already-won choice | has this already beaten a real alternative and entered effect? | `04_decision_log.txt` |
| live but unresolved | does it matter, but still need to stay mobile? | `05_latent_ideas.txt` |
| technical topology | is this about where to enter, what is sensitive, or what is minimally required to work safely? | `08_surface_map.txt` |
| continuity only | is this mainly for handoff or re-entry? | `09_handoff_reentry.txt` |

That is why Signal Rail distinguishes containers so aggressively: a good sentence is not yet a decision, a strong idea is not yet freeze, and continuity is not the same thing as truth.

### Modes, minimum read, and safety

The kernel is strict about a few things because they are what prevent drift:

- one active mode at a time
- minimum read before substantive action
- no promotion when level, authority, or destination are still unclear
- no inference of authority from freshness, cleanliness, or confidence
- fail-closed behavior on meaningful ambiguity

This also means Signal Rail is not a "fill in the files" system. It is a bounded operating model:

- read enough to close frame
- extract before classifying
- classify before promoting
- delay safely instead of forcing the wrong destination

### 🛠️ Bootstrap

`init_signal_rail.bat`  
Windows launcher. Gets you in.

`init_signal_rail.ps1`  
Performs the actual bootstrap logic. Does the real work.

### 🌐 Localization Kit

`SR Localization Kit` handles one specific job: turning the international baseline into one personal localized copy.

The intended flow is:
1. keep the baseline clean
2. create a separate copy
3. localize the copy
4. validate the result
5. work from that copy

It is not a runtime translation layer.  
It is not a way to relocalize a live instance in place.

### 🧭 Operational boundaries

The kit repository is not the host project.  
A deployed Signal Rail instance is not the same thing as the clean baseline repository.  
A folder marked as a deployed instance does not identify the host project by itself.  
Entry validity is closed in `00_runtime_entry.txt`; execution behavior is governed in `06_ai_to_ai.txt`.  
If local tooling changes or disappears, the canonicals and the kernel should still remain readable and usable.

</details>

---

<details>
<summary><strong>🤝 Human + AI note</strong></summary>

Signal Rail is a human-led project by **XxYouDeaDPunKxX**.

Its concept, structure, behavioral logic, and final direction come from me.  
AI was used as a working partner during development to help with drafting, rewriting, refinement, iteration speed, and support material.

</details>

---

## 📄 License

See `LICENSE`.

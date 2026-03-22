SR LOCALIZATION KIT

SR Localization Kit is a parallel kit for one specific job:
turning a fresh international Signal Rail kit into a personal localized copy.

It is not a translation tool for live instances.
It is not a multilingual runtime layer.
It is not a way to relocalize a kit already in active use.

Use it only when:
- you are starting from a fresh international SR kit
- you want one stable personal language version
- you want to keep Signal Rail structurally intact while changing its language

Do not use it when:
- the instance already contains live project truth
- the kit has already become your active operational surface
- you want to switch language in place

Expected input
- one fresh international Signal Rail kit in a source folder

Expected output
- one personal localized Signal Rail core in a separate target folder

Core rule
- copy first, then localize
- never localize the international baseline in place
- localize once, at the beginning
- then work only from that localized kit

How localization happens
- Codex or another agent does the localization work in the target copy.
- `audit_localization.ps1` checks the result afterward against the shipped international English baseline profile.
- The validator does not translate the kit by itself.
- The validator is not a universal language validator.
- The validator checks the localized SR core, not this support-tool folder.
- A clean validator result means no baseline-English residue and no detected bootstrap/template mismatch in the localized SR core.
- Validation is separate from localization on purpose.

Use order
1. Create a separate target copy from the fresh international kit.
2. Read `FIRST_LANGUAGE_SETUP_PROTOCOL.txt`.
3. Lock the vocabulary in `CANONICAL_VOCABULARY.txt`.
4. Use `CODEX_PROMPT.txt` with your agent if needed.
5. Review the result with `LOCALIZATION_CHECKLIST.txt`.
6. Validate the localized kit with `audit_localization.ps1`.

What stays stable
- file names
- ID families
- marker file name
- system name: `Signal Rail`
- core structure

What changes
- user-facing text
- section titles
- template labels
- form tags
- launcher messages
- protocol wording where needed to stay aligned with the localized canonicals
- shipped lateral support files that belong to the SR core, such as `97_field_findings.txt`

What stays out of localization scope by default
- this `SR Localization Kit` support folder
- validator internals
- baseline support tooling that is only used to perform localization

Short formula
- the fresh international kit is the source
- Codex performs the localization
- the validator checks the result
- the personal localized copy becomes the user's working base

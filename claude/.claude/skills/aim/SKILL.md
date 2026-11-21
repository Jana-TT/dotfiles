---
name: aim
description: Interview the user until a change's current state, desired state and verification are clear, then write a brief to plans/<slug>.md to feed /speckit-specify.
argument-hint: "[idea: anything from one line to a pasted write-up]"
disable-model-invocation: true
---

# aim: turn an idea into a brief for speckit-specify

Input: `$ARGUMENTS`, anything from one line ("switch quote upload to S3 presigned
URLs") to a long pasted write-up. Treat it as a draft, never as the finished brief.

Requirements level only. Do not design the implementation. A design the user states
goes under Constraints, unexpanded; invent none.

## 1. Read first

- If `.specify/memory/constitution.md` exists, read it. Cite the principles that bear
  on this change by id in the brief; never copy their text.
- Skim `plans/` for related briefs so this one builds on them.
- Look up facts yourself (code, schema, config, specs). Use a subagent for broad
  sweeps. Never ask the user for something you can find.

## 2. Sort the input

Sort what was given into Background, Task and Testing (below). Mark each as clear,
thin or missing. A long input is mostly clear: ask only about the gaps and the
unstated edge cases, never re-ask what it already says.

## 3. Interview

- Your first message is a question, never a draft. With no input, ask what the change
  should accomplish.
- One AskUserQuestion per message, at most 4 options, recommended option first and
  labelled "(Recommended)". Use `multiSelect` for list items. Ask in prose only when
  you cannot list candidates.
- Stop when all three are solid:
  - Background is accurate, with the current state checked against the code.
  - Task is a declarative end state a reader could check.
  - Testing says exactly how we will know the end state was reached.
- If the change is too large for one spec, say so and propose splitting into briefs.

## 4. Write the brief

Show the draft, then AskUserQuestion: "Write as drafted (Recommended)" / "Edit first".
On approval write `plans/<slug>.md` (create `plans/` if needed; slug from the topic,
no numbers).

```markdown
# <title>

**Defined:** <YYYY-MM-DD>

## Background
The situation and current state, numbered, each point a verified fact. Include the
dependencies this change relies on (earlier specs, services, data, decisions).

## Task
The desired end state, declarative and numbered: what is true afterwards, not the
steps to get there. Each point testable. Include the user's stated mechanisms
verbatim (e.g. "unique key in the Flyway migration").

## Testing
How we verify the Task was reached, as numbered steps. For A/B: the baseline (A) and
changed (B) artifact, the setup, what is recorded each step (fetches, row counts,
screenshots, DB rows), the format of the evidence (CSV, markdown table for the PR
description), and the expected result for each side. Otherwise, the tests or manual
checks that prove each Task point.
```

Add these sections only when the interview produced content for them:

- **Out of scope**: what the spec must not drift into.
- **Constraints / early decisions**: user-stated design preferences and constitution
  principle ids.
- **Key code touchpoints**: files and subsystems to read first, and invariants to
  verify (e.g. "X should need no changes").
- **Open questions**: deferred to `/speckit-clarify`.

## 5. Hand off

Confirm the path, then print and stop. Never run it yourself:

> **Next step:** `/speckit-specify plans/<slug>.md`

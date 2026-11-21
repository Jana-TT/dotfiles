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

## 2b. Do the homework before asking

The brief feeds `/speckit-specify`, which starts cold. Make it self-contained:

- **Refine, don't transcribe.** For a long input, rewrite it for specify: remove
  chatter and duplication, keep every fact, number and stated mechanism, and keep the
  user's meaning. Never drop a requirement to tidy.
- **Resolve shorthand.** The user will use short names, abbreviations and references
  ("the lanes", "banner style from spec 010", "the dt rows"). Find what each one
  actually is in the code, specs and docs, and write the concrete reference in the
  brief: file paths, route and function names, spec ids, table and column names, real
  examples of the current behavior. If a term has several plausible meanings, ask.
- **Sweep each list for what's missing.** A list the user gives (pages, endpoints,
  tables, templates, jobs) is usually a few examples from live features, not the whole
  set. For every list, search the codebase for other places the same change applies
  (rg/fd, route tables, templates, the architecture and guard tests, specs). Report
  the full set you found, marking which the user named and which you added.
  Interview the user on each added item: include, exclude (record under Out of
  scope), or defer (record under Open questions). Never silently widen or narrow the
  scope.

## 3. Interview

- Your first message is a question, never a draft. With no input, ask what the change
  should accomplish.
- One AskUserQuestion per message, at most 4 options, recommended option first and
  labelled "(Recommended)". Use `multiSelect` for list items. Ask in prose only when
  you cannot list candidates.
- Put the added list items from the sweep to the user with `multiSelect`, so each
  can be accepted or dropped.
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
The situation and current state, numbered, each point a verified fact with its
concrete reference (path, route, spec id, real example). Include the dependencies
this change relies on (earlier specs, services, data, decisions).

## Task
The desired end state, declarative and numbered: what is true afterwards, not the
steps to get there. Each point testable. Include the user's stated mechanisms
verbatim (e.g. "unique key in the Flyway migration"). Every list is the full agreed
set from the sweep, not just the user's examples.

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

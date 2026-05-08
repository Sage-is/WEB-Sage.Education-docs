# TODO - Project Development Tasks

This file tracks active work for TodoScope.

> **Convention** - Sections below map to kanban columns. Inline source-code
> tags use the same vocabulary so items stay cross-referenced between this
> file and the codebase. `KANBAN.canvas` auto-generates from this file and
> inline tags - do not hand-edit it.
>
> | Column      | Markdown section   | Inline tag  |
> |-------------|--------------------|-------------|
> | Backlog     | `## Backlog`       |             |
> | TODO        | `## TODO`          | `# TODO:`   |
> | In Progress | `## In Progress`   | `# FIXME:`  |
> | Bugs        | `## Bugs`          | `# BUG:`    |
> | Done        | `- [x]` items / `## Done` | -   |
>
> `# DEPRECATED:` tags should be tracked as TODO items for removal at the
> stated version.

## In Progress

- [ ] **TodoScope Bootstrap**: Align repo task tracking files for kanban ingestion
	- [x] Create `.todoscope-exclude.csv` with baseline exclusions
	- [ ] Confirm exclude paths still match repository build and cache outputs

## TODO

### TodoScope Alignment

- [ ] **Inline Tag Vocabulary Migration**: Standardize inline task tags in code and docs
	- [ ] Use TodoScope scan output to migrate to `TODO:` / `FIXME:` / `BUG:` only
	- [ ] Add TODO entries for any discovered `DEPRECATED:` removals by version

- [ ] **TODO.md Curation Pass**: Add current roadmap items as parent cards with subtasks
	- [ ] Group cards by milestone or area using `###` subsection headers
	- [ ] Add stakeholder and hashtag metadata where useful

- [ ] **Convention Sync Validation**: Verify board mapping after scan
	- [ ] Run TodoScope scanner and confirm columns match expected mapping
	- [ ] Adjust section aliases if board columns differ from intent

### From Codebase (untracked)

- [ ] **Scanner Intake Pending**: Waiting for first TodoScope scan results
	- [ ] Import untracked inline work into curated TODO cards

## Backlog

- [ ] **Task Taxonomy Improvements**: Improve consistency and readability over time
	- [ ] Define stable naming convention for parent card titles
	- [ ] Add recurring cleanup cadence for moving completed items to archive

## Bugs

_No known bugs. Use `# BUG:` inline tags to flag defects in source._

## Done

- [x] **Initial TodoScope Setup**: Establish baseline files and structure
	- [x] Add `.todoscope-exclude.csv`
	- [x] Create TodoScope-aligned `TODO.md` scaffold

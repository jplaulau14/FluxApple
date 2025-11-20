# Block 08: Natural Language Input - Parser

**Priority:** High
**Dependencies:** Block 00-05 (Core models, CRUD, Projects, Dates, Priority)
**Estimated Complexity:** Very High

## Overview
Implement natural language processing for task input. Parse text like "Pay rent tomorrow 5pm #Finance @Bills p1" to extract task title, due date/time, project, labels, and priority. Provide inline feedback showing parsed elements as user types.

---

## Client-Side To-Do Items

### NLP Input Field
- [ ] Create `NLPTaskInputField` component with enhanced text field
- [ ] Style input field to stand out (larger, prominent)
- [ ] Add placeholder with example syntax
- [ ] Support multi-line input for longer descriptions

### Inline Parsing Feedback
- [ ] Display parsed elements as chips/badges while typing:
  - Date chip (e.g., "Tomorrow 5pm")
  - Project chip (e.g., "#Finance")
  - Label chips (e.g., "@Bills", "@Urgent")
  - Priority chip (e.g., "P1", "!!!high")
- [ ] Position chips below or inline with input
- [ ] Color-code chips by type (date=blue, project=purple, etc.)
- [ ] Make chips interactive (click to edit/remove)
- [ ] Show parsing confidence (optional: low confidence in yellow)

### Syntax Highlighting
- [ ] Highlight recognized patterns in input text:
  - Dates: "tomorrow", "5pm", "next Monday"
  - Projects: "#ProjectName"
  - Labels: "@LabelName"
  - Priority: "p1", "!!!", "high"
- [ ] Use subtle color/underline for highlights
- [ ] Update highlights in real-time as user types

### Parser Feedback
- [ ] Show warning if unable to parse date expression
- [ ] Suggest corrections for ambiguous input
- [ ] Display fallback message: "Entire text will be used as task title"
- [ ] Add "?" help icon with syntax guide

### Syntax Help
- [ ] Create syntax guide modal/popover
- [ ] Include examples:
  - "Buy milk tomorrow"
  - "Review report Friday 2pm #Work"
  - "Call dentist next week @phone p2"
  - "Submit invoice every month @finance"
- [ ] Show all supported patterns and keywords

---

## Logic-Side To-Do Items

### Parser Architecture
- [ ] Create `NLPParser` class as main parser
- [ ] Design parser pipeline: tokenize → extract → validate → construct
- [ ] Implement modular sub-parsers for each element type
- [ ] Create `ParseResult` struct:
  - `title: String` (cleaned title)
  - `dueDate: Date?`
  - `dueTime: Date?`
  - `project: String?` (name to resolve later)
  - `labels: [String]` (names to resolve later)
  - `priority: Priority?`
  - `recurrence: String?` (raw recurrence text)
  - `confidence: ParseConfidence` (high/medium/low)

### Date/Time Parser
- [ ] Create `DateTimeParser` sub-parser
- [ ] Implement relative date parsing:
  - "today", "tomorrow", "yesterday"
  - "tonight" (today at 8pm default)
  - "next Monday", "next week", "next month"
  - "this Friday", "this weekend"
  - "in 2 days", "in 3 weeks", "in 1 month"
- [ ] Implement absolute date parsing:
  - "March 15", "15th", "3/15", "2025-03-15"
  - "Mar 15th", "15 March"
- [ ] Implement time parsing:
  - "5pm", "5:30pm", "17:00", "5:30 PM"
  - "at 5pm", "@ 5pm"
  - "noon", "midnight"
  - "morning" (9am), "afternoon" (2pm), "evening" (6pm)
- [ ] Implement combined date-time:
  - "tomorrow 5pm", "Friday at 2pm", "3/15 at 9am"
- [ ] Use Foundation's `DataDetector` or custom regex
- [ ] Handle edge cases: past dates, invalid dates

### Project Parser
- [ ] Create `ProjectParser` sub-parser
- [ ] Detect project markers: "#ProjectName"
- [ ] Support multi-word projects: "#Project Name" or "#ProjectName"
- [ ] Extract all project mentions (take first one if multiple)
- [ ] Validate project exists or mark for creation
- [ ] Remove project markers from final title

### Label Parser
- [ ] Create `LabelParser` sub-parser
- [ ] Detect label markers: "@LabelName"
- [ ] Support multiple labels: "@home @urgent @email"
- [ ] Extract all label mentions
- [ ] Validate labels exist or mark for creation
- [ ] Remove label markers from final title

### Priority Parser
- [ ] Create `PriorityParser` sub-parser
- [ ] Detect priority markers:
  - Explicit: "p1", "p2", "p3", "p4", "P1", "P2", etc.
  - Symbols: "!!!" (p1), "!!" (p2), "!" (p3)
  - Keywords: "high", "urgent" (p1), "medium" (p2), "low" (p3)
- [ ] Extract priority (take highest if multiple)
- [ ] Remove priority markers from final title

### Recurrence Parser (Basic)
- [ ] Create `RecurrenceParser` sub-parser
- [ ] Detect recurrence patterns:
  - "every day", "daily"
  - "every week", "weekly"
  - "every Monday", "every Friday"
  - "every month", "monthly"
  - "every 2 weeks", "every 3 days"
  - "on weekdays", "on weekends"
- [ ] Extract recurrence rule (parse to RecurrenceRule in Block 04)
- [ ] Keep or remove recurrence from title (configurable)

### Title Cleaning
- [ ] Remove all parsed markers from original text
- [ ] Trim whitespace
- [ ] Collapse multiple spaces to single space
- [ ] Ensure remaining text is not empty
- [ ] If empty, provide error or use placeholder

### Parser Integration
- [ ] Implement `parse(_:)` method taking raw text
- [ ] Run all sub-parsers on input
- [ ] Combine results into `ParseResult`
- [ ] Resolve project/label names to actual entities
- [ ] Create or fetch projects/labels as needed
- [ ] Return complete parsed task data

### Fallback Behavior
- [ ] If parsing fails entirely, use whole text as title
- [ ] If partial parse, use best effort (extract what's possible)
- [ ] Never crash or block task creation due to parse failure
- [ ] Log parse errors for debugging

---

## Testing To-Do Items

### Unit Tests - Date/Time Parser
- [ ] Test "today" parses to today's date
- [ ] Test "tomorrow" parses to tomorrow's date
- [ ] Test "next Monday" parses to correct date
- [ ] Test "in 2 days" parses correctly
- [ ] Test "5pm" parses to 5:00 PM
- [ ] Test "5:30pm" parses to 5:30 PM
- [ ] Test "tomorrow 5pm" parses both date and time
- [ ] Test "March 15" parses to correct date
- [ ] Test "3/15" parses to correct date
- [ ] Test "noon" and "midnight" parse correctly
- [ ] Test ambiguous dates default to future (e.g., "Monday" = next Monday)
- [ ] Test invalid dates return nil or error

### Unit Tests - Project Parser
- [ ] Test "#Work" extracts project "Work"
- [ ] Test "#Project Name" extracts "Project Name"
- [ ] Test multiple "#Work #Home" extracts first project
- [ ] Test no project marker returns nil
- [ ] Test "#" alone is ignored

### Unit Tests - Label Parser
- [ ] Test "@email" extracts label "email"
- [ ] Test "@home @urgent" extracts both labels
- [ ] Test no label marker returns empty array
- [ ] Test "@" alone is ignored

### Unit Tests - Priority Parser
- [ ] Test "p1" parses to Priority.p1
- [ ] Test "!!!" parses to Priority.p1
- [ ] Test "high" parses to Priority.p1
- [ ] Test "medium" parses to Priority.p2
- [ ] Test "low" parses to Priority.p3
- [ ] Test no priority marker returns nil

### Unit Tests - Recurrence Parser
- [ ] Test "every day" extracts daily recurrence
- [ ] Test "every Monday" extracts weekly Monday recurrence
- [ ] Test "every 2 weeks" extracts biweekly recurrence
- [ ] Test "on weekdays" extracts weekday recurrence

### Unit Tests - Title Cleaning
- [ ] Test "Pay rent tomorrow #Finance" → title = "Pay rent"
- [ ] Test "Buy milk @groceries p1" → title = "Buy milk"
- [ ] Test full example "Call doctor tomorrow 5pm #Health @phone p2" extracts all elements and title = "Call doctor"
- [ ] Test input with only markers returns error or placeholder

### Integration Tests
- [ ] Test parsing full task string creates task with all properties
- [ ] Test parsing "Pay rent tomorrow #Finance" creates task with due date and project
- [ ] Test parsing task with non-existent project creates project
- [ ] Test parsing task with non-existent label creates label
- [ ] Test parsing task and saving to database
- [ ] Test parsing handles various date formats consistently

### UI Tests
- [ ] Test typing "tomorrow" shows date chip
- [ ] Test typing "#Work" shows project chip
- [ ] Test typing "@urgent" shows label chip
- [ ] Test typing "p1" shows priority chip
- [ ] Test chips update in real-time as user types
- [ ] Test clicking chip opens editor for that element
- [ ] Test final task creation uses parsed values

### Edge Cases
- [ ] Test very long input (>1000 characters)
- [ ] Test input with special characters
- [ ] Test input with emoji
- [ ] Test input in different languages (if localized)
- [ ] Test multiple dates in input (should use first or last?)
- [ ] Test multiple projects in input (which one takes precedence?)
- [ ] Test conflicting priorities "p1 p4" (should use higher priority)
- [ ] Test date without year defaults to current year
- [ ] Test past dates (e.g., "yesterday") - warn or adjust?

---

## Acceptance Criteria

- ✅ Users can input tasks using natural language
- ✅ Parser extracts dates, times, projects, labels, and priority
- ✅ Inline feedback shows parsed elements as chips
- ✅ Syntax highlighting helps users see recognized patterns
- ✅ Parser handles common date expressions (today, tomorrow, next week, etc.)
- ✅ Parser handles time expressions (5pm, noon, etc.)
- ✅ Parser handles project markers (#Project)
- ✅ Parser handles label markers (@Label)
- ✅ Parser handles priority markers (p1, !!!, high, etc.)
- ✅ Parser handles basic recurrence patterns (every day, etc.)
- ✅ Title is cleaned of all markers
- ✅ Fallback behavior ensures task creation never fails
- ✅ All tests pass with >70% coverage

---

## Notes

- Start with English language support, localize later
- Use iOS/macOS native date parsing where possible
- Consider using `NSDataDetector` for date detection
- Parser should be extensible for future patterns
- Performance is critical - parsing should feel instant
- Consider caching parse results to avoid re-parsing
- Add telemetry to track which patterns are most/least used
- Syntax guide should be easily accessible (? icon or keyboard shortcut)
- Consider adding autocomplete for projects and labels
- Parser confidence scoring can guide UI feedback (low confidence = yellow chip)

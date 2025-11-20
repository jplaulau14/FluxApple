# Block 04: Recurrence System

**Priority:** Medium
**Dependencies:** Block 00 (Core Task Model), Block 01 (Basic Task CRUD), Block 03 (Date & Time Handling)
**Estimated Complexity:** High

## Overview
Implement recurring task functionality including daily, weekly, monthly, yearly patterns, relative repeats, and weekday-based recurrence. When a recurring task is completed, automatically generate the next instance based on the recurrence rule.

---

## Client-Side To-Do Items

### Recurrence Picker UI
- [ ] Create `RecurrencePicker` component with recurrence options
- [ ] Add recurrence type selector:
  - None (default)
  - Daily
  - Weekly
  - Monthly
  - Yearly
  - Custom
- [ ] Create custom recurrence editor:
  - Repeat every N days/weeks/months/years selector
  - Weekday selector for weekly recurrence (M, T, W, Th, F, Sa, Su)
  - Month day selector for monthly recurrence
  - End date or occurrence count (optional)
- [ ] Add "Weekdays" and "Weekends" quick-select options
- [ ] Display recurrence summary in human-readable format:
  - "Every day"
  - "Every Monday and Friday"
  - "Every 2 weeks"
  - "Every 1st of the month"

### Task Row Recurrence Display
- [ ] Add recurrence icon/badge to recurring task rows
- [ ] Show recurrence summary on task detail view
- [ ] Display "Next occurrence" date for recurring tasks

### Recurrence Editing
- [ ] Allow editing recurrence rule without affecting past instances
- [ ] Add "Edit This Instance" vs "Edit All Future" option
- [ ] Show warning when changing recurrence affects future tasks
- [ ] Allow stopping recurrence (set end date to now)

### Completion Handling UI
- [ ] Show completion confirmation for recurring tasks
- [ ] Display "Task completed, next due: [date]" message
- [ ] Option to skip next occurrence when completing
- [ ] Option to complete all future occurrences (end recurrence)

---

## Logic-Side To-Do Items

### Recurrence Model
- [ ] Create `RecurrenceRule` model or struct:
  - `frequency: RecurrenceFrequency` (enum: daily, weekly, monthly, yearly)
  - `interval: Int` (every N days/weeks/months)
  - `weekdays: [Weekday]?` (for weekly recurrence)
  - `monthDay: Int?` (for monthly recurrence, 1-31)
  - `endDate: Date?` (optional end date)
  - `occurrenceCount: Int?` (optional max occurrences)
- [ ] Create `RecurrenceFrequency` enum: daily, weekly, monthly, yearly, custom
- [ ] Create `Weekday` enum: monday, tuesday, wednesday, thursday, friday, saturday, sunday
- [ ] Add `recurrenceRule: RecurrenceRule?` to Task model
- [ ] Add `recurrenceParentId: UUID?` to Task model (link to original recurring task)

### Recurrence Calculation Engine
- [ ] Create `RecurrenceEngine` class
- [ ] Implement `nextOccurrence(from:rule:)` method
- [ ] Implement daily recurrence calculation (every N days)
- [ ] Implement weekly recurrence calculation (specific weekdays)
- [ ] Implement monthly recurrence calculation (same day each month)
- [ ] Implement yearly recurrence calculation
- [ ] Implement relative recurrence (from completion date vs from due date)
- [ ] Handle edge cases:
  - Month day 31 in months with 30 days (use last day of month)
  - February 29-31 handling
  - Weekday calculations across month boundaries

### Task Generation
- [ ] Implement automatic next task generation on completion
- [ ] Create `completeRecurringTask(_:)` method
- [ ] Generate next task instance with:
  - New due date based on recurrence rule
  - Same title, description, project, labels
  - Same priority
  - Status reset to inbox/active
  - New unique ID
  - Link to parent via recurrenceParentId
- [ ] Implement "generate ahead" strategy (create next N occurrences in advance)

### Task Service Updates
- [ ] Implement `setRecurrence(_:rule:)` method
- [ ] Implement `clearRecurrence(_:)` method
- [ ] Implement `stopRecurrence(_:)` method (set end date to now)
- [ ] Implement `fetchRecurringTasks()` method
- [ ] Implement `fetchTaskInstances(parent:)` method
- [ ] Update completion logic to handle recurring tasks

### Recurrence Validation
- [ ] Validate interval is positive
- [ ] Validate weekdays are selected for weekly recurrence
- [ ] Validate month day is between 1-31
- [ ] Validate end date is after start date
- [ ] Validate occurrence count is positive

---

## Testing To-Do Items

### Unit Tests - Recurrence Model
- [ ] Test `RecurrenceRule` initialization with all properties
- [ ] Test `RecurrenceRule` with minimal properties (frequency only)
- [ ] Test `RecurrenceFrequency` enum cases
- [ ] Test `Weekday` enum cases and ordering

### Unit Tests - Recurrence Engine
- [ ] Test daily recurrence: next occurrence is N days later
- [ ] Test weekly recurrence: next occurrence is same weekday next week
- [ ] Test weekly recurrence with multiple weekdays (e.g., M/W/F)
- [ ] Test monthly recurrence: next occurrence is same day next month
- [ ] Test monthly recurrence on day 31 in 30-day month (should use day 30)
- [ ] Test monthly recurrence on Feb 29-31 (should use Feb 28/29)
- [ ] Test yearly recurrence: next occurrence is same date next year
- [ ] Test yearly recurrence on Feb 29 in non-leap year
- [ ] Test recurrence with interval > 1 (every 2 weeks, every 3 months)
- [ ] Test weekday-based recurrence (Monday-Friday)
- [ ] Test weekend-based recurrence (Saturday-Sunday)
- [ ] Test recurrence respects end date
- [ ] Test recurrence stops after occurrence count reached

### Unit Tests - Task Generation
- [ ] Test completing recurring task generates next instance
- [ ] Test next instance has correct due date
- [ ] Test next instance preserves title, project, labels
- [ ] Test next instance has status reset to inbox
- [ ] Test next instance has unique ID
- [ ] Test next instance links to parent via recurrenceParentId
- [ ] Test completing non-recurring task does not generate instance
- [ ] Test recurrence stopped by end date does not generate instance

### Unit Tests - Recurrence Validation
- [ ] Test validation fails for zero or negative interval
- [ ] Test validation fails for weekly recurrence without weekdays
- [ ] Test validation fails for invalid month day (< 1 or > 31)
- [ ] Test validation fails for end date before start date
- [ ] Test validation fails for zero occurrence count

### Integration Tests
- [ ] Test creating recurring task with daily recurrence
- [ ] Test completing recurring task 5 times generates 5 instances
- [ ] Test recurring task instances persist across app restarts
- [ ] Test editing recurrence rule updates future tasks
- [ ] Test stopping recurrence prevents further generation
- [ ] Test fetching all instances of recurring task
- [ ] Test deleting parent recurring task (decide on cascade behavior)

### UI Tests
- [ ] Test selecting daily recurrence in picker
- [ ] Test selecting weekly recurrence and choosing weekdays
- [ ] Test custom recurrence with interval
- [ ] Test recurrence summary displays correctly
- [ ] Test completing recurring task shows next occurrence date
- [ ] Test recurrence icon appears on recurring tasks
- [ ] Test editing recurrence rule from task detail view

### Edge Cases
- [ ] Test recurring task due on Feb 29 (leap year handling)
- [ ] Test monthly recurring task due on 31st in February
- [ ] Test very long recurrence (100+ instances)
- [ ] Test recurrence with both end date and occurrence count (which takes precedence?)
- [ ] Test completing recurring task early (before due date)
- [ ] Test completing recurring task late (after due date)
- [ ] Test timezone changes affecting recurrence calculation
- [ ] Test completing recurring task multiple times in quick succession

---

## Acceptance Criteria

- ✅ Users can set daily, weekly, monthly, yearly recurrence on tasks
- ✅ Users can set custom recurrence intervals (every N days/weeks/months)
- ✅ Users can set weekday-based recurrence (specific days of week)
- ✅ Users can set optional end date or occurrence count for recurrence
- ✅ Completing recurring task automatically generates next instance
- ✅ Next instance has correct due date based on recurrence rule
- ✅ Recurrence calculation handles edge cases (month boundaries, leap years)
- ✅ Users can edit or stop recurrence on existing recurring tasks
- ✅ Recurrence information is clearly displayed in UI
- ✅ All recurrence instances persist correctly
- ✅ All tests pass with >80% coverage

---

## Notes

- Consider "strict" vs "flexible" recurrence (from due date vs from completion date)
- Default behavior: generate next occurrence from original due date (strict)
- Optional behavior: generate next occurrence from completion date (flexible)
- For performance, limit "generate ahead" to 1-2 instances max
- Consider adding "skip next occurrence" feature
- Store recurrence rule as JSON or use proper SwiftData relationship
- Recurring task history should be queryable (all instances of a recurring task)
- Consider adding recurrence preview before saving ("Next 5 occurrences: ...")

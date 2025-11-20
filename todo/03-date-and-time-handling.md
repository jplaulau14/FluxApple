# Block 03: Date & Time Handling

**Priority:** High
**Dependencies:** Block 00 (Core Task Model), Block 01 (Basic Task CRUD)
**Estimated Complexity:** Medium

## Overview
Implement comprehensive date and time handling for tasks including due dates, due times, start dates, overdue detection, and basic date-based filtering. This block focuses on the foundational scheduling system without recurrence (recurrence is Block 04).

---

## Client-Side To-Do Items

### Date Picker UI
- [ ] Create `DatePickerView` component with calendar interface
- [ ] Implement time picker for specific due times
- [ ] Create quick-select date buttons:
  - Today
  - Tomorrow
  - Next Week
  - Custom date picker
- [ ] Add "Clear date" option
- [ ] Show selected date/time in human-readable format ("Today at 5pm", "Tomorrow", "Mar 15")

### Task Row Date Display
- [ ] Display due date on task row with appropriate formatting
- [ ] Show due time if set (e.g., "5:00 PM")
- [ ] Color-code dates based on urgency:
  - Overdue: red
  - Today: orange/yellow
  - Tomorrow: blue
  - Future: gray/default
- [ ] Add calendar icon next to date
- [ ] Show "No due date" state visually

### Overdue Indicator
- [ ] Create visual indicator for overdue tasks (red badge, exclamation mark)
- [ ] Display "X days overdue" label
- [ ] Show overdue count in Today view badge

### Start Date UI
- [ ] Add start date picker to task detail view
- [ ] Show "Starts on" label with date
- [ ] Add visual indicator for tasks with future start dates
- [ ] Implement "Hide until start date" toggle in settings

### Date Editing
- [ ] Add date/time editing to task edit form
- [ ] Allow changing all-day due date to specific time
- [ ] Allow removing due date entirely
- [ ] Show date validation errors (e.g., start date after due date)

---

## Logic-Side To-Do Items

### Date Properties (already in Task model, but ensure implementation)
- [ ] Verify `dueDate: Date?` stores date portion
- [ ] Verify `dueTime: Date?` stores time portion (or combine into single Date)
- [ ] Verify `startDate: Date?` stores start date
- [ ] Consider using single `Date` property with optional time component flag

### Date Utility Functions
- [ ] Create `DateUtility` class or extension
- [ ] Implement `isToday(_:)` function
- [ ] Implement `isTomorrow(_:)` function
- [ ] Implement `isOverdue(_:)` function
- [ ] Implement `isPast(_:)` function
- [ ] Implement `isFuture(_:)` function
- [ ] Implement `isThisWeek(_:)` function
- [ ] Implement `daysBetween(_:and:)` function
- [ ] Implement `startOfDay(_:)` function
- [ ] Implement `endOfDay(_:)` function

### Date Formatting
- [ ] Create `DateFormatter` utilities for consistent formatting
- [ ] Implement relative date formatting ("Today", "Tomorrow", "Yesterday")
- [ ] Implement absolute date formatting ("March 15, 2025")
- [ ] Implement time formatting ("5:00 PM", "17:00" based on locale)
- [ ] Implement combined date-time formatting ("Today at 5:00 PM")
- [ ] Implement "X days ago" / "X days until" formatting

### Computed Properties on Task
- [ ] Implement `isOverdue: Bool` computed property
- [ ] Implement `isToday: Bool` computed property
- [ ] Implement `isTomorrow: Bool` computed property
- [ ] Implement `daysUntilDue: Int?` computed property
- [ ] Implement `daysOverdue: Int?` computed property
- [ ] Implement `isScheduled: Bool` (has due date) computed property
- [ ] Implement `hasStarted: Bool` (past start date) computed property

### Task Service Updates
- [ ] Implement `setDueDate(_:date:time:)` method
- [ ] Implement `clearDueDate(_:)` method
- [ ] Implement `setStartDate(_:date:)` method
- [ ] Implement `clearStartDate(_:)` method
- [ ] Implement `fetchOverdueTasks()` method
- [ ] Implement `fetchTasksDueToday()` method
- [ ] Implement `fetchTasksDueTomorrow()` method
- [ ] Implement `fetchTasksDueThisWeek()` method
- [ ] Implement `fetchUpcomingTasks(days:)` method

### Date Validation
- [ ] Validate start date is not after due date
- [ ] Validate due date is a valid date
- [ ] Handle edge cases (leap years, daylight saving time transitions)
- [ ] Ensure dates respect user's timezone

### Background Processing
- [ ] Implement daily update check for overdue tasks (if app backgrounding supported)
- [ ] Update overdue status when app comes to foreground
- [ ] Consider using `@Query` with predicates for automatic filtering

---

## Testing To-Do Items

### Unit Tests - Date Utilities
- [ ] Test `isToday` with various dates (today, yesterday, tomorrow)
- [ ] Test `isToday` at edge times (12:00 AM, 11:59 PM)
- [ ] Test `isTomorrow` correctly identifies next day
- [ ] Test `isOverdue` with past dates and no due date
- [ ] Test `isOverdue` respects time component if present
- [ ] Test `daysBetween` calculation accuracy
- [ ] Test date utilities handle timezone correctly
- [ ] Test date utilities handle daylight saving time transitions

### Unit Tests - Date Formatting
- [ ] Test relative date formatter for "Today", "Tomorrow", "Yesterday"
- [ ] Test absolute date formatter
- [ ] Test time formatter with 12-hour and 24-hour locales
- [ ] Test combined date-time formatting
- [ ] Test "X days until" formatting with various day counts
- [ ] Test formatter handles nil dates gracefully

### Unit Tests - Computed Properties
- [ ] Test `isOverdue` for task with past due date
- [ ] Test `isOverdue` false for future due date
- [ ] Test `isOverdue` false for nil due date
- [ ] Test `isToday` for task due today with and without time
- [ ] Test `daysUntilDue` calculation
- [ ] Test `daysOverdue` calculation
- [ ] Test `hasStarted` for task with start date in past

### Unit Tests - Task Service Date Methods
- [ ] Test setting due date on task
- [ ] Test setting due time on task with due date
- [ ] Test clearing due date removes both date and time
- [ ] Test setting start date
- [ ] Test clearing start date
- [ ] Test `fetchOverdueTasks` returns only overdue tasks
- [ ] Test `fetchTasksDueToday` returns only today's tasks
- [ ] Test `fetchTasksDueToday` includes tasks without specific time
- [ ] Test `fetchUpcomingTasks` returns tasks in date range

### Unit Tests - Date Validation
- [ ] Test validation fails when start date is after due date
- [ ] Test validation passes when start date is before due date
- [ ] Test validation passes when only due date is set
- [ ] Test validation passes when only start date is set

### Integration Tests
- [ ] Test creating task with due date persists correctly
- [ ] Test creating task with due date and time persists both
- [ ] Test updating task due date
- [ ] Test task becomes overdue when date passes
- [ ] Test filtering by date ranges returns correct tasks
- [ ] Test tasks with start dates appear/disappear based on date

### UI Tests
- [ ] Test selecting "Today" quick-select sets today's date
- [ ] Test selecting "Tomorrow" quick-select sets tomorrow's date
- [ ] Test custom date picker allows any date selection
- [ ] Test time picker sets specific time
- [ ] Test overdue tasks display red indicator
- [ ] Test clearing due date removes date display
- [ ] Test date validation error shows when start > due

### Edge Cases
- [ ] Test task due at midnight (00:00)
- [ ] Test task due at 11:59 PM
- [ ] Test timezone changes affect date calculations correctly
- [ ] Test daylight saving time transitions
- [ ] Test date formatting in different locales
- [ ] Test very far future dates (years ahead)
- [ ] Test historical dates (past years)

---

## Acceptance Criteria

- ✅ Users can set due dates for tasks (all-day or specific time)
- ✅ Users can set start dates for tasks
- ✅ Overdue tasks are clearly indicated with visual cues
- ✅ Date formatting is human-readable and locale-aware
- ✅ Quick-select date options work correctly (Today, Tomorrow, etc.)
- ✅ Filtering tasks by date ranges works accurately
- ✅ Date validation prevents invalid combinations (start after due)
- ✅ All date utilities handle timezones and DST correctly
- ✅ Dates persist correctly across app restarts
- ✅ All tests pass with >85% coverage

---

## Notes

- Consider storing dates in UTC internally and converting for display
- Use `Calendar.current` for date calculations to respect user's calendar system
- Ensure date comparisons use appropriate precision (day-level vs minute-level)
- Add visual countdown or urgency indicators for approaching deadlines
- Consider adding "due soon" category (e.g., due in next 3 days)
- Test thoroughly across different timezones and locale settings
- All-day tasks should be due at end of day (23:59) for proper overdue calculation

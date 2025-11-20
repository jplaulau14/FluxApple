# Block 11: Notifications & Reminders

**Priority:** Medium
**Dependencies:** Block 00-03 (Core model, CRUD, Dates)
**Estimated Complexity:** Medium-High

## Overview
Implement comprehensive notification and reminder system using local notifications on iOS/macOS. Support reminders at due date/time, custom reminder times (minutes/hours/days before), smart reminders based on estimated duration, and snooze functionality.

---

## Client-Side To-Do Items

### Reminder Settings UI
- [ ] Create `ReminderPickerView` in task edit view
- [ ] Add reminder time options:
  - At due date/time
  - 5 minutes before
  - 10 minutes before
  - 15 minutes before
  - 30 minutes before
  - 1 hour before
  - 2 hours before
  - 1 day before
  - 1 week before
  - Custom time
- [ ] Support multiple reminders per task
- [ ] Display list of active reminders on task detail
- [ ] Add "Remove reminder" button for each reminder
- [ ] Show reminder bell icon on tasks with reminders

### Notification Permission UI
- [ ] Show notification permission request on first app launch
- [ ] Explain why notifications are useful
- [ ] Handle permission denied gracefully
- [ ] Add "Enable Notifications" in settings if denied
- [ ] Deep link to system settings to enable notifications

### Notification Appearance
- [ ] Design notification content:
  - Title: Task title
  - Body: Due date/time info, project name
  - Badge: Overdue count or today count
  - Sound: System default or custom (optional)
  - Category: For actions (Complete, Snooze)
- [ ] Add notification actions:
  - "Complete" - mark task as done
  - "Snooze" - reschedule notification
  - "View" - open app to task detail

### Snooze Options
- [ ] Add snooze action to notification
- [ ] Snooze duration picker:
  - 15 minutes
  - 30 minutes
  - 1 hour
  - 3 hours
  - Tomorrow
  - Next week
- [ ] Show snooze confirmation
- [ ] Display snoozed tasks in special view (optional)

### In-App Notification Handling
- [ ] Handle notification tap → navigate to task detail
- [ ] Handle "Complete" action → mark task done
- [ ] Handle "Snooze" action → reschedule notification
- [ ] Update badge count when task is completed
- [ ] Clear notifications when task is completed manually

---

## Logic-Side To-Do Items

### Reminder Model
- [ ] Create `Reminder` SwiftData model:
  - `id: UUID`
  - `task: Task` (many-to-one relationship)
  - `reminderDate: Date` (when to trigger)
  - `offset: TimeInterval?` (e.g., -3600 for 1 hour before)
  - `type: ReminderType` (enum: atDueDate, custom, beforeDueDate)
  - `isTriggered: Bool` (has notification been sent)
  - `createdAt: Date`
- [ ] Create `ReminderType` enum: atDueDate, custom, beforeDueDate
- [ ] Add `reminders: [Reminder]` relationship to Task model

### Notification Service
- [ ] Create `NotificationService` class
- [ ] Implement `requestNotificationPermission()` method
- [ ] Implement `checkNotificationPermission()` → Bool
- [ ] Implement `scheduleNotification(for:reminder:)` method
- [ ] Implement `cancelNotification(for:)` method
- [ ] Implement `cancelAllNotifications(for:)` method (for a task)
- [ ] Implement `updateNotifications(for:)` method (when task changes)
- [ ] Implement `handleNotificationResponse(_:)` method

### Reminder Service
- [ ] Create `ReminderService` class
- [ ] Implement `addReminder(to:date:type:offset:)` method
- [ ] Implement `removeReminder(_:)` method
- [ ] Implement `fetchReminders(for:)` method
- [ ] Implement `calculateReminderDate(for:offset:)` method
- [ ] Implement `updateReminders(for:)` when task due date changes

### Smart Reminder Logic
- [ ] Implement smart reminder based on estimated duration
  - If task has 30min duration, remind 30min before due time
- [ ] Implement time-of-day aware reminders
  - Don't remind at 2am, reschedule to 9am
- [ ] Implement reminder batching
  - If multiple tasks due at same time, group notifications

### Notification Scheduling
- [ ] Use `UNUserNotificationCenter` for local notifications
- [ ] Schedule notification with identifier (task.id + reminder.id)
- [ ] Set notification content (title, body, sound)
- [ ] Set notification trigger (date/time)
- [ ] Add notification category with actions (Complete, Snooze)
- [ ] Handle pending notification limit (iOS has 64 notification limit)

### Notification Actions
- [ ] Implement notification action handlers:
  - "Complete" → call task completion service
  - "Snooze" → reschedule notification
  - "View" → set app state to open task detail
- [ ] Update app badge count on notification actions

### Badge Management
- [ ] Implement badge count calculation
  - Option 1: Show overdue task count
  - Option 2: Show today + overdue count
  - Option 3: Show all incomplete tasks count
- [ ] Update badge when tasks change
- [ ] Update badge when notifications are handled
- [ ] Clear badge when app is opened (optional)

### Snooze Logic
- [ ] Implement `snoozeTask(_:duration:)` method
- [ ] Calculate new reminder date based on snooze duration
- [ ] Create new reminder or update existing
- [ ] Schedule new notification
- [ ] Optionally mark task as "snoozed" in UI

### Notification Cleanup
- [ ] Remove notifications when task is completed
- [ ] Remove notifications when task is deleted
- [ ] Remove notifications when reminder is deleted
- [ ] Handle expired notifications (past due date)

---

## Testing To-Do Items

### Unit Tests - Reminder Model
- [ ] Test Reminder model initialization
- [ ] Test relationship between Reminder and Task
- [ ] Test ReminderType enum cases

### Unit Tests - Notification Service
- [ ] Test requesting notification permission
- [ ] Test checking notification permission status
- [ ] Test scheduling notification creates pending notification
- [ ] Test canceling notification removes pending notification
- [ ] Test updating notifications when task changes
- [ ] Test notification identifier format (unique per task+reminder)

### Unit Tests - Reminder Service
- [ ] Test adding reminder to task
- [ ] Test removing reminder from task
- [ ] Test calculating reminder date with offset
- [ ] Test reminder date calculation for "1 day before"
- [ ] Test reminder date calculation for "1 hour before"
- [ ] Test updating reminders when due date changes
- [ ] Test removing reminders when due date is cleared

### Unit Tests - Smart Reminder
- [ ] Test smart reminder based on estimated duration
- [ ] Test time-of-day adjustment (no 2am reminders)
- [ ] Test reminder batching for multiple simultaneous tasks

### Unit Tests - Badge Management
- [ ] Test badge count calculation for overdue tasks
- [ ] Test badge count updates when task is completed
- [ ] Test badge count updates when task is created
- [ ] Test clearing badge count

### Unit Tests - Snooze Logic
- [ ] Test snooze for 15 minutes calculates correct date
- [ ] Test snooze for 1 hour calculates correct date
- [ ] Test snooze until tomorrow calculates correct date
- [ ] Test snooze reschedules notification
- [ ] Test snooze updates reminder in database

### Integration Tests
- [ ] Test creating task with reminder schedules notification
- [ ] Test completing task cancels notification
- [ ] Test deleting task cancels all notifications
- [ ] Test changing task due date updates notification
- [ ] Test adding multiple reminders schedules multiple notifications
- [ ] Test notification appears at correct time (use XCTest expectations)
- [ ] Test notification actions work correctly

### UI Tests
- [ ] Test adding reminder to task
- [ ] Test displaying reminder list on task detail
- [ ] Test removing reminder from task
- [ ] Test notification permission prompt appears
- [ ] Test notification appears with correct content
- [ ] Test tapping notification opens task detail
- [ ] Test "Complete" action marks task done
- [ ] Test "Snooze" action reschedules notification

### Edge Cases
- [ ] Test task with due date but no time (remind at 9am default)
- [ ] Test reminder scheduled for past date (should fire immediately or skip)
- [ ] Test 64+ pending notifications (iOS limit)
- [ ] Test notification while app is in foreground
- [ ] Test notification while app is in background
- [ ] Test notification when app is terminated
- [ ] Test changing timezone affects reminder dates
- [ ] Test recurring task reminder generation

---

## Acceptance Criteria

- ✅ Users can add reminders to tasks
- ✅ Users can set multiple reminders per task
- ✅ Users can set custom reminder times (before due date)
- ✅ Notifications appear at scheduled times
- ✅ Notifications show task title and relevant info
- ✅ Users can complete tasks from notifications
- ✅ Users can snooze notifications
- ✅ Tapping notification opens app to task detail
- ✅ App badge shows count of overdue/today tasks
- ✅ Notifications are canceled when task is completed/deleted
- ✅ System respects notification permissions
- ✅ All tests pass with >75% coverage

---

## Notes

- Request notification permission at appropriate time (not immediately on first launch)
- Explain value of notifications before requesting permission
- Handle permission denied gracefully - app should still function
- Use notification categories for richer interaction (actions)
- Consider critical alerts for high-priority tasks (requires special entitlement)
- Badge count strategy should be configurable in settings
- Test thoroughly on both iOS and macOS (notification APIs differ slightly)
- Consider provisional authorization (silent notifications) as fallback
- Notification scheduling must account for timezone changes
- Implement notification history/log for debugging (optional)
- Consider notification grouping by project or date (iOS notification management)
- Smart reminders should be opt-in (some users prefer explicit reminders)

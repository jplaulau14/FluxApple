# Block 05: Priority & Status Management

**Priority:** Medium
**Dependencies:** Block 00 (Core Task Model), Block 01 (Basic Task CRUD)
**Estimated Complexity:** Low

## Overview
Implement comprehensive priority level management (P1-P4) and task status workflow (inbox, active, completed, archived). Include visual indicators, filtering, and status transition logic.

---

## Client-Side To-Do Items

### Priority UI
- [ ] Create `PriorityPicker` component with P1-P4 options
- [ ] Design priority badges with distinct colors:
  - P1: Red (highest priority)
  - P2: Orange
  - P3: Blue
  - P4: Gray (lowest priority, default)
- [ ] Display priority flag/badge on task rows
- [ ] Add priority indicator to task detail view
- [ ] Create quick-select priority buttons in task form
- [ ] Add priority sorting option to views

### Status UI
- [ ] Create `StatusPicker` component with all status options
- [ ] Display status badge on task rows (if not completed)
- [ ] Show status in task detail view
- [ ] Create visual distinction for each status:
  - Inbox: Default/neutral
  - Active: Blue/highlighted
  - Completed: Green/strikethrough
  - Archived: Gray/faded
- [ ] Add "Archive" action to task context menu
- [ ] Add "Unarchive" action for archived tasks
- [ ] Show archived tasks in separate view/filter

### Priority Indicators
- [ ] Add priority flag icon next to task title
- [ ] Make priority color-coded and immediately recognizable
- [ ] Add priority sort order to task lists (P1 at top)
- [ ] Show priority count in sidebar/filters (e.g., "5 high priority tasks")

### Status Transitions UI
- [ ] Visual feedback when changing status
- [ ] Animate status transitions
- [ ] Show confirmation for archiving tasks
- [ ] Display undo option after status change

---

## Logic-Side To-Do Items

### Priority Enum (already defined, ensure completeness)
- [ ] Verify `Priority` enum: p1, p2, p3, p4
- [ ] Add `displayName` computed property ("High", "Medium", "Low", "None")
- [ ] Add `sortOrder` computed property (P1 = 1, P4 = 4)
- [ ] Add `color` computed property for UI theming

### Status Enum (already defined, ensure completeness)
- [ ] Verify `TaskStatus` enum: inbox, active, completed, archived
- [ ] Add `displayName` computed property
- [ ] Add `isTerminal` computed property (completed/archived are terminal)
- [ ] Add `canTransitionTo(_:)` validation method

### Task Service Updates
- [ ] Implement `setPriority(_:priority:)` method
- [ ] Implement `setStatus(_:status:)` method
- [ ] Implement `archiveTask(_:)` method
- [ ] Implement `unarchiveTask(_:)` method
- [ ] Implement `fetchTasksByPriority(_:)` method
- [ ] Implement `fetchTasksByStatus(_:)` method
- [ ] Implement `fetchHighPriorityTasks()` method (P1 and P2)
- [ ] Update completion logic to set status to completed

### Status Transition Logic
- [ ] Define allowed status transitions:
  - Inbox → Active, Completed, Archived
  - Active → Completed, Archived, Inbox
  - Completed → Active, Archived
  - Archived → Inbox, Active
- [ ] Implement `validateTransition(from:to:)` method
- [ ] Implement automatic transitions (e.g., completing task sets status to completed)
- [ ] Handle side effects of status changes (e.g., clear due date when archiving?)

### Default Values
- [ ] Ensure new tasks default to P4 priority
- [ ] Ensure new tasks default to inbox status
- [ ] Allow overriding defaults in task creation

### Sorting & Filtering Logic
- [ ] Implement priority-based sorting (P1 first, P4 last)
- [ ] Implement status-based filtering
- [ ] Implement combined sorting (priority + due date)
- [ ] Add priority filter predicates for SwiftData queries

---

## Testing To-Do Items

### Unit Tests - Priority
- [ ] Test `Priority` enum all cases exist
- [ ] Test `Priority.displayName` returns correct strings
- [ ] Test `Priority.sortOrder` returns correct order (1-4)
- [ ] Test `Priority` comparison (P1 > P4 in terms of importance)
- [ ] Test task creation defaults to P4
- [ ] Test setting task priority updates correctly

### Unit Tests - Status
- [ ] Test `TaskStatus` enum all cases exist
- [ ] Test `TaskStatus.displayName` returns correct strings
- [ ] Test `TaskStatus.isTerminal` for completed and archived
- [ ] Test `TaskStatus.canTransitionTo` validates allowed transitions
- [ ] Test task creation defaults to inbox
- [ ] Test setting task status updates correctly

### Unit Tests - Status Transitions
- [ ] Test inbox → active transition is allowed
- [ ] Test inbox → completed transition is allowed
- [ ] Test inbox → archived transition is allowed
- [ ] Test active → completed transition is allowed
- [ ] Test completed → active transition is allowed
- [ ] Test archived → inbox transition is allowed
- [ ] Test invalid transitions are rejected (if any)

### Unit Tests - Task Service
- [ ] Test `setPriority` changes task priority
- [ ] Test `setStatus` changes task status
- [ ] Test `archiveTask` sets status to archived
- [ ] Test `unarchiveTask` sets status to inbox (or previous status)
- [ ] Test `fetchTasksByPriority` returns only matching priority
- [ ] Test `fetchTasksByStatus` returns only matching status
- [ ] Test `fetchHighPriorityTasks` returns P1 and P2 tasks only

### Integration Tests
- [ ] Test creating task with P1 priority persists correctly
- [ ] Test changing task from P4 to P1 updates in database
- [ ] Test archiving task persists status change
- [ ] Test filtering by priority returns correct tasks
- [ ] Test filtering by status returns correct tasks
- [ ] Test sorting by priority orders tasks correctly

### UI Tests
- [ ] Test selecting P1 in priority picker updates task
- [ ] Test priority badge displays correct color
- [ ] Test status picker allows selecting all statuses
- [ ] Test archiving task from context menu
- [ ] Test archived tasks appear in archived view
- [ ] Test unarchiving task from archived view
- [ ] Test priority sort order in task list

### Edge Cases
- [ ] Test task with no priority set (should default to P4)
- [ ] Test task with no status set (should default to inbox)
- [ ] Test rapid priority changes
- [ ] Test status transitions with side effects
- [ ] Test filtering combined with other filters (priority + project)

---

## Acceptance Criteria

- ✅ Users can set priority on tasks (P1-P4)
- ✅ Priority levels have distinct visual indicators
- ✅ Users can change task status (inbox, active, completed, archived)
- ✅ Status transitions are validated and logical
- ✅ Users can filter tasks by priority
- ✅ Users can filter tasks by status
- ✅ Tasks can be sorted by priority
- ✅ Archived tasks are hidden from main views but accessible
- ✅ All status changes persist correctly
- ✅ All tests pass with >85% coverage

---

## Notes

- Priority should be prominently displayed for high-priority tasks (P1, P2)
- Consider adding keyboard shortcuts for setting priority (Cmd+1 for P1, etc.)
- Status "active" might be implicit (any non-completed, non-archived task in a project)
- Consider auto-promotion: tasks due today might auto-set to P1 or P2
- Archived tasks should be easily searchable but not clutter main views
- Consider adding bulk priority/status changes (multi-select feature)
- Status changes should be logged for productivity insights (future block)

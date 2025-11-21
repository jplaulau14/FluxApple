# Block 01: Basic Task CRUD Operations

**Priority:** Critical
**Dependencies:** Block 00 (Core Task Model)
**Estimated Complexity:** Medium

## Overview
Implement complete Create, Read, Update, Delete operations for tasks. This includes UI for task creation, basic editing, completion toggling, and deletion with undo support. This establishes the fundamental task management workflow.

---

## Client-Side To-Do Items

### Task Creation UI
- [x] Create `TaskInputView` component with text field for task title
- [x] Add "Add Task" button or submit action (Enter key support)
- [x] Implement quick-add input bar (minimal UI, always accessible)
- [x] Show visual feedback when task is created (animation, success state)
- [x] Clear input field after successful task creation
- [x] Add keyboard shortcuts for quick task creation (Cmd+N on macOS)

### Task List Display
- [x] Implement `TaskListView` to display all tasks
- [x] Create `TaskRowView` with:
  - Checkbox for completion toggle
  - Task title display
  - Context menu for actions (edit, delete)
- [x] Add visual distinction for completed vs active tasks
- [x] Implement list item selection state

### Task Editing UI
- [x] Create inline editing mode for task title (double-click or tap to edit)
- [x] Add "Edit" action in context menu
- [x] Show/hide edit controls appropriately
- [x] Implement edit confirmation (auto-save on blur/submit)
- [ ] Add edit cancellation (Escape key)

### Task Completion UI
- [x] Implement checkbox toggle animation
- [x] Add strikethrough effect for completed tasks
- [ ] Show completion timestamp on hover/long-press
- [x] Implement visual transition when task is marked complete

### Task Deletion UI
- [x] Add "Delete" action in context menu
- [x] Implement swipe-to-delete gesture (iOS pattern)
- [ ] Show confirmation dialog for destructive delete action
- [ ] Display undo notification/toast after deletion
- [ ] Implement undo button in notification

### Empty States
- [x] Design empty state for task list
- [x] Add helpful message for first-time users
- [x] Include visual hints for how to create first task

---

## Logic-Side To-Do Items

### Task Service / Repository
- [x] Implement `createTask(title:)` method
- [ ] Implement `createTask(title:dueDate:priority:)` with additional parameters
- [x] Implement `fetchAllTasks()` method
- [x] Implement `fetchActiveTasks()` method (filter by status)
- [x] Implement `fetchCompletedTasks()` method
- [x] Implement `updateTask(_:)` method
- [x] Implement `updateTaskTitle(_:newTitle:)` method
- [x] Implement `toggleTaskCompletion(_:)` method
- [x] Implement `deleteTask(_:)` method
- [ ] Implement `softDeleteTask(_:)` method (change status to archived)

### Undo/Redo System
- [ ] Create `UndoManager` wrapper or service
- [ ] Implement undo stack for task operations
- [ ] Add `UndoableAction` protocol or struct
- [ ] Implement undo for task creation
- [ ] Implement undo for task deletion
- [ ] Implement undo for task completion
- [ ] Implement undo for task edits (title changes)
- [ ] Set undo timeout (e.g., 5 seconds)

### State Management
- [x] Create `TaskListViewModel` or equivalent state container (using SwiftData @Query directly)
- [x] Implement `@Published` properties for task list (using @Query)
- [ ] Add loading state management
- [ ] Add error state management
- [ ] Implement optimistic updates for better UX
- [ ] Add error recovery mechanisms

### Data Validation
- [x] Validate task title is not empty
- [ ] Validate task title length (max characters)
- [x] Trim whitespace from task title
- [ ] Prevent duplicate tasks (optional, based on requirements)

### Business Logic
- [x] Set default values for new tasks (status = inbox, priority = p4)
- [x] Auto-set `createdAt` timestamp
- [x] Set `completedAt` timestamp when task is marked complete
- [x] Clear `completedAt` when task is unmarked as complete
- [x] Update `sortOrder` for new tasks (append to end)

---

## Testing To-Do Items

### Unit Tests - Service Layer
- [ ] Test `createTask` with valid title creates task correctly
- [ ] Test `createTask` with empty title returns error or validation failure
- [ ] Test `createTask` with very long title handles correctly
- [ ] Test `createTask` sets default status to inbox
- [ ] Test `createTask` sets default priority to p4
- [ ] Test `createTask` sets createdAt to current timestamp
- [ ] Test `fetchAllTasks` returns all tasks
- [ ] Test `fetchActiveTasks` excludes completed and archived tasks
- [ ] Test `fetchCompletedTasks` returns only completed tasks
- [ ] Test `updateTaskTitle` changes task title
- [ ] Test `toggleTaskCompletion` changes status and sets completedAt
- [ ] Test `toggleTaskCompletion` twice returns to original state
- [ ] Test `deleteTask` removes task from database

### Unit Tests - ViewModel
- [ ] Test task list populates from database on init
- [ ] Test creating task adds to task list
- [ ] Test updating task reflects in task list
- [ ] Test deleting task removes from task list
- [ ] Test error handling when database operation fails
- [ ] Test loading state during async operations

### Unit Tests - Undo System
- [ ] Test undo after task creation removes the task
- [ ] Test undo after task deletion restores the task
- [ ] Test undo after task completion returns task to active
- [ ] Test undo after task edit reverts title change
- [ ] Test undo timeout clears undo stack
- [ ] Test multiple undos work in correct order (stack behavior)

### UI Tests
- [ ] Test task creation flow: enter text → submit → task appears in list
- [ ] Test task completion flow: click checkbox → task marked complete
- [ ] Test task edit flow: double-click → edit text → submit → title updated
- [ ] Test task deletion flow: swipe/context menu → delete → task removed
- [ ] Test undo flow: delete task → click undo → task restored
- [ ] Test empty state displays when no tasks exist
- [ ] Test keyboard shortcuts work (Cmd+N for new task)

### Integration Tests
- [ ] Test creating 100 tasks and verifying all are persisted
- [ ] Test updating multiple tasks in sequence
- [ ] Test completing and uncompleting tasks
- [ ] Test deleting multiple tasks
- [ ] Test task operations persist across app restarts

### Edge Cases
- [ ] Test creating task with only whitespace (should fail or trim)
- [ ] Test creating task with emoji and special characters
- [ ] Test creating task with maximum length title
- [ ] Test rapid task creation (stress test)
- [ ] Test editing task while another operation is in progress
- [ ] Test undo when original task has been modified by another operation

---

## Acceptance Criteria

- ✅ Users can create tasks with a simple text input
- ✅ Users can view all tasks in a list
- ✅ Users can mark tasks as complete/incomplete with a checkbox
- ✅ Users can edit task titles inline or via dedicated edit mode
- ✅ Users can delete tasks with confirmation
- ✅ Undo works for all operations within timeout period
- ✅ Empty state is displayed when no tasks exist
- ✅ All CRUD operations persist correctly to SwiftData
- ✅ UI is responsive and provides immediate feedback
- ✅ All unit tests pass with >90% coverage
- ✅ All UI tests pass consistently

---

## Notes

- Keep task creation simple initially - just title input, additional fields come in later blocks
- Implement optimistic updates for better perceived performance
- Consider using SwiftUI's built-in undo manager if appropriate
- Ensure smooth animations for all state transitions
- Test on both iPhone and iPad form factors
- Consider accessibility from the start (VoiceOver labels for actions)

# Block 00: Foundation - Core Task Model

**Priority:** Critical
**Dependencies:** None
**Estimated Complexity:** High

## Overview
Establish the foundational data model for tasks using SwiftData. This includes all core entities, relationships, and basic persistence infrastructure. This is the bedrock upon which all other features will be built.

---

## Client-Side To-Do Items

### UI Components
- [ ] Create basic `TaskRowView` component to display task properties
- [ ] Design and implement task property display layout (title, dates, priority indicator)
- [ ] Create visual indicators for task status (inbox, active, completed, archived)
- [ ] Implement basic list view to display multiple tasks
- [ ] Add placeholder UI for empty task lists

### Visual Design
- [ ] Define color scheme for priority levels (P1-P4)
- [ ] Design status badges (inbox, active, completed, archived)
- [ ] Create icons for task properties (due date, priority, recurrence, etc.)
- [ ] Establish spacing and typography for task display

---

## Logic-Side To-Do Items

### SwiftData Models
- [ ] Create `Task` model with all core properties:
  - `id: UUID`
  - `title: String`
  - `taskDescription: String?`
  - `dueDate: Date?`
  - `dueTime: Date?`
  - `startDate: Date?`
  - `priority: Priority` (enum: p1, p2, p3, p4)
  - `status: TaskStatus` (enum: inbox, active, completed, archived)
  - `estimatedDuration: TimeInterval?`
  - `createdAt: Date`
  - `completedAt: Date?`
  - `sortOrder: Int`
- [ ] Create `Priority` enum with cases: p1, p2, p3, p4
- [ ] Create `TaskStatus` enum with cases: inbox, active, completed, archived
- [ ] Implement computed properties for task states (isOverdue, isToday, etc.)

### Relationships (Placeholders for future blocks)
- [ ] Add relationship property for `project` (optional, one-to-many)
- [ ] Add relationship property for `section` (optional, one-to-many)
- [ ] Add relationship property for `labels` (many-to-many)
- [ ] Add relationship property for `parentTask` (optional, for subtasks)
- [ ] Add relationship property for `subtasks` (one-to-many)

### SwiftData Configuration
- [ ] Set up `ModelContainer` in app entry point
- [ ] Configure schema with all models
- [ ] Set up `ModelContext` for data operations
- [ ] Implement proper error handling for persistence operations

### Basic Data Operations
- [ ] Create `TaskService` or repository class for data access
- [ ] Implement `fetchAllTasks()` method
- [ ] Implement `fetchTask(byId:)` method
- [ ] Implement basic task creation method (for testing)
- [ ] Implement basic task deletion method (for testing)

---

## Testing To-Do Items

### Unit Tests
- [ ] Test `Task` model initialization with all required properties
- [ ] Test `Task` model initialization with optional properties as nil
- [ ] Test `Priority` enum all cases and raw values
- [ ] Test `TaskStatus` enum all cases and transitions
- [ ] Test computed properties:
  - `isOverdue` with various date combinations
  - `isToday` with today's date vs other dates
  - `isCompleted` based on status

### Integration Tests
- [ ] Test creating a task and persisting to SwiftData
- [ ] Test fetching all tasks from empty database
- [ ] Test fetching all tasks with multiple tasks
- [ ] Test fetching task by ID (existing task)
- [ ] Test fetching task by ID (non-existent task)
- [ ] Test deleting a task and verifying removal
- [ ] Test task persistence across app restarts (using in-memory container for tests)

### Data Integrity Tests
- [ ] Test that task IDs are unique
- [ ] Test that createdAt is automatically set
- [ ] Test that sortOrder can be manually set
- [ ] Test relationship properties can be nil initially
- [ ] Test default values for optional properties

### Performance Tests
- [ ] Test creating 1000 tasks and measuring time
- [ ] Test fetching 1000 tasks and measuring time
- [ ] Test query performance with basic predicates

---

## Acceptance Criteria

- ✅ All SwiftData models are properly defined with @Model macro
- ✅ Task model includes all properties from features.md Core Task Model section
- ✅ Basic task list can display tasks from SwiftData
- ✅ Tasks persist correctly and survive app restarts
- ✅ All unit tests pass with 100% coverage for model layer
- ✅ Integration tests verify data can be created, read, and deleted
- ✅ No crashes or data corruption when working with tasks

---

## Notes

- Keep relationships as placeholders initially (they will be fully implemented in Block 02)
- Focus on core Task entity stability before building dependent features
- Use in-memory ModelContainer for unit tests to avoid side effects
- Ensure all model properties have appropriate default values or optionality
- Consider adding `@Transient` properties for computed values to avoid persistence overhead

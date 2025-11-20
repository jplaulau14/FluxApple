# Block 10: Task Detail & Editing

**Priority:** High
**Dependencies:** Block 00-05 (Core model, CRUD, Projects, Dates, Priority)
**Estimated Complexity:** Medium

## Overview
Implement comprehensive task detail view and editing interface. Includes full form for editing all task properties, support for notes/description, subtasks with hierarchical structure, and attachments (links). Provides rich editing experience beyond basic title editing.

---

## Client-Side To-Do Items

### Task Detail View
- [ ] Create `TaskDetailView` modal/sheet component
- [ ] Display all task properties in organized sections:
  - Title (large, prominent)
  - Description/Notes section
  - Due date & time
  - Start date
  - Priority badge
  - Status badge
  - Project assignment
  - Section assignment
  - Labels (chips)
  - Recurrence info
  - Subtasks list
  - Attachments list
  - Metadata (created date, completed date)
- [ ] Add "Edit" button to enter edit mode
- [ ] Support opening detail view from task row tap/click

### Task Editing Form
- [ ] Create `TaskEditView` with editable form fields:
  - Title text field (required)
  - Description text editor (multi-line, rich text optional)
  - Due date picker (with clear button)
  - Due time picker (optional, shown if date is set)
  - Start date picker (with clear button)
  - Priority selector
  - Status selector
  - Project picker
  - Section picker (filtered by selected project)
  - Label multi-selector
  - Recurrence picker
  - Estimated duration picker (optional)
- [ ] Add "Save" and "Cancel" buttons
- [ ] Show validation errors inline
- [ ] Support keyboard shortcuts (Cmd+S to save, Esc to cancel)

### Notes/Description Editor
- [ ] Create rich text editor for task description
- [ ] Support basic formatting:
  - Bold, italic, underline
  - Bullet lists, numbered lists
  - Links (auto-detect URLs)
  - Code blocks (optional)
- [ ] Support markdown syntax (optional)
- [ ] Auto-save drafts while editing
- [ ] Character count (optional)

### Subtasks Section
- [ ] Display list of subtasks within task detail
- [ ] Create `SubtaskRowView` with:
  - Checkbox for completion
  - Subtask title (editable inline)
  - Delete button
- [ ] Add "Add Subtask" button
- [ ] Support reordering subtasks (drag-and-drop)
- [ ] Show subtask completion progress (e.g., "2 of 5 completed")
- [ ] Indent subtasks visually to show hierarchy
- [ ] Support nested subtasks (subtask of subtask, optional)

### Attachments Section
- [ ] Display list of attachments (links)
- [ ] Create `AttachmentRowView` with:
  - Link preview (icon, title, URL)
  - Delete button
- [ ] Add "Add Link" button
- [ ] Show link input field
- [ ] Validate URL format
- [ ] Fetch link metadata (title, icon) if possible
- [ ] Make links tappable to open in browser

### Metadata Section
- [ ] Display creation date
- [ ] Display completion date (if completed)
- [ ] Display last modified date
- [ ] Display task ID (for support/debugging, optional)
- [ ] Show in collapsed/expandable section

---

## Logic-Side To-Do Items

### Subtask Model
- [ ] Create `Subtask` SwiftData model (or extend Task with parent relationship):
  - `id: UUID`
  - `title: String`
  - `isCompleted: Bool`
  - `sortOrder: Int`
  - `parentTask: Task` (many-to-one)
  - `createdAt: Date`
  - `completedAt: Date?`
- [ ] Add `subtasks: [Subtask]` relationship to Task model
- [ ] Support hierarchical subtasks (optional): `parentSubtask: Subtask?`

### Attachment Model
- [ ] Create `Attachment` SwiftData model:
  - `id: UUID`
  - `url: String` (URL to link)
  - `title: String?` (display name)
  - `type: AttachmentType` (enum: link, file - file for future)
  - `metadata: String?` (JSON metadata like favicon URL)
  - `createdAt: Date`
- [ ] Create `AttachmentType` enum: link, file
- [ ] Add `attachments: [Attachment]` relationship to Task model

### Task Service Updates
- [ ] Implement `updateTaskDescription(_:description:)` method
- [ ] Implement `updateTaskNotes(_:notes:)` method
- [ ] Implement `setEstimatedDuration(_:duration:)` method
- [ ] Implement `updateAllProperties(_:)` method (bulk update)

### Subtask Service
- [ ] Implement `createSubtask(parent:title:)` method
- [ ] Implement `updateSubtask(_:title:)` method
- [ ] Implement `toggleSubtaskCompletion(_:)` method
- [ ] Implement `deleteSubtask(_:)` method
- [ ] Implement `reorderSubtasks(parent:newOrder:)` method
- [ ] Implement `fetchSubtasks(for:)` method
- [ ] Implement `getSubtaskCompletionProgress(_:)` → (completed, total)

### Attachment Service
- [ ] Implement `addAttachment(to:url:title:)` method
- [ ] Implement `deleteAttachment(_:)` method
- [ ] Implement `fetchAttachments(for:)` method
- [ ] Implement `fetchLinkMetadata(url:)` method (title, icon)
- [ ] Validate URL format before saving

### Parent Task Completion Logic
- [ ] Decide behavior: completing parent completes all subtasks?
- [ ] Or: parent can only be completed when all subtasks are done?
- [ ] Implement chosen logic
- [ ] Update completion status based on subtasks

### Form Validation
- [ ] Validate title is not empty
- [ ] Validate title length (max characters)
- [ ] Validate URL format for attachments
- [ ] Validate date logic (start date before due date)
- [ ] Validate estimated duration is positive

### Auto-save
- [ ] Implement auto-save for description edits (debounced)
- [ ] Show "Saving..." indicator
- [ ] Show "Saved" confirmation
- [ ] Handle errors gracefully

---

## Testing To-Do Items

### Unit Tests - Subtask Model
- [ ] Test Subtask model initialization
- [ ] Test parent-child relationship between Task and Subtask
- [ ] Test subtask completion toggle
- [ ] Test subtask sortOrder

### Unit Tests - Attachment Model
- [ ] Test Attachment model initialization
- [ ] Test URL validation
- [ ] Test attachment relationship to Task

### Unit Tests - Task Service
- [ ] Test updating task description
- [ ] Test updating task notes
- [ ] Test setting estimated duration
- [ ] Test bulk update of all properties

### Unit Tests - Subtask Service
- [ ] Test creating subtask
- [ ] Test updating subtask title
- [ ] Test toggling subtask completion
- [ ] Test deleting subtask
- [ ] Test reordering subtasks
- [ ] Test fetching subtasks for parent
- [ ] Test completion progress calculation (2/5, 5/5, etc.)

### Unit Tests - Attachment Service
- [ ] Test adding attachment with valid URL
- [ ] Test adding attachment with invalid URL fails validation
- [ ] Test deleting attachment
- [ ] Test fetching attachments for task

### Unit Tests - Completion Logic
- [ ] Test completing parent task completes all subtasks (if applicable)
- [ ] Test parent completion requires all subtasks completed (if applicable)
- [ ] Test subtask completion updates parent progress

### Integration Tests
- [ ] Test creating task with description persists correctly
- [ ] Test adding subtasks to task persists relationships
- [ ] Test completing subtasks updates parent task
- [ ] Test adding attachments persists correctly
- [ ] Test editing task and saving updates database
- [ ] Test deleting task cascades to subtasks and attachments

### UI Tests
- [ ] Test opening task detail view from task row
- [ ] Test editing title in detail view
- [ ] Test editing description in notes section
- [ ] Test adding subtask
- [ ] Test completing subtask checkbox
- [ ] Test deleting subtask
- [ ] Test reordering subtasks
- [ ] Test adding link attachment
- [ ] Test deleting attachment
- [ ] Test saving changes persists updates
- [ ] Test canceling edit discards changes

### Edge Cases
- [ ] Test task with 100+ subtasks (performance, UI)
- [ ] Test task with very long description (>10,000 chars)
- [ ] Test task with 50+ attachments
- [ ] Test nested subtasks (if supported)
- [ ] Test completing all subtasks auto-completes parent
- [ ] Test editing task while another user/device syncs (future)

---

## Acceptance Criteria

- ✅ Users can view complete task details in dedicated view
- ✅ Users can edit all task properties in one place
- ✅ Users can add and edit multi-line descriptions/notes
- ✅ Users can create, complete, edit, delete subtasks
- ✅ Subtask completion progress is visible
- ✅ Users can add link attachments to tasks
- ✅ Users can delete attachments
- ✅ Form validation prevents invalid inputs
- ✅ Auto-save works for description edits
- ✅ All changes persist correctly to database
- ✅ All tests pass with >80% coverage

---

## Notes

- Detail view should be the "single source of truth" for task properties
- Consider using sheet (iOS) vs popover (macOS) for detail view
- Rich text editor can start simple, enhance later with markdown support
- Subtasks should be lightweight - not full tasks (no due dates, projects, etc.)
- But consider allowing promoting subtask to full task (future feature)
- Attachments: start with links, add file attachments in Block 14 (Data Management)
- Link metadata fetching should be async and non-blocking
- Consider using URLSession or OpenGraph tags for link previews
- Auto-save should debounce to avoid excessive database writes
- Keyboard shortcuts should follow platform conventions (Cmd on Mac, Ctrl on iPad)

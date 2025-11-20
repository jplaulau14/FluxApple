# Block 02: Projects & Organization

**Priority:** High
**Dependencies:** Block 00 (Core Task Model), Block 01 (Basic Task CRUD)
**Estimated Complexity:** High

## Overview
Implement the complete organizational hierarchy: Projects, Sections within projects, and Labels (tags). This includes creating the data models, relationships, UI for managing these entities, and assigning tasks to them. Includes the special "Inbox" project as the default drop target.

---

## Client-Side To-Do Items

### Project Management UI
- [ ] Create `ProjectListView` component to display all projects
- [ ] Create `ProjectRowView` with project name and task count
- [ ] Implement "Create Project" button and modal/sheet
- [ ] Create `ProjectFormView` for creating/editing projects:
  - Project name input field
  - Optional color picker for project color
  - Save/Cancel buttons
- [ ] Implement project editing (tap to edit, or context menu)
- [ ] Implement project deletion with confirmation
- [ ] Add project reordering UI (drag handles)
- [ ] Create visual indicators for project colors (colored dot/icon)
- [ ] Implement "Archive Project" action
- [ ] Show archived projects in separate section or toggle

### Section Management UI
- [ ] Create `SectionListView` within project detail view
- [ ] Create `SectionRowView` with section name and task count
- [ ] Implement "Add Section" button within project view
- [ ] Create `SectionFormView` for creating/editing sections
- [ ] Implement section editing
- [ ] Implement section deletion with confirmation
- [ ] Add section reordering UI within project
- [ ] Show tasks grouped by section in project view

### Label Management UI
- [ ] Create `LabelListView` in settings or dedicated labels view
- [ ] Create `LabelRowView` with label name and usage count
- [ ] Implement "Create Label" button and form
- [ ] Create `LabelFormView` for creating/editing labels:
  - Label name input
  - Optional label color
  - Save/Cancel buttons
- [ ] Implement label editing
- [ ] Implement label deletion with confirmation
- [ ] Create multi-select label picker for task assignment
- [ ] Display label chips/tags on task rows
- [ ] Implement label filtering (click label to filter tasks)

### Task Assignment UI
- [ ] Add project selector to task creation/edit forms
- [ ] Add section selector (filtered by selected project)
- [ ] Add label multi-selector to task forms
- [ ] Show current project/section/labels on task row
- [ ] Implement quick-change project (drag task to project in sidebar)
- [ ] Add "Move to Project" action in task context menu
- [ ] Display task count per project in sidebar
- [ ] Display task count per label in label view

### Inbox Functionality
- [ ] Create special "Inbox" project automatically on first launch
- [ ] Make Inbox the default project for new tasks (if no project specified)
- [ ] Prevent Inbox from being deleted or archived
- [ ] Style Inbox differently from other projects (icon, color)
- [ ] Allow users to process/clear Inbox by assigning tasks to projects

### Favorites & Pinning
- [ ] Add "Favorite" toggle to projects
- [ ] Display favorited projects at top of sidebar
- [ ] Add visual indicator for favorited projects (star icon)
- [ ] Persist favorite state

---

## Logic-Side To-Do Items

### SwiftData Models
- [ ] Create `Project` model:
  - `id: UUID`
  - `name: String`
  - `color: String?` (hex color code)
  - `sortOrder: Int`
  - `isArchived: Bool`
  - `isFavorite: Bool`
  - `isInbox: Bool` (special flag for Inbox project)
  - `createdAt: Date`
  - Relationship: `tasks: [Task]` (one-to-many)
  - Relationship: `sections: [Section]` (one-to-many)
- [ ] Create `Section` model:
  - `id: UUID`
  - `name: String`
  - `sortOrder: Int`
  - `createdAt: Date`
  - Relationship: `project: Project` (many-to-one)
  - Relationship: `tasks: [Task]` (one-to-many)
- [ ] Create `Label` model:
  - `id: UUID`
  - `name: String`
  - `color: String?`
  - `createdAt: Date`
  - Relationship: `tasks: [Task]` (many-to-many)
- [ ] Update `Task` model relationships:
  - `project: Project?` (many-to-one)
  - `section: Section?` (many-to-one)
  - `labels: [Label]` (many-to-many)

### Project Service
- [ ] Implement `createProject(name:color:)` method
- [ ] Implement `updateProject(_:name:color:)` method
- [ ] Implement `deleteProject(_:)` method
- [ ] Implement `archiveProject(_:)` method
- [ ] Implement `reorderProjects(_:)` method
- [ ] Implement `toggleFavoriteProject(_:)` method
- [ ] Implement `fetchAllProjects()` method
- [ ] Implement `fetchActiveProjects()` method
- [ ] Implement `fetchArchivedProjects()` method
- [ ] Implement `getOrCreateInbox()` method
- [ ] Implement project task count calculation

### Section Service
- [ ] Implement `createSection(name:project:)` method
- [ ] Implement `updateSection(_:name:)` method
- [ ] Implement `deleteSection(_:)` method
- [ ] Implement `reorderSections(in:newOrder:)` method
- [ ] Implement `fetchSections(for:)` method
- [ ] Implement section task count calculation

### Label Service
- [ ] Implement `createLabel(name:color:)` method
- [ ] Implement `updateLabel(_:name:color:)` method
- [ ] Implement `deleteLabel(_:)` method
- [ ] Implement `fetchAllLabels()` method
- [ ] Implement `assignLabels(to:labels:)` method
- [ ] Implement `removeLabel(from:label:)` method
- [ ] Implement label usage count calculation

### Task Assignment Logic
- [ ] Update task creation to assign to Inbox by default
- [ ] Implement `assignTaskToProject(_:project:)` method
- [ ] Implement `assignTaskToSection(_:section:)` method
- [ ] Implement `moveTask(_:to:section:)` method
- [ ] Auto-clear section when moving task to different project
- [ ] Validate section belongs to selected project

### Data Integrity
- [ ] Ensure Inbox project is created on first app launch
- [ ] Handle cascading deletes (deleting project → what happens to tasks?)
- [ ] Handle cascading deletes (deleting section → move tasks to project root)
- [ ] Handle cascading deletes (deleting label → remove from all tasks)
- [ ] Prevent deletion of Inbox project
- [ ] Ensure project/section sortOrder is unique and sequential

---

## Testing To-Do Items

### Unit Tests - Models
- [ ] Test `Project` model initialization with required fields
- [ ] Test `Project` model with all optional fields
- [ ] Test `Section` model initialization
- [ ] Test `Label` model initialization
- [ ] Test `Task` relationships to project/section/labels
- [ ] Test many-to-many relationship between tasks and labels

### Unit Tests - Project Service
- [ ] Test creating project with valid name
- [ ] Test creating project with empty name (should fail validation)
- [ ] Test updating project name
- [ ] Test updating project color
- [ ] Test deleting project (with no tasks)
- [ ] Test deleting project (with tasks) - verify cascade behavior
- [ ] Test archiving project
- [ ] Test reordering projects maintains correct sortOrder
- [ ] Test toggling favorite status
- [ ] Test fetching all projects
- [ ] Test fetching only active projects excludes archived
- [ ] Test Inbox creation and special properties

### Unit Tests - Section Service
- [ ] Test creating section within project
- [ ] Test creating multiple sections in same project
- [ ] Test updating section name
- [ ] Test deleting section with no tasks
- [ ] Test deleting section with tasks (tasks move to project root)
- [ ] Test reordering sections within project
- [ ] Test fetching sections for specific project

### Unit Tests - Label Service
- [ ] Test creating label
- [ ] Test creating label with duplicate name (allow or prevent?)
- [ ] Test updating label name
- [ ] Test deleting label (removes from all tasks)
- [ ] Test assigning multiple labels to task
- [ ] Test removing specific label from task
- [ ] Test label usage count calculation

### Unit Tests - Task Assignment
- [ ] Test new task defaults to Inbox project
- [ ] Test assigning task to specific project
- [ ] Test assigning task to section within project
- [ ] Test assigning multiple labels to task
- [ ] Test moving task between projects clears section
- [ ] Test cannot assign section from different project

### Integration Tests
- [ ] Test creating project → creating tasks in project → deleting project
- [ ] Test creating sections → moving tasks between sections
- [ ] Test creating labels → assigning to multiple tasks → deleting label
- [ ] Test full organizational hierarchy: Project → Section → Tasks with Labels
- [ ] Test reordering projects persists across app restarts
- [ ] Test Inbox project persists and cannot be deleted

### UI Tests
- [ ] Test project creation flow
- [ ] Test section creation flow within project
- [ ] Test label creation flow
- [ ] Test assigning project to task during creation
- [ ] Test dragging task to different project in sidebar
- [ ] Test filtering tasks by label
- [ ] Test project deletion confirmation
- [ ] Test favoriting project moves it to top

### Edge Cases
- [ ] Test creating 100+ projects (performance, UI scrolling)
- [ ] Test project with 50+ sections
- [ ] Test task with 20+ labels
- [ ] Test deleting project with 1000+ tasks
- [ ] Test circular references (should not be possible, but verify)
- [ ] Test special characters in project/section/label names

---

## Acceptance Criteria

- ✅ Users can create, edit, delete, and archive projects
- ✅ Users can create, edit, delete sections within projects
- ✅ Users can create, edit, delete labels
- ✅ Users can assign tasks to projects and sections
- ✅ Users can assign multiple labels to tasks
- ✅ Inbox project is automatically created and functions as default
- ✅ Inbox project cannot be deleted
- ✅ Task counts display correctly for projects and labels
- ✅ Projects can be reordered and favorited
- ✅ Sections can be reordered within projects
- ✅ All relationships persist correctly in SwiftData
- ✅ Cascading deletes work as expected
- ✅ UI clearly displays organizational hierarchy
- ✅ All tests pass with >85% coverage

---

## Notes

- Consider using `@Relationship(deleteRule: .cascade)` for appropriate relationships
- Inbox should be a regular project with `isInbox: true` flag rather than special-cased
- Allow drag-and-drop for task assignment between projects (nice UX enhancement)
- Consider limiting number of labels per task to prevent UI clutter (e.g., max 10)
- Project colors should use predefined palette for consistency
- Empty sections should show helpful empty state message

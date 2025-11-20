# Block 07: Views & Filters - Advanced

**Priority:** Medium
**Dependencies:** Block 00-06 (All previous blocks)
**Estimated Complexity:** High

## Overview
Implement advanced filtering, custom filter creation, global search, sorting options, and grouping configurations. This enables power users to create highly specific views and find tasks quickly.

---

## Client-Side To-Do Items

### Search Interface
- [ ] Create global search bar (prominent in navigation)
- [ ] Implement instant search (search-as-you-type)
- [ ] Display search results with highlighting
- [ ] Show search results grouped by:
  - Tasks
  - Projects
  - Labels (optional)
- [ ] Add search history/recent searches
- [ ] Add search scope selector (All, Current Project, etc.)
- [ ] Show "No results" state with helpful suggestions
- [ ] Add keyboard shortcut for search (Cmd+F)

### Advanced Filter UI
- [ ] Create `FilterBuilderView` for custom filters
- [ ] Add filter criteria options:
  - Project(s) - multi-select
  - Label(s) - multi-select
  - Priority - multi-select
  - Status - multi-select
  - Due date range - from/to date pickers
  - Has due date / No due date - toggle
  - Created date range
  - Text contains - text input
- [ ] Add AND/OR logic between criteria (optional advanced feature)
- [ ] Display active filters as chips/badges
- [ ] Add "Clear all filters" button
- [ ] Show count of matching tasks

### Custom Saved Filters
- [ ] Create UI to save current filter as named view
- [ ] Add "Save Filter" button in filter builder
- [ ] Prompt for filter name
- [ ] Display saved filters in sidebar navigation
- [ ] Allow editing saved filters
- [ ] Allow deleting saved filters
- [ ] Add "Pin to sidebar" option for saved filters
- [ ] Show task count for saved filters

### Sorting Options
- [ ] Create `SortMenu` dropdown/picker
- [ ] Add sorting options:
  - Manual order (drag-and-drop)
  - Due date (ascending/descending)
  - Priority (P1 first or P4 first)
  - Created date (newest/oldest first)
  - Alphabetical (A-Z, Z-A)
  - Project
  - Label
- [ ] Persist sort preference per view
- [ ] Show current sort order in UI
- [ ] Add quick-reverse sort button

### Grouping Options
- [ ] Create `GroupByMenu` dropdown/picker
- [ ] Add grouping options:
  - None (flat list)
  - Project
  - Section
  - Label
  - Priority
  - Due date bucket (Today, Tomorrow, etc.)
  - Status
- [ ] Display group headers with task counts
- [ ] Add collapse/expand all groups button
- [ ] Remember expanded/collapsed state per group
- [ ] Persist grouping preference per view

### Filter Chips/Tags
- [ ] Display active filters as removable chips
- [ ] Clicking chip removes that filter
- [ ] Show filter summary (e.g., "3 filters active")
- [ ] Visual distinction between different filter types

---

## Logic-Side To-Do Items

### Search Engine
- [ ] Create `SearchService` class
- [ ] Implement full-text search on task titles
- [ ] Implement search on task descriptions
- [ ] Implement search with substring matching
- [ ] Implement search with fuzzy matching (optional)
- [ ] Add search ranking/relevance scoring
- [ ] Implement search result highlighting
- [ ] Optimize search for large datasets (indexing if needed)

### Filter Model
- [ ] Create `FilterCriteria` model/struct:
  - `projects: [Project]?`
  - `labels: [Label]?`
  - `priorities: [Priority]?`
  - `statuses: [TaskStatus]?`
  - `dueDateRange: DateRange?`
  - `hasDueDate: Bool?`
  - `createdDateRange: DateRange?`
  - `searchText: String?`
  - `logicOperator: FilterLogic` (and/or)
- [ ] Create `DateRange` struct with start and end dates
- [ ] Create `FilterLogic` enum: and, or

### Saved Filter Model
- [ ] Create `SavedFilter` SwiftData model:
  - `id: UUID`
  - `name: String`
  - `criteria: FilterCriteria` (stored as JSON or relationship)
  - `sortOrder: Int` (for sidebar ordering)
  - `isPinned: Bool`
  - `createdAt: Date`
- [ ] Add relationship to store filter criteria

### Filter Service
- [ ] Create `FilterService` class
- [ ] Implement `applyFilter(_:to:)` method
  - Takes FilterCriteria and array of tasks
  - Returns filtered tasks
- [ ] Implement `buildPredicate(from:)` method
  - Converts FilterCriteria to SwiftData predicate
- [ ] Implement `fetchTasks(with:)` method
  - Executes query with filter criteria
- [ ] Optimize filtering for performance

### Saved Filter Service
- [ ] Implement `createSavedFilter(name:criteria:)` method
- [ ] Implement `updateSavedFilter(_:)` method
- [ ] Implement `deleteSavedFilter(_:)` method
- [ ] Implement `fetchAllSavedFilters()` method
- [ ] Implement `fetchPinnedFilters()` method
- [ ] Implement `executeSavedFilter(_:)` method

### Sort Service
- [ ] Create `SortService` class
- [ ] Implement sorting strategies:
  - `sortByDueDate(_:ascending:)`
  - `sortByPriority(_:ascending:)`
  - `sortByCreatedDate(_:ascending:)`
  - `sortByTitle(_:ascending:)`
  - `sortByProject(_:)`
- [ ] Implement compound sorting (e.g., priority then due date)
- [ ] Implement custom sort order (manual drag-and-drop)

### Group Service
- [ ] Create `GroupService` class
- [ ] Implement grouping strategies:
  - `groupByProject(_:)`
  - `groupByLabel(_:)`
  - `groupByPriority(_:)`
  - `groupByDateBucket(_:)`
  - `groupByStatus(_:)`
- [ ] Return grouped data as dictionary or custom struct
- [ ] Include empty groups option (configurable)

---

## Testing To-Do Items

### Unit Tests - Search
- [ ] Test search finds task by exact title match
- [ ] Test search finds task by partial title match
- [ ] Test search finds task by description match
- [ ] Test search is case-insensitive
- [ ] Test search handles special characters
- [ ] Test search with no results returns empty array
- [ ] Test search ranking orders results by relevance

### Unit Tests - Filtering
- [ ] Test filter by single project
- [ ] Test filter by multiple projects
- [ ] Test filter by single label
- [ ] Test filter by multiple labels
- [ ] Test filter by priority range
- [ ] Test filter by status
- [ ] Test filter by due date range
- [ ] Test filter by "has due date"
- [ ] Test filter by "no due date"
- [ ] Test combining multiple filters (AND logic)
- [ ] Test combining multiple filters (OR logic)
- [ ] Test filter with all criteria empty returns all tasks

### Unit Tests - Saved Filters
- [ ] Test creating saved filter
- [ ] Test saved filter persists criteria correctly
- [ ] Test executing saved filter returns correct tasks
- [ ] Test updating saved filter
- [ ] Test deleting saved filter
- [ ] Test fetching all saved filters
- [ ] Test pinning/unpinning saved filter

### Unit Tests - Sorting
- [ ] Test sort by due date ascending
- [ ] Test sort by due date descending
- [ ] Test sort by priority (P1 first)
- [ ] Test sort by created date
- [ ] Test sort alphabetically
- [ ] Test sort handles nil values correctly (e.g., no due date)
- [ ] Test compound sort (priority then due date)

### Unit Tests - Grouping
- [ ] Test group by project creates correct groups
- [ ] Test group by priority creates P1-P4 groups
- [ ] Test group by date bucket creates correct buckets
- [ ] Test grouping handles tasks with no group value
- [ ] Test empty groups are/aren't included based on setting

### Integration Tests
- [ ] Test search across 1000+ tasks performs well
- [ ] Test complex filter (5+ criteria) returns correct results
- [ ] Test saved filter persists across app restarts
- [ ] Test applying filter updates task count immediately
- [ ] Test sorting persists per view
- [ ] Test grouping persists per view

### UI Tests
- [ ] Test typing in search bar shows results
- [ ] Test clicking search result navigates to task
- [ ] Test building filter with multiple criteria
- [ ] Test saving custom filter
- [ ] Test accessing saved filter from sidebar
- [ ] Test changing sort order updates task list
- [ ] Test changing grouping updates task list
- [ ] Test removing filter chip updates results
- [ ] Test clearing all filters resets view

### Performance Tests
- [ ] Test search on 10,000 tasks completes in < 0.5s
- [ ] Test filtering on 10,000 tasks completes in < 1s
- [ ] Test sorting on 1,000 tasks is imperceptible
- [ ] Test grouping on 1,000 tasks is smooth

---

## Acceptance Criteria

- ✅ Users can search for tasks by title and description
- ✅ Search is fast and responsive
- ✅ Users can build complex filters with multiple criteria
- ✅ Users can save custom filters for reuse
- ✅ Saved filters appear in sidebar navigation
- ✅ Users can sort tasks by various criteria
- ✅ Users can group tasks by various criteria
- ✅ Sort and group preferences persist per view
- ✅ Active filters are clearly displayed and removable
- ✅ Filter, sort, and group operations are performant
- ✅ All tests pass with >75% coverage

---

## Notes

- Search should be available from all views (global)
- Consider implementing search suggestions based on frequent searches
- Filter builder should have "Preview" mode to see results before saving
- Saved filters with no matching tasks should show empty state
- Consider adding "Smart Filters" (e.g., "High priority due this week")
- Compound sorting should be configurable (primary, secondary sort)
- Grouping should support nested groups (e.g., project > section > priority)
- Consider adding filter templates for common use cases
- Search might benefit from Core Spotlight integration (future)

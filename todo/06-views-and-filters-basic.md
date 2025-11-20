# Block 06: Views & Filters - Basic Views

**Priority:** High
**Dependencies:** Block 00-05 (All previous blocks)
**Estimated Complexity:** Medium

## Overview
Implement the core default views: Inbox, Today, Upcoming, Projects, and Labels. These views provide the primary navigation and organization structure for the app. Each view filters and displays tasks based on specific criteria.

---

## Client-Side To-Do Items

### Navigation Structure
- [ ] Create main navigation sidebar (macOS/iPad) or tab bar (iPhone)
- [ ] Add navigation items for:
  - Inbox
  - Today
  - Upcoming
  - Projects (with expandable project list)
  - Labels
- [ ] Implement navigation highlighting for current view
- [ ] Add badge counts to navigation items (e.g., "Today (5)")
- [ ] Support keyboard navigation between views

### Inbox View
- [ ] Create `InboxView` component
- [ ] Display all uncategorized tasks (tasks in Inbox project)
- [ ] Show empty state when Inbox is clear
- [ ] Add quick actions: assign to project, set due date, complete
- [ ] Display task count in header
- [ ] Add "Clear Inbox" flow guidance

### Today View
- [ ] Create `TodayView` component
- [ ] Display all tasks due today
- [ ] Include overdue tasks (configurable in settings)
- [ ] Group by:
  - Overdue section (if any)
  - Today section
- [ ] Show time slots if tasks have specific times
- [ ] Display completion progress (X of Y tasks completed)
- [ ] Add motivational empty state when all tasks are done
- [ ] Show tomorrow's preview at bottom (optional)

### Upcoming View
- [ ] Create `UpcomingView` component with timeline layout
- [ ] Group tasks by date buckets:
  - Today
  - Tomorrow
  - This Week
  - Next Week
  - Later
- [ ] Display calendar-style date headers
- [ ] Show day of week for each date
- [ ] Collapse/expand date groups
- [ ] Add mini calendar for date navigation (optional)
- [ ] Display count of tasks per day

### Projects View
- [ ] Create `ProjectsListView` showing all projects
- [ ] Display task count per project
- [ ] Tapping project opens `ProjectDetailView`
- [ ] Create `ProjectDetailView`:
  - Show all tasks in project
  - Group by sections (if any)
  - Display project color/theme
  - Show project metadata (created date, task counts)
- [ ] Add empty state for projects with no tasks
- [ ] Show completed tasks toggle

### Labels View
- [ ] Create `LabelsListView` showing all labels
- [ ] Display task count per label
- [ ] Tapping label opens `LabelDetailView`
- [ ] Create `LabelDetailView`:
  - Show all tasks with that label
  - Display label color/badge
  - Show label usage statistics
- [ ] Add empty state for labels with no tasks

### View Switching
- [ ] Implement smooth transitions between views
- [ ] Preserve scroll position when switching back
- [ ] Remember last visited view on app launch (optional)

---

## Logic-Side To-Do Items

### View Data Queries
- [ ] Create `ViewService` or equivalent for view logic
- [ ] Implement `fetchInboxTasks()` query
  - Filter: project.isInbox == true, status != completed, status != archived
- [ ] Implement `fetchTodayTasks()` query
  - Filter: dueDate == today OR (isOverdue AND includeOverdue setting)
  - Sort: overdue first, then by time
- [ ] Implement `fetchUpcomingTasks(days:)` query
  - Filter: dueDate within next N days
  - Sort: by due date ascending
- [ ] Implement `fetchProjectTasks(project:)` query
  - Filter: task.project == project, status != archived
  - Sort: by section, then by sortOrder
- [ ] Implement `fetchLabelTasks(label:)` query
  - Filter: task.labels contains label, status != archived
  - Sort: by due date

### Task Grouping Logic
- [ ] Create `TaskGrouper` utility class
- [ ] Implement `groupByDate(_:)` method
  - Returns dictionary: [Date: [Task]]
  - Groups: Overdue, Today, Tomorrow, This Week, Next Week, Later
- [ ] Implement `groupBySection(_:)` method for project views
  - Returns dictionary: [Section?: [Task]]
- [ ] Implement `groupByPriority(_:)` method
  - Returns dictionary: [Priority: [Task]]

### Date Bucketing
- [ ] Create date bucket enum: Overdue, Today, Tomorrow, ThisWeek, NextWeek, Later
- [ ] Implement `dateBucket(for:)` method
- [ ] Implement `dateRangeForBucket(_:)` method

### Task Counts
- [ ] Implement `getInboxCount()` method
- [ ] Implement `getTodayCount()` method
- [ ] Implement `getOverdueCount()` method
- [ ] Implement `getProjectTaskCount(_:)` method
- [ ] Implement `getLabelTaskCount(_:)` method
- [ ] Cache counts for performance (invalidate on changes)

### View State Management
- [ ] Create `ViewViewModel` for each view type
- [ ] Implement reactive updates when tasks change
- [ ] Handle loading states
- [ ] Handle error states
- [ ] Implement pull-to-refresh

---

## Testing To-Do Items

### Unit Tests - Query Logic
- [ ] Test `fetchInboxTasks` returns only inbox tasks
- [ ] Test `fetchInboxTasks` excludes completed and archived
- [ ] Test `fetchTodayTasks` returns tasks due today
- [ ] Test `fetchTodayTasks` includes overdue when setting enabled
- [ ] Test `fetchTodayTasks` excludes overdue when setting disabled
- [ ] Test `fetchUpcomingTasks` returns tasks in date range
- [ ] Test `fetchProjectTasks` returns only tasks in specified project
- [ ] Test `fetchLabelTasks` returns tasks with specified label

### Unit Tests - Grouping Logic
- [ ] Test `groupByDate` correctly categorizes overdue tasks
- [ ] Test `groupByDate` correctly categorizes today tasks
- [ ] Test `groupByDate` correctly categorizes upcoming tasks
- [ ] Test `groupBySection` groups tasks by their sections
- [ ] Test `groupBySection` handles tasks with no section
- [ ] Test `groupByPriority` groups by P1-P4

### Unit Tests - Date Bucketing
- [ ] Test `dateBucket` returns Overdue for past dates
- [ ] Test `dateBucket` returns Today for today's date
- [ ] Test `dateBucket` returns Tomorrow for tomorrow's date
- [ ] Test `dateBucket` returns ThisWeek for dates in current week
- [ ] Test `dateBucket` returns NextWeek for dates in next week
- [ ] Test `dateBucket` returns Later for dates beyond next week

### Unit Tests - Task Counts
- [ ] Test `getInboxCount` returns correct count
- [ ] Test `getTodayCount` includes/excludes overdue based on setting
- [ ] Test `getOverdueCount` returns correct count
- [ ] Test `getProjectTaskCount` returns correct count
- [ ] Test `getLabelTaskCount` returns correct count

### Integration Tests
- [ ] Test creating task in Inbox appears in Inbox view
- [ ] Test task due today appears in Today view
- [ ] Test task due tomorrow appears in Upcoming view
- [ ] Test assigning task to project removes from Inbox
- [ ] Test completing task removes from all views except completed view
- [ ] Test overdue task appears in Today view (if setting enabled)

### UI Tests
- [ ] Test navigating to Inbox view displays inbox tasks
- [ ] Test navigating to Today view displays today's tasks
- [ ] Test navigating to Upcoming view displays upcoming tasks
- [ ] Test navigating to Projects view lists all projects
- [ ] Test tapping project opens project detail view
- [ ] Test navigating to Labels view lists all labels
- [ ] Test tapping label opens label detail view
- [ ] Test badge counts update when tasks change
- [ ] Test empty states display when no tasks

### Performance Tests
- [ ] Test Inbox view with 1000+ tasks loads within 2 seconds
- [ ] Test Today view with 100+ tasks renders smoothly
- [ ] Test Upcoming view scrolling performance with many date groups
- [ ] Test view switching is instantaneous (< 0.3s)

---

## Acceptance Criteria

- ✅ All five core views are implemented and accessible
- ✅ Inbox view displays uncategorized tasks
- ✅ Today view displays today's tasks and optionally overdue
- ✅ Upcoming view displays tasks grouped by date buckets
- ✅ Projects view lists all projects with task counts
- ✅ Labels view lists all labels with task counts
- ✅ Tapping project/label opens detailed view of tasks
- ✅ Badge counts are accurate and update in real-time
- ✅ Empty states are helpful and actionable
- ✅ View switching is smooth and responsive
- ✅ All queries are efficient and performant
- ✅ All tests pass with >80% coverage

---

## Notes

- Today view is the most frequently used - optimize for speed
- Consider making "include overdue in Today" a user preference
- Upcoming view might need calendar integration (future enhancement)
- Project detail view should support inline task creation
- Label detail view might benefit from showing label usage trends
- Consider adding "Focus Mode" - show only high-priority or due-today tasks
- Sidebar should be collapsible on macOS/iPad for more screen space
- Consider adding custom view colors/themes per project

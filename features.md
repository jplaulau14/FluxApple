# Features

High-level: a ToDoist-style task manager with natural language input, auto-tagging, and smart scheduling, built on Swift + SwiftUI + SwiftData.

---

## 1. Core Task Model

- Task entity with:
  - Title
  - Optional description / notes
  - Due date & time (optional)
  - Start date (optional)
  - Priority (e.g., P1–P4)
  - Status (inbox, active, completed, archived)
  - Project
  - Section (within project)
  - Labels / tags (many-to-many)
  - Recurrence rule (optional)
  - Estimated duration / effort (optional)
  - Creation date
  - Completion date
  - Order / sort index
- Subtasks:
  - Hierarchical parent–child relationship
  - Independent completion state per subtask
- Attachments (optional / stretch):
  - Link attachments (URLs)
  - File attachment metadata (local / cloud)

---

## 2. Natural Language Input

- Single “quick add” text field with NLP parsing, e.g.:
  - `Pay rent tomorrow 5pm #Finance @Bills p1`
- Parsed elements:
  - Task title
  - Due date & time (e.g., “today 5pm”, “next Monday”, “in 2 weeks”)
  - Recurrence patterns (e.g., “every Friday”, “on weekdays”, “every 2nd Tuesday”)
  - Priority (e.g., `p1`, `high`, `!!!`)
  - Project (e.g., `#Work`, `#Personal`)
  - Labels (e.g., `@email`, `@errand`)
- Inline feedback:
  - Highlighted parsed chips (date, project, labels, priority) as user types
- Fallback behavior:
  - If NLP fails, entire text becomes title; no crash or blocking

---

## 3. Auto-Tagging, Categorization & Smart Defaults

- Auto-project suggestion:
  - Use keywords / past tasks to suggest a project if none is explicitly set
- Auto-label suggestion:
  - Suggest labels like `@email`, `@call`, `@home`, `@work` based on content
- Auto-priority:
  - Simple heuristic (e.g., presence of “urgent”, “ASAP”, “today” → higher priority)
- Auto-due-date suggestion:
  - If no due date is provided:
    - Suggest “today”, “tomorrow”, or “next week” based on wording and backlog
- Smart defaults:
  - Remember last-used project, labels, and due date time-of-day and apply as defaults
- Manual override:
  - User can always edit auto-assigned project, labels, due date, and priority before saving

---

## 4. Scheduling, Deadlines & Recurrence

- Due dates:
  - All-day due dates
  - Due date + specific time
- Recurring tasks:
  - Simple repeats: daily, weekly, monthly, yearly
  - Relative repeats: every N days/weeks/months
  - Weekday-based: weekdays, weekends, specific weekdays
- Start dates:
  - Optional “starts on” to hide tasks from main views until that date
- Overdue handling:
  - Overdue indicator & badge
  - Automatic rollover of overdue tasks into “Today” view (configurable)
- Smart suggestions (stretch):
  - “Auto-reschedule” for overdue tasks (suggest new dates)
  - Load-aware scheduling (avoid overbooking days)

---

## 5. Task Organization

- Projects:
  - Create, rename, archive, delete projects
  - Color per project (optional)
  - Order projects manually
- Sections (within projects):
  - Optional grouping of tasks inside a project
  - Draggable order of sections
- Labels / tags:
  - Create, rename, delete labels
  - Many-to-many relationship between tasks and labels
- Inboxes:
  - Global “Inbox” project as default drop target for new tasks
- Favorites:
  - Mark certain projects or filters as favorites and pin them

---

## 6. Views & Filters

- Default views:
  - **Inbox**: uncategorized tasks
  - **Today**: tasks due today + overdue (configurable)
  - **Upcoming**: timeline of upcoming days/weeks
  - **Projects**: per-project task list
  - **Labels**: per-label task list
- Custom filters (stretch or later phase):
  - Combine rules: by project, label, priority, due date range, text search
  - Save filters as named views
- Sorting & grouping:
  - Sort by: manual order, due date, priority, creation date
  - Group by: project, section, label, due date bucket (Today / Tomorrow / Later)
- Search:
  - Global search on title + description
  - Search filters (e.g., only in project, only with label)

---

## 7. Notifications & Reminders

- Reminders:
  - At due date/time
  - Custom reminder times (e.g., 10 min, 1h, 1 day before)
- System integration:
  - Local notifications on iOS / macOS
- Smart reminders (optional):
  - Reminder based on estimated duration and due time (e.g., “start 30 min before”)
- Snooze:
  - Quick snooze actions from notification (e.g., +1h, tomorrow, next week)

---

## 8. Task Lifecycle & Editing

- Create task:
  - From quick-add input
  - From within project / view (with project pre-selected)
- Edit task:
  - Inline editing of title
  - Detail sheet for all properties (project, labels, dates, priority, notes)
- Complete task:
  - Checkbox/toggle on list item
  - Clear visual treatment for completed tasks
- Undo:
  - Undo last action (create/delete/complete/move)
- Deletion & archiving:
  - Soft delete or archive tasks
  - Bulk complete / delete from multi-select mode (optional)

---

## 9. UX & Interaction

- Layout:
  - Master/detail layout where applicable (e.g., sidebar on iPad/macOS)
  - Adaptive layouts for iPhone, iPad, and macOS
- Gestures:
  - Swipe actions on tasks (complete, schedule, delete)
  - Drag-and-drop to reorder tasks within a list
- Theming:
  - Light / dark mode (system-driven + manual override)
- Empty states:
  - Friendly empty states for Inbox, Today, Projects, etc.
- Onboarding:
  - Minimal first-run experience with example tasks and hints for NLP syntax

---

## 10. Data, Sync & Persistence

- Local persistence:
  - SwiftData-backed storage for all entities (tasks, projects, labels, filters)
- Offline-first:
  - Full functionality offline
  - Queued changes for sync (if remote sync is later added)
- Backup / Export (stretch):
  - Export tasks to JSON / CSV
  - Import from JSON (for testing / migration)

---

## 11. Settings & Preferences

- General:
  - Default view on app launch (Today, Inbox, last opened, etc.)
  - First day of week
  - Default reminder behavior
- NLP & automation:
  - Toggle auto-project suggestion
  - Toggle auto-label suggestion
  - Toggle auto-due-date suggestion / smart rescheduling
- Appearance:
  - Theme selection (system / light / dark)
  - Density (compact / comfortable, optional)

---

## 12. Productivity & Insights (Stretch Features)

- Basic stats:
  - Tasks completed per day/week
  - Streaks (consecutive days with completed tasks)
- Per-project metrics:
  - Number of active tasks
  - Completion trends over time
- Gamification (optional):
  - Points for completing tasks, maintaining streaks, etc.

---

## 13. Accessibility & Internationalization

- Accessibility:
  - Dynamic Type support
  - VoiceOver labels and actions for all controls
  - Sufficient contrast for all themes
- Localization:
  - Localizable strings
  - Date/time formats respecting user locale
  - NLP date parsing tuned for primary language (with fallback)

---

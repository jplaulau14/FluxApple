# Block 12: UX Enhancements

**Priority:** Medium
**Dependencies:** Block 00-06 (Core functionality and views)
**Estimated Complexity:** Medium

## Overview
Implement advanced UX features including swipe gestures, drag-and-drop reordering, smooth animations and transitions, theming (light/dark mode with manual override), empty states, and onboarding experience. These enhancements make the app feel polished and delightful to use.

---

## Client-Side To-Do Items

### Swipe Gestures
- [ ] Implement swipe-to-complete (right swipe)
  - Show completion checkmark animation
  - Haptic feedback on completion
- [ ] Implement swipe-to-delete (left swipe, full swipe)
  - Show red delete background
  - Confirmation before delete (optional setting)
- [ ] Implement swipe-to-schedule (left swipe, partial)
  - Show calendar icon
  - Open quick date picker
- [ ] Support swipe actions on task rows
- [ ] Make swipe thresholds configurable
- [ ] Add swipe action hints for first-time users

### Drag-and-Drop
- [ ] Implement drag-and-drop to reorder tasks within list
  - Show drag handle on task rows
  - Animate reordering
  - Update sortOrder in database
- [ ] Implement drag-and-drop to move tasks between projects
  - Drag task from list to project in sidebar
  - Show drop target highlight
  - Confirm project change
- [ ] Implement drag-and-drop to move tasks between sections
  - Drag task between section groups
  - Update section assignment
- [ ] Implement drag-and-drop to assign labels
  - Drag task to label in sidebar
  - Add label to task
- [ ] Support multi-select drag (drag multiple tasks at once)
- [ ] Add drag preview with task title

### Animations & Transitions
- [ ] Add smooth transitions between views
  - Fade in/out
  - Slide in/out
  - Scale animations
- [ ] Animate task list changes:
  - Task added: slide in from top
  - Task completed: fade out with checkmark
  - Task deleted: slide out with fade
- [ ] Animate UI state changes:
  - Checkbox toggle: smooth checkmark animation
  - Priority change: color transition
  - Expand/collapse: smooth height animation
- [ ] Add loading animations for async operations
  - Skeleton screens for task lists
  - Spinner for network operations
  - Progress indicators
- [ ] Add haptic feedback for important actions
  - Task completed
  - Task deleted
  - Swipe threshold reached

### Theming
- [ ] Implement theme system with enum: system, light, dark
- [ ] Create light theme color palette
- [ ] Create dark theme color palette
- [ ] Implement theme switching in settings
- [ ] Apply theme to all UI components
- [ ] Support semantic colors (primary, secondary, background, etc.)
- [ ] Add smooth transition when changing themes
- [ ] Persist theme preference
- [ ] Respect system appearance by default
- [ ] Support custom accent colors (optional)

### Empty States
- [ ] Design empty state for Inbox view
  - Friendly illustration or icon
  - Message: "Your inbox is clear! 🎉"
  - CTA: "Create your first task"
- [ ] Design empty state for Today view
  - Message: "No tasks due today"
  - Show upcoming tasks preview (optional)
- [ ] Design empty state for Projects list
  - Message: "Create your first project"
  - Explain benefits of projects
- [ ] Design empty state for search results
  - Message: "No tasks found"
  - Suggest checking filters or creating new task
- [ ] Design empty state for custom filters
  - Message: "No tasks match this filter"
  - Option to edit or clear filter
- [ ] Make empty states contextual and helpful

### Onboarding
- [ ] Create first-launch onboarding flow
  - Welcome screen with app value proposition
  - Feature highlights (NLP, projects, reminders)
  - Notification permission request
  - Sample task creation walkthrough (optional)
- [ ] Show onboarding once, then never again
- [ ] Add "Skip" button for experienced users
- [ ] Make onboarding accessible from settings ("Show Intro Again")
- [ ] Create example tasks on first launch (optional)
  - "Welcome to [App Name]! Try completing this task"
  - "Add a task by typing 'Buy milk tomorrow #Shopping'"
  - Delete examples after user creates first real task

### Loading States
- [ ] Design skeleton screens for list views
  - Placeholder rows with shimmer effect
- [ ] Add pull-to-refresh on list views
  - Spinner animation
  - Refresh data from database
  - Haptic feedback on refresh
- [ ] Show progress indicators for long operations
  - Export data
  - Import data
  - Sync (future)

### Micro-interactions
- [ ] Button press animations (scale down slightly)
- [ ] Hover effects on macOS/iPad (highlight, shadow)
- [ ] Focus indicators for keyboard navigation
- [ ] Loading spinners for async actions
- [ ] Success checkmarks for completed actions
- [ ] Error shake animation for validation errors

---

## Logic-Side To-Do Items

### Gesture Handling Logic
- [ ] Implement swipe gesture recognizers
- [ ] Define swipe action thresholds (distance, velocity)
- [ ] Handle gesture conflicts (scroll vs swipe)
- [ ] Implement haptic feedback controller

### Drag-and-Drop Logic
- [ ] Implement `NSItemProvider` for task dragging
- [ ] Implement drop delegates for drop targets
- [ ] Validate drop operations (can task be moved here?)
- [ ] Update task properties on drop (project, section, sortOrder)
- [ ] Implement reordering logic (update sortOrder for affected tasks)
- [ ] Handle multi-select drag data

### Theme Service
- [ ] Create `ThemeService` class
- [ ] Define `Theme` enum: system, light, dark
- [ ] Define color palette structs for each theme
- [ ] Implement `currentTheme` property (reactive)
- [ ] Implement `setTheme(_:)` method
- [ ] Implement `applyTheme(_:)` method
- [ ] Store theme preference in UserDefaults
- [ ] Listen to system appearance changes
- [ ] Provide theme colors via environment object

### Animation Configuration
- [ ] Define animation durations as constants
  - Fast: 0.2s
  - Normal: 0.3s
  - Slow: 0.5s
- [ ] Define animation curves (easeInOut, spring, etc.)
- [ ] Create reusable animation modifiers
- [ ] Implement animation preferences (reduce motion accessibility)

### Onboarding State
- [ ] Track onboarding completion in UserDefaults
- [ ] Implement `hasCompletedOnboarding` flag
- [ ] Implement `markOnboardingComplete()` method
- [ ] Implement `resetOnboarding()` method (for testing/settings)
- [ ] Create example tasks on first launch (optional)

### Empty State Logic
- [ ] Detect empty states (list.isEmpty)
- [ ] Provide contextual messages based on current view
- [ ] Track user progress (has created first task, etc.)

---

## Testing To-Do Items

### Unit Tests - Gesture Logic
- [ ] Test swipe threshold detection
- [ ] Test gesture action mapping (swipe left = delete, etc.)
- [ ] Test gesture conflicts resolution

### Unit Tests - Drag-and-Drop Logic
- [ ] Test reordering tasks updates sortOrder correctly
- [ ] Test moving task to different project updates project
- [ ] Test moving task to different section updates section
- [ ] Test drop validation (valid/invalid drops)
- [ ] Test multi-select drag includes all selected tasks

### Unit Tests - Theme Service
- [ ] Test theme switching updates current theme
- [ ] Test theme persistence across app restarts
- [ ] Test system theme changes trigger updates
- [ ] Test theme colors are correct for each theme
- [ ] Test theme applies to all components

### Unit Tests - Onboarding State
- [ ] Test onboarding shown on first launch
- [ ] Test onboarding not shown on subsequent launches
- [ ] Test reset onboarding allows showing again
- [ ] Test example tasks created on first launch

### Integration Tests
- [ ] Test swipe-to-complete marks task as done
- [ ] Test swipe-to-delete removes task
- [ ] Test drag-and-drop persists changes to database
- [ ] Test theme changes persist across app restarts
- [ ] Test onboarding completion persists

### UI Tests
- [ ] Test swipe right on task completes it
- [ ] Test swipe left on task shows delete action
- [ ] Test drag task to project changes project
- [ ] Test drag task within list reorders tasks
- [ ] Test theme switch updates UI colors
- [ ] Test empty state displays when list is empty
- [ ] Test onboarding flow completes successfully
- [ ] Test pull-to-refresh refreshes list

### Accessibility Tests
- [ ] Test animations respect reduce motion setting
- [ ] Test swipe gestures work with VoiceOver
- [ ] Test drag-and-drop works with keyboard (macOS)
- [ ] Test theme provides sufficient contrast
- [ ] Test haptic feedback respects accessibility settings

### Performance Tests
- [ ] Test drag-and-drop is smooth with 1000+ tasks
- [ ] Test theme switching is instantaneous
- [ ] Test animations don't drop frames
- [ ] Test swipe gestures respond immediately

---

## Acceptance Criteria

- ✅ Users can swipe to complete, delete, and schedule tasks
- ✅ Users can drag-and-drop to reorder tasks
- ✅ Users can drag-and-drop to move tasks between projects/sections
- ✅ All actions have smooth animations
- ✅ Theme system supports light, dark, and system modes
- ✅ Theme switching is smooth and immediate
- ✅ Empty states are friendly and helpful
- ✅ Onboarding guides new users through key features
- ✅ Haptic feedback provides tactile confirmation
- ✅ All micro-interactions feel polished
- ✅ All tests pass with >75% coverage

---

## Notes

- Swipe gestures should follow iOS conventions (right = positive action, left = destructive)
- Drag-and-drop should provide clear visual feedback (preview, drop target highlight)
- Animations should respect accessibility settings (reduce motion)
- Haptic feedback should be subtle (don't overuse)
- Theme should apply consistently across all views
- Empty states are an opportunity to guide users - make them actionable
- Onboarding should be skippable - don't force users through 10 screens
- Consider adding "What's New" screen for major updates
- Micro-interactions should feel intentional, not gratuitous
- Test gestures thoroughly on physical devices (not just simulator)
- Consider cultural differences in gesture expectations
- Drag-and-drop should work with assistive technologies

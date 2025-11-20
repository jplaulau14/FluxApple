# Block 13: Settings & Preferences

**Priority:** Medium
**Dependencies:** All previous blocks (settings control features from all blocks)
**Estimated Complexity:** Low-Medium

## Overview
Implement comprehensive settings and preferences system. Allow users to customize app behavior including default view, first day of week, reminder defaults, NLP/automation toggles, theme preferences, and display density. Settings should be well-organized, intuitive, and persistent.

---

## Client-Side To-Do Items

### Settings View Structure
- [ ] Create `SettingsView` with grouped sections
- [ ] Organize settings into logical groups:
  - General
  - Tasks & Views
  - NLP & Automation
  - Notifications & Reminders
  - Appearance
  - Data & Privacy
  - About
- [ ] Use native settings UI (macOS: preferences window, iOS: settings view)
- [ ] Support search within settings (optional)

### General Settings
- [ ] Default view on app launch picker:
  - Inbox
  - Today
  - Last opened view
  - Custom (select specific project/filter)
- [ ] First day of week picker (Sunday or Monday)
- [ ] Date format preference (optional)
- [ ] Time format preference (12-hour vs 24-hour)
- [ ] Start of day time (for "Today" calculation)
- [ ] End of day time (for overdue calculation)

### Tasks & Views Settings
- [ ] Include overdue tasks in Today view toggle
- [ ] Default task sort order picker (manual, due date, priority, etc.)
- [ ] Default task grouping picker (none, project, priority, etc.)
- [ ] Show completed tasks toggle
- [ ] Auto-archive completed tasks toggle (after N days)
- [ ] Confirm before deleting tasks toggle
- [ ] Task creation default project picker

### NLP & Automation Settings
- [ ] Enable NLP parsing toggle
- [ ] Auto-project suggestion toggle
- [ ] Auto-label suggestion toggle
- [ ] Auto-priority inference toggle
- [ ] Auto-due-date suggestion toggle
- [ ] Learn from my behavior toggle
- [ ] Reset learning data button with confirmation
- [ ] Show parsing hints toggle

### Notifications & Reminders Settings
- [ ] Default reminder time picker (e.g., 9:00 AM for all-day tasks)
- [ ] Enable notifications toggle
- [ ] Notification sound picker
- [ ] Badge count strategy picker:
  - Overdue tasks only
  - Today + overdue
  - All incomplete tasks
  - None
- [ ] Smart reminder toggle
- [ ] Snooze duration preferences

### Appearance Settings
- [ ] Theme picker (System, Light, Dark)
- [ ] Accent color picker (optional)
- [ ] Display density picker (Compact, Comfortable, Spacious - optional)
- [ ] Font size picker (Small, Medium, Large - optional)
- [ ] Show task icons toggle
- [ ] Sidebar position (left/right - macOS only)

### Data & Privacy Settings
- [ ] Storage used indicator (read-only)
- [ ] Number of tasks indicator (read-only)
- [ ] Export data button
- [ ] Import data button
- [ ] Clear all data button with multiple confirmations
- [ ] Privacy policy link (if applicable)
- [ ] Data collection settings (if using analytics)

### About Settings
- [ ] App version and build number
- [ ] Developer info
- [ ] Links to support/documentation
- [ ] Rate app button
- [ ] Share app button
- [ ] Open source licenses (if applicable)
- [ ] Show onboarding again button

### Settings Search (Optional)
- [ ] Add search bar at top of settings
- [ ] Filter settings by search term
- [ ] Highlight matching settings

---

## Logic-Side To-Do Items

### Settings Model
- [ ] Create `AppSettings` class using UserDefaults or SwiftData
- [ ] Define all setting properties with defaults:
  - `defaultView: DefaultView` (enum)
  - `firstDayOfWeek: Int` (0 = Sunday, 1 = Monday)
  - `use24HourTime: Bool`
  - `startOfDayHour: Int`
  - `includeOverdueInToday: Bool`
  - `defaultSortOrder: SortOrder` (enum)
  - `defaultGrouping: Grouping` (enum)
  - `showCompletedTasks: Bool`
  - `autoArchiveCompletedDays: Int?`
  - `confirmBeforeDelete: Bool`
  - `enableNLPParsing: Bool`
  - `autoProjectSuggestion: Bool`
  - `autoLabelSuggestion: Bool`
  - `autoPrioritySuggestion: Bool`
  - `learnFromBehavior: Bool`
  - `defaultReminderTime: Date`
  - `notificationSound: String`
  - `badgeCountStrategy: BadgeStrategy` (enum)
  - `theme: Theme` (enum: system, light, dark)
  - `accentColor: String?`
  - `displayDensity: Density` (enum - optional)
- [ ] Create enums for all setting types
- [ ] Implement property accessors with defaults

### Settings Service
- [ ] Create `SettingsService` singleton
- [ ] Implement `saveSetting(_:value:)` method
- [ ] Implement `getSetting(_:)` method
- [ ] Implement `resetToDefaults()` method
- [ ] Implement `exportSettings()` → JSON
- [ ] Implement `importSettings(from:)` → restore from JSON
- [ ] Publish settings changes via Combine/Observable

### Settings Persistence
- [ ] Use `UserDefaults` for simple key-value settings
- [ ] Use `@AppStorage` property wrapper in SwiftUI
- [ ] Implement settings sync (if iCloud sync is added in future)
- [ ] Handle settings migration for app updates

### Settings Application
- [ ] Apply settings changes immediately (reactive)
- [ ] Refresh relevant views when settings change
- [ ] Update notifications when notification settings change
- [ ] Recalculate Today view when "include overdue" toggle changes
- [ ] Update theme when theme setting changes

### Validation
- [ ] Validate time values (0-23 hours)
- [ ] Validate day of week (0-6)
- [ ] Validate auto-archive days (> 0)
- [ ] Validate theme and other enum values

---

## Testing To-Do Items

### Unit Tests - Settings Model
- [ ] Test all settings have default values
- [ ] Test setting values can be updated
- [ ] Test settings persist across app restarts
- [ ] Test enum settings store correct raw values
- [ ] Test settings validation (e.g., hours 0-23)

### Unit Tests - Settings Service
- [ ] Test saving setting updates storage
- [ ] Test getting setting returns correct value
- [ ] Test getting non-existent setting returns default
- [ ] Test reset to defaults clears all custom settings
- [ ] Test export settings returns valid JSON
- [ ] Test import settings restores values correctly

### Integration Tests
- [ ] Test changing default view updates app launch behavior
- [ ] Test changing first day of week updates calendar displays
- [ ] Test toggling "include overdue in Today" updates Today view
- [ ] Test changing theme updates UI immediately
- [ ] Test disabling NLP parsing disables parser
- [ ] Test changing notification settings updates scheduled notifications

### UI Tests
- [ ] Test opening settings view
- [ ] Test changing toggle setting updates value
- [ ] Test changing picker setting updates value
- [ ] Test reset to defaults confirmation dialog
- [ ] Test clear all data confirmation dialogs
- [ ] Test settings search filters results (if implemented)

### Edge Cases
- [ ] Test invalid setting values are rejected
- [ ] Test settings with nil/missing values use defaults
- [ ] Test rapid setting changes don't cause issues
- [ ] Test settings import with malformed JSON
- [ ] Test settings export/import round-trip

---

## Acceptance Criteria

- ✅ Users can access settings from main navigation
- ✅ Settings are organized into logical groups
- ✅ All major app behaviors can be customized
- ✅ Settings changes take effect immediately
- ✅ Settings persist across app restarts
- ✅ Users can reset settings to defaults
- ✅ Default values are sensible and documented
- ✅ Settings UI is native and familiar
- ✅ All tests pass with >80% coverage

---

## Notes

- Follow platform conventions for settings UI (macOS Preferences vs iOS Settings)
- Group related settings together for easy discovery
- Provide helpful descriptions for non-obvious settings
- Use inline help text or info buttons for complex settings
- Settings should be searchable (especially with many options)
- Consider adding "Recommended" or "Advanced" tabs to simplify UI
- Some settings might require app restart (note this to user)
- Export/import is useful for backup and migration between devices
- Privacy settings are increasingly important - be transparent
- Settings should be accessible from keyboard (macOS)
- Consider settings presets (e.g., "Minimalist", "Power User")
- Dangerous actions (clear data, reset) need multiple confirmations
- Settings should be testable in isolation (dependency injection)

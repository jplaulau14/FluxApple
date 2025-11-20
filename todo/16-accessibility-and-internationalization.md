# Block 16: Accessibility & Internationalization

**Priority:** High (Accessibility is essential, i18n is important for reach)
**Dependencies:** All previous blocks (applies to all UI)
**Estimated Complexity:** Medium

## Overview
Ensure the app is fully accessible to users with disabilities and supports internationalization for global reach. Implement Dynamic Type, VoiceOver support, sufficient contrast, keyboard navigation, localization infrastructure, and locale-aware formatting. Accessibility is not optional—it's essential for an inclusive product.

---

## Client-Side To-Do Items

### Dynamic Type Support
- [ ] Use SwiftUI's built-in Dynamic Type support
- [ ] Apply `.font(.body)`, `.font(.headline)`, etc. (not fixed point sizes)
- [ ] Test all views at various text size settings:
  - Extra Small (XS)
  - Small (S)
  - Medium (M) - default
  - Large (L)
  - Extra Large (XL)
  - Extra Extra Large (XXL)
  - Accessibility sizes (XXXL, AX1-AX5)
- [ ] Ensure layouts don't break at large text sizes
- [ ] Truncate or wrap long text appropriately
- [ ] Increase tap target sizes for accessibility sizes

### VoiceOver Support
- [ ] Add accessibility labels to all interactive elements
- [ ] Add accessibility hints for non-obvious actions
- [ ] Add accessibility values for stateful controls (checkbox: "checked"/"unchecked")
- [ ] Group related elements with `accessibilityElement(children: .combine)`
- [ ] Set accessibility traits (button, header, staticText, etc.)
- [ ] Implement custom actions for swipe gestures (since swipe conflicts with VoiceOver)
- [ ] Test entire app with VoiceOver enabled
- [ ] Ensure navigation flow is logical with VoiceOver
- [ ] Add rotor support for quick navigation (headings, landmarks)

### Specific VoiceOver Labels
- [ ] Task row: "Task title, due date, priority, status, completed"
- [ ] Checkbox: "Complete task" / "Uncomplete task"
- [ ] Add task button: "Add new task"
- [ ] Project in sidebar: "Project name, X tasks"
- [ ] Date picker: Use native date picker for proper VoiceOver
- [ ] Priority picker: "Priority: P1 - High", "Priority: P2 - Medium", etc.

### Color Contrast
- [ ] Ensure all text meets WCAG AA standards:
  - Normal text: 4.5:1 contrast ratio
  - Large text: 3:1 contrast ratio
- [ ] Test in both light and dark modes
- [ ] Use system colors where possible (they adapt to accessibility settings)
- [ ] Don't rely solely on color to convey information
- [ ] Add patterns/icons in addition to colors (e.g., priority icons + colors)
- [ ] Test with color blindness simulators

### Reduce Motion
- [ ] Detect `UIAccessibility.isReduceMotionEnabled`
- [ ] Disable or simplify animations when reduce motion is on
- [ ] Use crossfade instead of slide/scale animations
- [ ] Provide instant transitions as alternative
- [ ] Test all animations with reduce motion enabled

### Keyboard Navigation (macOS/iPad)
- [ ] Ensure all interactive elements are keyboard accessible
- [ ] Implement focus rings for focused elements
- [ ] Support tab navigation through all controls
- [ ] Support arrow key navigation in lists
- [ ] Implement keyboard shortcuts:
  - Cmd+N: New task
  - Cmd+F: Search
  - Cmd+,: Settings
  - Cmd+W: Close window
  - Space: Toggle checkbox
  - Enter: Open selected task
  - Delete: Delete selected task
- [ ] Add visible keyboard shortcut hints (tooltips)
- [ ] Test entire app with only keyboard (no mouse/trackpad)

### Localization (i18n) Infrastructure
- [ ] Set up localization infrastructure
- [ ] Create `Localizable.strings` file for each language
- [ ] Wrap all user-facing strings with `NSLocalizedString()` or SwiftUI equivalent
- [ ] Extract strings to localization files
- [ ] Support base language (English) + translations
- [ ] Set up localization export/import workflow

### Locale-Aware Formatting
- [ ] Use `DateFormatter` with locale awareness
- [ ] Use `NumberFormatter` for numbers (thousands separators, decimals)
- [ ] Support right-to-left (RTL) languages (Arabic, Hebrew)
  - Test layout in RTL mode
  - Ensure UI mirrors correctly
- [ ] Use locale-appropriate date formats
- [ ] Use locale-appropriate time formats (12h vs 24h)
- [ ] Use locale-appropriate first day of week (Sunday vs Monday)

### NLP Localization (Stretch)
- [ ] Localize NLP parser for primary supported languages
- [ ] Support date parsing in multiple languages
- [ ] Translate priority keywords ("high", "urgent" → equivalents)
- [ ] Translate recurrence keywords ("every day" → equivalents)
- [ ] Fall back to English parser if local language parser fails

---

## Logic-Side To-Do Items

### Accessibility Service
- [ ] Create `AccessibilityService` class
- [ ] Implement `isVoiceOverRunning()` method
- [ ] Implement `isReduceMotionEnabled()` method
- [ ] Implement `preferredContentSizeCategory()` method
- [ ] Listen to accessibility setting changes
- [ ] Publish changes via Combine/Observable

### Localization Service
- [ ] Create `LocalizationService` class
- [ ] Implement `currentLocale()` method
- [ ] Implement `setLocale(_:)` method (if in-app language switching)
- [ ] Implement `localizedString(key:)` method
- [ ] Load localized strings efficiently

### String Keys Management
- [ ] Define string keys as constants or enum
- [ ] Example: `LocalizationKey.taskListTitle`, `LocalizationKey.addTaskButton`
- [ ] Use type-safe string keys to avoid typos
- [ ] Consider using SwiftGen or similar tool for automation

### Date Formatting
- [ ] Create centralized date formatters
- [ ] Use locale-aware formatters everywhere
- [ ] Implement relative date formatting with localization ("Today", "Tomorrow")
- [ ] Handle locale-specific date patterns

### RTL Support
- [ ] Use `HStack` with automatic RTL flipping
- [ ] Use `.leading` and `.trailing` instead of `.left` and `.right`
- [ ] Test layout in RTL mode (Arabic simulator)
- [ ] Ensure icons flip correctly (back button, etc.)

### Localization Files Structure
- [ ] `en.lproj/Localizable.strings` - English (base)
- [ ] `es.lproj/Localizable.strings` - Spanish
- [ ] `fr.lproj/Localizable.strings` - French
- [ ] `de.lproj/Localizable.strings` - German
- [ ] `ja.lproj/Localizable.strings` - Japanese
- [ ] `ar.lproj/Localizable.strings` - Arabic (RTL testing)
- [ ] Add more as needed

---

## Testing To-Do Items

### Accessibility Tests - Dynamic Type
- [ ] Test all views at XS text size
- [ ] Test all views at default (M) text size
- [ ] Test all views at XXL text size
- [ ] Test all views at AX5 (largest accessibility size)
- [ ] Test layouts don't overlap or break at large sizes
- [ ] Test tap targets are at least 44x44 points

### Accessibility Tests - VoiceOver
- [ ] Test all interactive elements are reachable with VoiceOver
- [ ] Test all elements have appropriate labels
- [ ] Test all elements have appropriate hints
- [ ] Test navigation flow is logical
- [ ] Test custom actions work correctly
- [ ] Test rotor navigation works
- [ ] Test VoiceOver announces state changes (completed, etc.)

### Accessibility Tests - Color Contrast
- [ ] Test all text meets contrast requirements in light mode
- [ ] Test all text meets contrast requirements in dark mode
- [ ] Test with color blindness simulators (protanopia, deuteranopia, tritanopia)
- [ ] Test critical information is not color-only

### Accessibility Tests - Reduce Motion
- [ ] Test animations are disabled/simplified with reduce motion on
- [ ] Test app is still usable with reduce motion on
- [ ] Test transitions are still smooth without animation

### Accessibility Tests - Keyboard Navigation
- [ ] Test tab navigation reaches all interactive elements
- [ ] Test arrow key navigation in lists
- [ ] Test keyboard shortcuts work
- [ ] Test focus indicators are visible
- [ ] Test entire task workflow can be completed with keyboard only

### Localization Tests
- [ ] Test all strings are localized (no hardcoded English)
- [ ] Test date formatting respects locale
- [ ] Test number formatting respects locale
- [ ] Test first day of week respects locale
- [ ] Test RTL layout in Arabic
- [ ] Test UI fits translated strings (German is longer than English)

### Integration Tests
- [ ] Test switching text size updates entire app
- [ ] Test switching locale updates entire app
- [ ] Test VoiceOver state changes are detected
- [ ] Test reduce motion state changes are detected

### Manual Testing Checklist
- [ ] Test with VoiceOver on iPhone
- [ ] Test with VoiceOver on Mac
- [ ] Test with maximum text size on iPhone
- [ ] Test with color filters enabled (Settings > Accessibility > Display)
- [ ] Test with reduce motion enabled
- [ ] Test with keyboard only on Mac
- [ ] Test in Arabic (RTL)
- [ ] Test in another language (Spanish, French, etc.)

---

## Acceptance Criteria

- ✅ App supports Dynamic Type at all sizes without breaking
- ✅ App is fully navigable and usable with VoiceOver
- ✅ All interactive elements have accessibility labels/hints
- ✅ All text meets WCAG AA contrast requirements
- ✅ App respects reduce motion preference
- ✅ App is fully keyboard navigable (macOS/iPad)
- ✅ All user-facing strings are localized
- ✅ Date/time formatting is locale-aware
- ✅ RTL languages are properly supported
- ✅ All accessibility tests pass
- ✅ App passes automated accessibility audit

---

## Notes

- Accessibility is not a feature—it's a requirement
- Test with real assistive technologies, not just simulators
- Involve users with disabilities in testing if possible
- VoiceOver is the most critical accessibility feature to support
- Dynamic Type support is surprisingly easy with SwiftUI but must be tested
- Localization infrastructure should be set up early, even if translations come later
- RTL support often reveals layout bugs—test early
- Keyboard navigation is often overlooked but critical for power users
- Color contrast issues are among most common accessibility failures
- Consider hiring professional accessibility audit before launch
- Provide accessibility statement on website/in app
- Respond to accessibility feedback quickly—these are often blockers
- Localize more than just UI strings: images, onboarding, help text
- Consider in-app language switching (not just system language)
- NLP localization is complex—start with English, add languages incrementally
- Use locale-aware sorting for lists (e.g., names in Japanese)
- Test with actual users in target locales to catch cultural issues
- Accessibility and i18n should be baked in, not bolted on

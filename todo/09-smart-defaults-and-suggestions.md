# Block 09: Natural Language Input - Smart Defaults & Suggestions

**Priority:** Medium
**Dependencies:** Block 00-08 (Especially Block 08 - NLP Parser)
**Estimated Complexity:** High

## Overview
Implement intelligent auto-tagging, project/label suggestions, priority inference, and smart defaults based on task content and user patterns. Learn from past behavior to suggest project, labels, due dates, and priorities automatically.

---

## Client-Side To-Do Items

### Suggestion UI
- [ ] Create `SuggestionChipsView` component showing AI suggestions
- [ ] Display suggestions below input field as chips:
  - "Suggested: #Work"
  - "Suggested: @email"
  - "Suggested: Due tomorrow"
  - "Suggested: P2"
- [ ] Make suggestion chips clickable to apply
- [ ] Show confidence level with visual indicator (optional)
- [ ] Add "Dismiss" or "X" to ignore suggestions
- [ ] Animate suggestions appearing/disappearing

### Inline Suggestions
- [ ] Show auto-complete dropdown for projects while typing "#"
- [ ] Show auto-complete dropdown for labels while typing "@"
- [ ] Rank suggestions by relevance and frequency
- [ ] Support keyboard navigation in auto-complete (up/down arrows, Enter)

### Smart Defaults Indicators
- [ ] Show subtle indicator when default values are applied
- [ ] Display tooltip: "Default project: Work (click to change)"
- [ ] Add visual distinction between user-set and auto-set values

### Manual Override
- [ ] Always allow user to override suggested values
- [ ] Show clear affordance for changing auto-assigned properties
- [ ] Remember when user explicitly overrides (affects future suggestions)

### Settings Integration
- [ ] Add toggles in settings to enable/disable:
  - Auto-project suggestion
  - Auto-label suggestion
  - Auto-priority inference
  - Auto-due-date suggestion
  - Learn from my behavior
- [ ] Add "Reset learning data" button

---

## Logic-Side To-Do Items

### Suggestion Engine Architecture
- [ ] Create `SuggestionEngine` class
- [ ] Define `Suggestion` struct:
  - `type: SuggestionType` (project/label/priority/dueDate)
  - `value: Any` (the suggested value)
  - `confidence: Double` (0.0-1.0)
  - `reason: String` (why this was suggested)
- [ ] Create `SuggestionType` enum: project, label, priority, dueDate
- [ ] Implement `generateSuggestions(for:)` method

### Pattern Learning System
- [ ] Create `PatternLearner` class
- [ ] Create `TaskPattern` model to store learned patterns:
  - `keywords: [String]` (e.g., ["email", "send", "reply"])
  - `suggestedProject: Project?`
  - `suggestedLabels: [Label]`
  - `suggestedPriority: Priority?`
  - `frequency: Int` (how often this pattern appears)
  - `lastUsed: Date`
- [ ] Implement pattern extraction from completed/created tasks
- [ ] Store patterns in SwiftData or UserDefaults
- [ ] Update patterns based on user behavior

### Project Suggestion Logic
- [ ] Implement `suggestProject(for:)` method
- [ ] Analyze task title keywords
- [ ] Match keywords to historical task patterns
- [ ] Consider:
  - Most frequently used project for similar keywords
  - Last used project for this user
  - Time-of-day patterns (e.g., "Work" during work hours)
  - Current context (if in a project view, suggest that project)
- [ ] Return top 1-3 project suggestions with confidence scores

### Label Suggestion Logic
- [ ] Implement `suggestLabels(for:)` method
- [ ] Detect common label keywords:
  - "email", "send", "reply" → @email
  - "call", "phone" → @phone
  - "buy", "purchase" → @shopping
  - "home", "house" → @home
  - "urgent", "asap" → @urgent
- [ ] Check historical patterns for similar tasks
- [ ] Return top 1-5 label suggestions

### Priority Suggestion Logic
- [ ] Implement `suggestPriority(for:)` method
- [ ] Analyze urgency keywords:
  - "urgent", "asap", "critical" → P1
  - "important", "soon" → P2
  - "when possible", "someday" → P3
- [ ] Consider due date:
  - Due today or overdue → P1 or P2
  - Due this week → P2
  - Due later → P3 or P4
- [ ] Learn from user's past priority assignments
- [ ] Return priority suggestion with confidence

### Due Date Suggestion Logic
- [ ] Implement `suggestDueDate(for:)` method
- [ ] Analyze temporal keywords:
  - "urgent" → today or tomorrow
  - "soon" → within 3 days
  - "later" → next week
- [ ] Consider task type patterns:
  - Bills → suggest end of month
  - Meetings → suggest next weekday
- [ ] Use last-used due date time-of-day as default time
- [ ] Return due date suggestion with confidence

### Smart Defaults System
- [ ] Create `SmartDefaults` class
- [ ] Track user preferences:
  - Most used project (overall)
  - Most used labels (top 5)
  - Preferred due date time (e.g., 5pm)
  - Preferred priority (default P4, but learn if user changes often)
- [ ] Implement time-based defaults:
  - Morning (6am-12pm): suggest professional labels/projects
  - Evening (6pm-midnight): suggest personal labels/projects
- [ ] Store defaults in UserDefaults or database

### Context-Aware Suggestions
- [ ] Implement `getContext()` method
  - Current view (Inbox, Today, Project X)
  - Time of day
  - Day of week
  - Recent task creations
- [ ] Adjust suggestions based on context
- [ ] If in project view, strongly suggest that project
- [ ] If Friday, suggest weekend tasks lower priority

### Confidence Scoring
- [ ] Implement confidence calculation (0.0-1.0)
- [ ] Factors:
  - Pattern frequency (more frequent = higher confidence)
  - Recency (recent patterns = higher confidence)
  - Keyword match strength (exact match vs partial)
  - Context alignment
- [ ] Only show suggestions above confidence threshold (e.g., 0.6)

### Learning & Feedback Loop
- [ ] Track when user accepts suggestions
- [ ] Track when user ignores suggestions
- [ ] Track when user manually overrides
- [ ] Adjust pattern weights based on acceptance rate
- [ ] Decay old patterns over time (keep system fresh)

---

## Testing To-Do Items

### Unit Tests - Project Suggestion
- [ ] Test task with "work" keyword suggests Work project
- [ ] Test task with "home" keyword suggests Personal/Home project
- [ ] Test task with unknown keywords returns low confidence or no suggestion
- [ ] Test most frequently used project is suggested when ambiguous
- [ ] Test context (current view) affects project suggestion

### Unit Tests - Label Suggestion
- [ ] Test "send email" suggests @email label
- [ ] Test "call" suggests @phone label
- [ ] Test "buy" suggests @shopping label
- [ ] Test multiple keyword matches suggest multiple labels
- [ ] Test unknown task content returns no suggestions

### Unit Tests - Priority Suggestion
- [ ] Test "urgent" keyword suggests P1
- [ ] Test "important" keyword suggests P2
- [ ] Test due today suggests P1 or P2
- [ ] Test due next week suggests P3
- [ ] Test no urgency keywords suggests P4 (default)

### Unit Tests - Due Date Suggestion
- [ ] Test "urgent" suggests today or tomorrow
- [ ] Test "soon" suggests within 3 days
- [ ] Test "later" suggests next week
- [ ] Test bill-related task suggests end of month
- [ ] Test default time uses last-used time

### Unit Tests - Pattern Learning
- [ ] Test creating task with keywords stores pattern
- [ ] Test repeated pattern increases frequency count
- [ ] Test pattern matching returns correct suggestions
- [ ] Test old patterns decay over time
- [ ] Test pattern learning can be reset

### Unit Tests - Confidence Scoring
- [ ] Test high-frequency pattern has high confidence
- [ ] Test recent pattern has higher confidence than old pattern
- [ ] Test exact keyword match has higher confidence than partial
- [ ] Test low confidence suggestions are filtered out

### Integration Tests
- [ ] Test creating task with suggestion applies correctly
- [ ] Test ignoring suggestion doesn't apply value
- [ ] Test manually overriding suggestion updates learning
- [ ] Test suggestions improve over time with usage
- [ ] Test turning off suggestions in settings disables feature
- [ ] Test reset learning data clears all patterns

### UI Tests
- [ ] Test suggestion chips appear below input
- [ ] Test clicking suggestion chip applies value
- [ ] Test auto-complete dropdown appears when typing "#"
- [ ] Test auto-complete shows relevant projects
- [ ] Test selecting from auto-complete applies project
- [ ] Test dismissing suggestion removes chip

### Performance Tests
- [ ] Test suggestion generation completes in < 100ms
- [ ] Test pattern lookup is fast with 1000+ patterns
- [ ] Test learning doesn't slow down task creation

---

## Acceptance Criteria

- ✅ Users receive intelligent project suggestions based on task content
- ✅ Users receive label suggestions based on keywords
- ✅ Users receive priority suggestions based on urgency and due date
- ✅ Users receive due date suggestions based on context
- ✅ System learns from user behavior and improves over time
- ✅ Suggestions are displayed as clickable chips
- ✅ Auto-complete works for projects and labels
- ✅ Users can enable/disable suggestions in settings
- ✅ Manual overrides are respected and affect future suggestions
- ✅ Confidence scoring filters out low-quality suggestions
- ✅ All tests pass with >70% coverage

---

## Notes

- Start with simple keyword matching, add ML later if needed
- Privacy-first: all learning happens on-device
- Consider using Core ML for more advanced pattern recognition (future)
- Don't be too aggressive with suggestions - respect user intent
- Confidence threshold should be tunable in settings (advanced users)
- Consider showing "why" a suggestion was made (transparency)
- Suggestion engine should be testable in isolation
- Add telemetry (privacy-conscious) to measure suggestion acceptance rates
- Consider collaborative filtering (if sync is added) - learn from similar users
- Pattern learning should be exportable/importable (for backup/migration)

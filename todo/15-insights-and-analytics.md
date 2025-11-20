# Block 15: Insights & Analytics (Stretch Feature)

**Priority:** Low (Stretch)
**Dependencies:** All previous blocks (analyzes data from all features)
**Estimated Complexity:** Medium

## Overview
Implement productivity insights and analytics including completion statistics, streaks, per-project metrics, completion trends, and optional gamification. Help users understand their productivity patterns and stay motivated. This is a stretch feature that enhances the core experience but is not essential.

---

## Client-Side To-Do Items

### Analytics Dashboard
- [ ] Create `AnalyticsView` accessible from main navigation
- [ ] Design dashboard layout with cards/sections:
  - Overview stats (today, week, month)
  - Completion chart
  - Streaks
  - Per-project breakdown
  - Productivity insights
- [ ] Add date range selector (Last 7 days, Last 30 days, All time)
- [ ] Support scrolling through time periods

### Overview Stats
- [ ] Display key metrics in card format:
  - Tasks completed today
  - Tasks completed this week
  - Tasks completed this month
  - Total tasks created
  - Current streak
  - Longest streak
  - Completion rate (%)
- [ ] Use large, readable numbers
- [ ] Add trend indicators (up/down arrows)

### Completion Chart
- [ ] Create bar chart showing completions per day
- [ ] X-axis: dates, Y-axis: task count
- [ ] Support different time ranges (week, month, year)
- [ ] Highlight current day
- [ ] Show average completion line
- [ ] Make bars tappable to see details

### Streaks Section
- [ ] Display current streak prominently
  - "🔥 5 day streak!"
- [ ] Show longest streak ever
- [ ] Show streak history (calendar heatmap style)
- [ ] Add streak milestones (7 days, 30 days, 100 days)
- [ ] Show motivation message when streak is active

### Per-Project Metrics
- [ ] List all projects with stats:
  - Total tasks
  - Completed tasks
  - Active tasks
  - Completion rate
  - Most productive day
- [ ] Sort by most active, completion rate, etc.
- [ ] Show mini chart per project (sparkline)
- [ ] Tap project to see detailed project analytics

### Productivity Insights
- [ ] Generate insights based on data:
  - "You're most productive on Tuesdays"
  - "You complete 80% of tasks marked P1"
  - "Your average time to complete: 2.3 days"
  - "You work best in the morning"
- [ ] Update insights weekly
- [ ] Make insights actionable (e.g., "Schedule important tasks on Tuesday")

### Gamification (Optional)
- [ ] Add points system:
  - Task completed: +10 points
  - Streak maintained: +5 points
  - High priority task: +20 points
- [ ] Display total points and level
- [ ] Add achievements/badges:
  - "First Task" - complete first task
  - "Week Warrior" - 7 day streak
  - "Centurion" - complete 100 tasks
  - "Early Bird" - complete task before 8am
  - "Night Owl" - complete task after 10pm
- [ ] Show achievement notifications
- [ ] Create achievements gallery

---

## Logic-Side To-Do Items

### Analytics Model
- [ ] Create `AnalyticsSummary` struct:
  - `completedToday: Int`
  - `completedThisWeek: Int`
  - `completedThisMonth: Int`
  - `totalTasks: Int`
  - `currentStreak: Int`
  - `longestStreak: Int`
  - `completionRate: Double`
- [ ] Create `CompletionDataPoint` struct:
  - `date: Date`
  - `count: Int`
- [ ] Create `ProjectAnalytics` struct:
  - `project: Project`
  - `totalTasks: Int`
  - `completedTasks: Int`
  - `activeTasks: Int`
  - `completionRate: Double`

### Analytics Service
- [ ] Create `AnalyticsService` class
- [ ] Implement `getAnalyticsSummary()` method
- [ ] Implement `getCompletionData(from:to:)` method
  - Group completions by day
  - Return array of data points
- [ ] Implement `getProjectAnalytics()` method
  - Calculate metrics for each project
- [ ] Implement `getCurrentStreak()` method
  - Count consecutive days with completions
- [ ] Implement `getLongestStreak()` method
  - Find longest historical streak
- [ ] Implement `getCompletionRate()` method
  - (completed tasks / total tasks) * 100

### Streak Service
- [ ] Create `StreakService` class
- [ ] Implement streak calculation logic:
  - Check if user completed at least 1 task today
  - Count consecutive days backwards from today
- [ ] Implement `getStreakHistory()` method
  - Return dates with completions for heatmap
- [ ] Implement streak persistence
  - Store last completion date
  - Detect when streak is broken
- [ ] Implement streak notifications (optional)
  - Remind user to maintain streak

### Insights Engine
- [ ] Create `InsightsEngine` class
- [ ] Implement `generateInsights()` method
  - Analyze completion patterns
  - Find most productive days of week
  - Find most productive times of day
  - Calculate average completion time
  - Find completion rate by priority
- [ ] Implement insight templates with placeholders
- [ ] Return list of actionable insights

### Charts Data Processing
- [ ] Implement data aggregation for charts
- [ ] Group completions by day, week, month
- [ ] Calculate moving averages
- [ ] Find outliers and trends
- [ ] Prepare data in format for chart library

### Gamification Service (Optional)
- [ ] Create `GamificationService` class
- [ ] Implement points calculation logic
- [ ] Implement level calculation (points → level)
- [ ] Create `Achievement` model:
  - `id: String`
  - `name: String`
  - `description: String`
  - `icon: String`
  - `unlockedAt: Date?`
  - `criteria: String` (JSON or predicate)
- [ ] Implement `checkAchievements()` method
  - Evaluate all achievements
  - Award newly earned achievements
- [ ] Implement achievement notifications
- [ ] Persist points and achievements

---

## Testing To-Do Items

### Unit Tests - Analytics Service
- [ ] Test summary calculates correct completion counts
- [ ] Test completion data groups by date correctly
- [ ] Test project analytics calculates metrics correctly
- [ ] Test completion rate calculation
- [ ] Test analytics with empty database

### Unit Tests - Streak Service
- [ ] Test current streak with consecutive completions
- [ ] Test current streak resets when day is missed
- [ ] Test longest streak tracks maximum
- [ ] Test streak persists across app restarts
- [ ] Test streak history returns correct dates

### Unit Tests - Insights Engine
- [ ] Test insights finds most productive day
- [ ] Test insights calculates average completion time
- [ ] Test insights identifies patterns
- [ ] Test insights handles insufficient data gracefully

### Unit Tests - Gamification
- [ ] Test points awarded for task completion
- [ ] Test level calculation from points
- [ ] Test achievement criteria evaluation
- [ ] Test achievement unlock notifications
- [ ] Test achievements persist

### Integration Tests
- [ ] Test completing tasks updates analytics in real-time
- [ ] Test analytics reflect historical data accurately
- [ ] Test streak increments with daily completions
- [ ] Test insights regenerate periodically
- [ ] Test gamification points and achievements sync with actions

### UI Tests
- [ ] Test opening analytics dashboard
- [ ] Test charts display data correctly
- [ ] Test date range selector updates charts
- [ ] Test tapping project shows detailed analytics
- [ ] Test achievement gallery displays all achievements
- [ ] Test streak heatmap shows completion history

### Performance Tests
- [ ] Test analytics calculation with 10,000+ tasks
- [ ] Test chart rendering with 365 data points
- [ ] Test insights generation completes quickly

---

## Acceptance Criteria

- ✅ Users can view productivity analytics dashboard
- ✅ Users can see completion statistics (day/week/month)
- ✅ Users can track current and longest streaks
- ✅ Users can view completion charts over time
- ✅ Users can see per-project analytics
- ✅ Users receive actionable productivity insights
- ✅ Gamification features (if implemented) are engaging
- ✅ All analytics update in real-time as tasks change
- ✅ All tests pass with >70% coverage

---

## Notes

- This is a stretch feature - implement after core functionality is solid
- Analytics should be lightweight and not impact app performance
- Privacy is important - all analytics are local, never sent to server
- Streak feature can be motivating but also stressful - make it optional
- Insights should be genuinely helpful, not just vanity metrics
- Consider using Charts framework (iOS 16+) for beautiful built-in charts
- Gamification is controversial - some users love it, others hate it
- Make gamification opt-in via settings
- Don't make analytics too prominent - focus stays on getting things done
- Consider adding export analytics feature (CSV of completion data)
- Insights engine could use simple heuristics initially, ML later
- Streak notifications should be gentle reminders, not pressure
- Achievement badges should be meaningful, not trivial
- Consider social features (compare with friends) but only with explicit opt-in
- Analytics are most useful when they inform behavior change
- Test insights accuracy with real user data before shipping

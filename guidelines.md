# Code Guidelines

## Core Principles

**Clarity over cleverness.** Code is read far more often than it is written. Optimize for the next person (including future you) who will read and modify this code.

**Simplicity over sophistication.** Use the simplest solution that solves the problem. Don't add complexity for hypothetical future needs.

**Explicitness over implicitness.** Make intentions clear. Avoid hidden behavior and magic.

---

## Writing Clean Code

### Be Direct and Obvious

```swift
// ❌ Clever
let tasks = items.filter { $0.dueDate.map { $0 < Date() } ?? false }

// ✅ Clear
let tasks = items.filter { task in
    guard let dueDate = task.dueDate else { return false }
    return dueDate < Date()
}

// ✅ Even better - named intent
let overdueTasks = items.filter { task in
    guard let dueDate = task.dueDate else { return false }
    return dueDate < Date()
}
```

### Use English-Looking Code

Write code that reads like natural language. Name things what they are, not abbreviations or technical jargon.

```swift
// ❌ Abbreviated, unclear
func updTsk(_ t: Task, pri: Int) -> Bool

// ✅ Reads like English
func updateTaskPriority(_ task: Task, priority: Priority) -> Bool

// ✅ Even more readable
func setTaskPriority(task: Task, to priority: Priority) -> Bool
```

### Prefer Longer, Descriptive Names

```swift
// ❌ Cryptic
var cmp: Bool
let tcnt: Int
func proc()

// ✅ Self-documenting
var isCompleted: Bool
let taskCount: Int
func processOverdueTasks()
```

---

## Avoiding Unnecessary Abstractions

### Don't Abstract Until You Need To

Wait until you have **three** real use cases before creating an abstraction. Two similar pieces of code is not duplication—it's coincidence.

```swift
// ❌ Premature abstraction
protocol TaskProcessor {
    func process(_ task: Task) throws
}

class TaskCompletionProcessor: TaskProcessor { ... }
class TaskDeletionProcessor: TaskProcessor { ... }

// ✅ Start simple - just write the functions
func completeTask(_ task: Task) {
    task.isCompleted = true
    task.completedAt = Date()
}

func deleteTask(_ task: Task) {
    modelContext.delete(task)
}
```

### Avoid Generic "Managers" and "Helpers"

These are code smells indicating unclear responsibilities.

```swift
// ❌ Vague, catch-all
class TaskManager {
    func doTaskStuff()
    func handleTaskThing()
}

class TaskHelper {
    static func someTaskUtility()
}

// ✅ Specific, clear purpose
class TaskCompletionService {
    func completeTask(_ task: Task)
    func uncompleteTask(_ task: Task)
}

class TaskDateCalculator {
    func calculateNextRecurrence(from date: Date) -> Date
}
```

### Don't Create Interfaces Before Implementations

Start with concrete implementations. Extract protocols only when you have a real need (testing, multiple implementations, etc.).

```swift
// ❌ Premature protocol
protocol DataStorageProtocol {
    func save<T>(_ item: T)
    func load<T>() -> T?
}

class SwiftDataStorage: DataStorageProtocol { ... }

// ✅ Start concrete
class TaskStorage {
    func saveTask(_ task: Task) { ... }
    func loadTasks() -> [Task] { ... }
}

// Only add protocol later if you actually need multiple implementations
```

---

## Avoiding Premature Optimization

### Optimize for Correctness First, Speed Second

Make it work, make it right, then make it fast—in that order.

```swift
// ✅ Start simple and correct
func findOverdueTasks() -> [Task] {
    return allTasks.filter { task in
        guard let dueDate = task.dueDate else { return false }
        return dueDate < Date()
    }
}

// Only optimize if profiling shows this is actually slow
// (Spoiler: it won't be until you have 10,000+ tasks)
```

### Don't Cache Until You Measure

Caching adds complexity. Only add it when you have proof it's needed.

```swift
// ❌ Premature caching
class TaskService {
    private var cachedTasks: [Task]?
    private var cacheTimestamp: Date?

    func getTasks() -> [Task] {
        if let cached = cachedTasks,
           let timestamp = cacheTimestamp,
           Date().timeIntervalSince(timestamp) < 60 {
            return cached
        }
        // ... complex cache management
    }
}

// ✅ Start simple
class TaskService {
    func getTasks() -> [Task] {
        return try! modelContext.fetch(FetchDescriptor<Task>())
    }
}
```

### Trust the Platform

SwiftData, SwiftUI, and Foundation are highly optimized. Don't second-guess them without evidence.

```swift
// ❌ Micro-optimization without measurement
class TaskList {
    private var taskCache: [UUID: Task] = [:]

    func task(withId id: UUID) -> Task? {
        if let cached = taskCache[id] {
            return cached
        }
        let task = fetchTaskFromDatabase(id)
        taskCache[id] = task
        return task
    }
}

// ✅ Trust SwiftData's built-in optimizations
class TaskList {
    func task(withId id: UUID) -> Task? {
        let descriptor = FetchDescriptor<Task>(
            predicate: #Predicate { $0.id == id }
        )
        return try? modelContext.fetch(descriptor).first
    }
}
```

---

## Code Organization

### Keep Functions Small and Focused

Each function should do **one thing** and do it well. If you can't name it clearly, it's doing too much.

```swift
// ❌ Does too much
func handleTaskCompletion(_ task: Task) {
    task.isCompleted = true
    task.completedAt = Date()

    if let recurrence = task.recurrence {
        let nextTask = Task(title: task.title)
        nextTask.dueDate = calculateNextDate(recurrence)
        modelContext.insert(nextTask)
    }

    NotificationCenter.default.post(name: .taskCompleted, object: task)
    updateBadgeCount()
}

// ✅ Separated concerns
func completeTask(_ task: Task) {
    task.isCompleted = true
    task.completedAt = Date()
}

func generateNextRecurringTask(from task: Task) -> Task? {
    guard let recurrence = task.recurrence else { return nil }
    let nextTask = Task(title: task.title)
    nextTask.dueDate = calculateNextDate(recurrence)
    return nextTask
}

func notifyTaskCompleted(_ task: Task) {
    NotificationCenter.default.post(name: .taskCompleted, object: task)
}
```

### Early Returns for Clarity

Use guard statements and early returns to reduce nesting and improve readability.

```swift
// ❌ Nested conditions
func processTask(_ task: Task?) {
    if let task = task {
        if task.isCompleted == false {
            if let dueDate = task.dueDate {
                if dueDate < Date() {
                    // actual work here
                }
            }
        }
    }
}

// ✅ Guard statements - clear and flat
func processTask(_ task: Task?) {
    guard let task = task else { return }
    guard task.isCompleted == false else { return }
    guard let dueDate = task.dueDate else { return }
    guard dueDate < Date() else { return }

    // actual work here - obvious and unindented
}
```

### Avoid Boolean Parameters

They make call sites cryptic. Use enums or separate functions instead.

```swift
// ❌ What does `true` mean here?
task.complete(true)
fetchTasks(false, true)

// ✅ Clear at call site
task.complete(includeSubtasks: .yes)
fetchTasks(includeCompleted: .no, sortByDate: .yes)

// ✅ Even better - separate functions
task.completeWithSubtasks()
fetchIncompleteTasks(sortedByDate: true)
```

---

## Comments and Documentation

### Code Should Be Self-Documenting

If you need a comment to explain **what** code does, rewrite the code to be clearer.

```swift
// ❌ Comment explains what
// Check if task is overdue
if task.dueDate != nil && task.dueDate! < Date() { ... }

// ✅ Code explains itself
let isOverdue = task.dueDate.map { $0 < Date() } ?? false
if isOverdue { ... }

// ✅ Even better - computed property
extension Task {
    var isOverdue: Bool {
        guard let dueDate = dueDate else { return false }
        return dueDate < Date()
    }
}

if task.isOverdue { ... }
```

### Use Comments for "Why", Not "What"

Explain the reasoning behind non-obvious decisions.

```swift
// ❌ States the obvious
// Set the completed date to now
task.completedAt = Date()

// ✅ Explains reasoning
// Use end of day to avoid timezone issues when calculating streaks
task.completedAt = Calendar.current.endOfDay(for: Date())

// ✅ Explains constraints
// We must check parent task first because SwiftData doesn't support
// cascading deletes on optional relationships (as of iOS 17)
if let parent = task.parentTask {
    deleteSubtasks(of: parent)
}
```

### Document Public APIs

Add doc comments to public functions, classes, and complex logic.

```swift
/// Calculates the next occurrence date for a recurring task.
///
/// - Parameters:
///   - task: The task with recurrence information
///   - from: The date to calculate from (typically the current due date)
/// - Returns: The next occurrence date, or nil if recurrence has ended
///
/// - Note: Uses "strict" recurrence (from due date) rather than "flexible" (from completion date)
func calculateNextOccurrence(for task: Task, from date: Date) -> Date? {
    guard let recurrence = task.recurrence else { return nil }
    // ...
}
```

---

## Error Handling

### Be Explicit About Errors

Don't hide failures with `try?` unless you truly don't care about the error.

```swift
// ❌ Silent failure
let tasks = try? modelContext.fetch(descriptor)

// ✅ Handle the error
do {
    let tasks = try modelContext.fetch(descriptor)
    return tasks
} catch {
    print("Failed to fetch tasks: \(error)")
    return []
}

// ✅ Or propagate it
func fetchTasks() throws -> [Task] {
    return try modelContext.fetch(descriptor)
}
```

### Fail Fast

Validate inputs early and fail immediately rather than propagating invalid state.

```swift
// ❌ Invalid state propagates
func createTask(title: String) -> Task {
    let task = Task()
    task.title = title  // Empty string allowed!
    return task
}

// ✅ Fail fast
func createTask(title: String) throws -> Task {
    guard !title.isEmpty else {
        throw TaskError.emptyTitle
    }

    let task = Task()
    task.title = title
    return task
}
```

---

## Testing Principles

### Write Tests That Read Like Specifications

Test names should describe behavior, not implementation.

```swift
// ❌ Implementation-focused
func testTaskCompletion() { ... }

// ✅ Behavior-focused
func testCompletingTaskSetsCompletedDateToNow() { ... }
func testCompletingRecurringTaskCreatesNextInstance() { ... }
func testCompletingTaskWithSubtasksLeavesSubtasksIncomplete() { ... }
```

### One Assertion Per Test (Guideline, Not Rule)

Focus tests on a single behavior for clarity.

```swift
// ❌ Too much in one test
func testTaskOperations() {
    let task = createTask()
    XCTAssertEqual(task.title, "Test")

    completeTask(task)
    XCTAssertTrue(task.isCompleted)

    deleteTask(task)
    XCTAssertNil(fetchTask(task.id))
}

// ✅ Separate tests for each behavior
func testCreatingTaskSetsTitle() {
    let task = createTask(title: "Test")
    XCTAssertEqual(task.title, "Test")
}

func testCompletingTaskSetsCompletedFlag() {
    let task = createTask()
    completeTask(task)
    XCTAssertTrue(task.isCompleted)
}

func testDeletingTaskRemovesFromDatabase() {
    let task = createTask()
    deleteTask(task)
    XCTAssertNil(fetchTask(task.id))
}
```

---

## SwiftUI Best Practices

### Keep Views Small

Extract subviews when a view gets beyond ~50-100 lines.

```swift
// ❌ Massive view
struct TaskListView: View {
    var body: some View {
        VStack {
            // 200 lines of view code
        }
    }
}

// ✅ Composed from smaller views
struct TaskListView: View {
    var body: some View {
        VStack {
            TaskListHeader()
            TaskListFilters()
            TaskListContent()
            TaskListFooter()
        }
    }
}
```

### Prefer Computed Properties to Functions

For simple transformations, computed properties read better than functions.

```swift
// ❌ Function for simple logic
func getDisplayDate() -> String {
    return task.dueDate?.formatted() ?? "No date"
}

// ✅ Computed property
var displayDate: String {
    task.dueDate?.formatted() ?? "No date"
}
```

### Use ViewModels for Complex State

But don't create ViewModels for every view—use them when state management is non-trivial.

```swift
// ❌ ViewModel for simple view
class ButtonViewModel: ObservableObject {
    @Published var title: String
}

// ✅ Direct view for simple cases
struct SimpleButton: View {
    let title: String
    var body: some View {
        Button(title) { }
    }
}

// ✅ ViewModel for complex state
@Observable
class TaskListViewModel {
    var tasks: [Task] = []
    var filterMode: FilterMode = .all
    var sortOrder: SortOrder = .dueDate

    func loadTasks() async { ... }
    func applyFilter(_ filter: FilterMode) { ... }
}
```

---

## What to Avoid

### ❌ Clever One-Liners

```swift
// ❌ Clever but cryptic
let c = t.filter{$0.d != nil && $0.d! < Date()}.map{$0.p}.reduce(0,+)

// ✅ Verbose but clear
let overdueTasks = tasks.filter { task in
    guard let dueDate = task.dueDate else { return false }
    return dueDate < Date()
}
let totalPriority = overdueTasks.map { $0.priority.rawValue }.reduce(0, +)
```

### ❌ Inheritance Hierarchies

Prefer composition over inheritance. Use protocols and extensions instead.

```swift
// ❌ Deep inheritance
class BaseTask { }
class ScheduledTask: BaseTask { }
class RecurringScheduledTask: ScheduledTask { }

// ✅ Composition with protocols
protocol Schedulable {
    var dueDate: Date? { get set }
}

protocol Recurring {
    var recurrence: RecurrenceRule? { get set }
}

struct Task: Schedulable, Recurring {
    var dueDate: Date?
    var recurrence: RecurrenceRule?
}
```

### ❌ Over-Engineering

```swift
// ❌ Factory pattern for simple object creation
class TaskFactory {
    static func createTask(ofType type: TaskType) -> TaskProtocol {
        switch type {
        case .simple: return SimpleTask()
        case .recurring: return RecurringTask()
        }
    }
}

// ✅ Just create the objects
let task = Task(title: "Buy milk")
let recurringTask = Task(title: "Pay rent", recurrence: .monthly)
```

---

## Summary

**Write code for humans, not computers.** The compiler will figure out the optimizations—you focus on clarity.

**Use the simplest solution that works.** Don't add complexity for imaginary future requirements.

**Be explicit and obvious.** Avoid tricks, shortcuts, and cleverness. Boring code is good code.

**Trust yourself to refactor later.** You don't need to get the design perfect on the first try. Start simple, evolve as needed.

---

## When in Doubt

Ask: "Will I understand this code in 6 months without comments?"

If the answer is no, simplify it.

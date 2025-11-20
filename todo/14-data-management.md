# Block 14: Data Management

**Priority:** Medium
**Dependencies:** All previous blocks (manages data from all features)
**Estimated Complexity:** Medium-High

## Overview
Implement comprehensive data management including backup, export to JSON/CSV, import from JSON, data validation and integrity checks, database migration support, and data cleanup utilities. Ensure users never lose data and can migrate between devices.

---

## Client-Side To-Do Items

### Export UI
- [ ] Create "Export Data" button in settings
- [ ] Show export format picker:
  - JSON (full data, all relationships)
  - CSV (simplified, flat structure)
- [ ] Add export scope selector:
  - All data
  - Tasks only
  - Projects only
  - Specific project
  - Date range
- [ ] Show progress indicator during export
- [ ] Present share sheet to save/share exported file
- [ ] Show success confirmation with file location
- [ ] Show error message if export fails

### Import UI
- [ ] Create "Import Data" button in settings
- [ ] Show file picker for JSON files
- [ ] Add import options:
  - Merge with existing data
  - Replace all data (with confirmation)
  - Import as new project
- [ ] Show import preview (number of tasks, projects, etc.)
- [ ] Show progress indicator during import
- [ ] Display import summary (X tasks imported, Y duplicates skipped)
- [ ] Show error details if import fails
- [ ] Offer to undo import if something went wrong

### Backup UI
- [ ] Create "Backup Now" button in settings
- [ ] Show automatic backup toggle
- [ ] Configure backup frequency (daily, weekly, manual only)
- [ ] Show last backup date/time
- [ ] Show backup file size
- [ ] List available backups (date, size)
- [ ] Add "Restore from Backup" button
- [ ] Show backup restore confirmation dialog

### Data Integrity UI
- [ ] Create "Check Data Integrity" button (advanced settings)
- [ ] Show integrity check results:
  - Number of orphaned records
  - Number of invalid relationships
  - Number of corrupt records
- [ ] Add "Fix Issues" button to repair problems
- [ ] Show repair progress and results

### Data Cleanup UI
- [ ] Create "Clear Completed Tasks" button
- [ ] Add date range selector (older than X days)
- [ ] Show confirmation with count of tasks to be deleted
- [ ] Create "Clear All Data" button with multiple confirmations
- [ ] Show warning about irreversible action

---

## Logic-Side To-Do Items

### Export Service
- [ ] Create `ExportService` class
- [ ] Implement `exportToJSON(scope:)` method
  - Serialize all tasks with relationships
  - Include projects, labels, sections, subtasks, attachments, reminders
  - Generate JSON with proper schema version
  - Return Data or file URL
- [ ] Implement `exportToCSV(scope:)` method
  - Flatten task data to CSV columns
  - Include: ID, Title, Description, Due Date, Priority, Status, Project, Labels
  - Handle multi-value fields (labels) as comma-separated
  - Return CSV string or file URL
- [ ] Implement export scoping logic (all, project, date range)
- [ ] Implement `generateFileName()` with timestamp
- [ ] Handle export errors gracefully

### Import Service
- [ ] Create `ImportService` class
- [ ] Implement `importFromJSON(data:mode:)` method
  - Parse JSON data
  - Validate schema version compatibility
  - Import tasks with all relationships
  - Resolve project/label references by name
  - Handle merge vs replace mode
- [ ] Implement duplicate detection logic
  - Check by ID (if importing from export)
  - Check by title + due date (fuzzy matching)
  - Skip or merge duplicates based on strategy
- [ ] Implement `validateJSON(_:)` method
  - Check schema structure
  - Validate required fields
  - Return validation errors
- [ ] Implement relationship resolution
  - Map project names to existing projects or create new
  - Map label names to existing labels or create new
  - Recreate subtask hierarchies
- [ ] Implement rollback on error (transaction-based import)

### Backup Service
- [ ] Create `BackupService` class
- [ ] Implement `createBackup()` method
  - Export all data to JSON
  - Save to app's documents directory
  - Add timestamp to filename
  - Compress backup file (optional)
- [ ] Implement `listBackups()` method
  - Scan backup directory
  - Return list of backups with metadata (date, size)
- [ ] Implement `restoreFromBackup(_:)` method
  - Load backup file
  - Import data using ImportService
  - Replace all existing data
- [ ] Implement automatic backup scheduling
  - Run backup daily/weekly based on settings
  - Use background task API (if available)
  - Limit number of backups (keep last 10)
- [ ] Implement `deleteBackup(_:)` method
- [ ] Implement `deleteOldBackups(keepLast:)` method

### Data Integrity Service
- [ ] Create `DataIntegrityService` class
- [ ] Implement `checkIntegrity()` method
  - Find orphaned subtasks (parent task deleted)
  - Find orphaned reminders (task deleted)
  - Find invalid relationships (references to non-existent IDs)
  - Find tasks with invalid data (empty titles, etc.)
  - Return list of issues
- [ ] Implement `repairIssues(_:)` method
  - Delete orphaned records
  - Fix invalid relationships
  - Set default values for invalid data
  - Return repair summary
- [ ] Implement consistency checks
  - Verify sortOrder is sequential
  - Verify completion dates are valid
  - Verify recurrence instances link correctly

### Data Cleanup Service
- [ ] Create `CleanupService` class
- [ ] Implement `deleteCompletedTasks(olderThan:)` method
  - Find completed tasks older than date
  - Delete tasks and cascade to relationships
  - Return count of deleted tasks
- [ ] Implement `clearAllData()` method
  - Delete all tasks, projects, labels, sections
  - Reset all settings to defaults (optional)
  - Clear all learning data
  - Return success confirmation
- [ ] Implement `archiveOldTasks(olderThan:)` method
  - Alternative to deletion - archive instead

### Migration Service
- [ ] Create `MigrationService` class
- [ ] Define schema versions
- [ ] Implement migration paths:
  - v1 → v2 migration
  - v2 → v3 migration
  - etc.
- [ ] Handle SwiftData schema evolution
- [ ] Implement `currentSchemaVersion()` method
- [ ] Implement `needsMigration()` method
- [ ] Implement `performMigration(from:to:)` method

### Data Validation
- [ ] Validate exported JSON schema
- [ ] Validate imported data before applying
- [ ] Validate file formats (JSON vs CSV)
- [ ] Validate file sizes (warn if very large)
- [ ] Validate dates are within reasonable range
- [ ] Validate relationships exist

---

## Testing To-Do Items

### Unit Tests - Export Service
- [ ] Test export to JSON creates valid JSON
- [ ] Test export includes all task properties
- [ ] Test export includes all relationships
- [ ] Test export to CSV creates valid CSV
- [ ] Test export scoping (all, project, date range)
- [ ] Test filename generation includes timestamp
- [ ] Test export handles empty database

### Unit Tests - Import Service
- [ ] Test import from JSON creates tasks correctly
- [ ] Test import recreates all relationships
- [ ] Test import handles missing projects (creates new)
- [ ] Test import handles duplicate tasks (skips or merges)
- [ ] Test import validation catches invalid JSON
- [ ] Test import rollback on error
- [ ] Test merge mode preserves existing data
- [ ] Test replace mode clears existing data

### Unit Tests - Backup Service
- [ ] Test backup creates file in correct location
- [ ] Test backup filename includes timestamp
- [ ] Test listing backups returns correct list
- [ ] Test restore from backup recreates all data
- [ ] Test automatic backup runs on schedule
- [ ] Test old backups are deleted (keep last N)

### Unit Tests - Data Integrity
- [ ] Test integrity check finds orphaned subtasks
- [ ] Test integrity check finds orphaned reminders
- [ ] Test integrity check finds invalid relationships
- [ ] Test repair fixes orphaned records
- [ ] Test repair fixes invalid relationships
- [ ] Test consistency checks validate sortOrder

### Unit Tests - Data Cleanup
- [ ] Test delete completed tasks older than date
- [ ] Test clear all data removes everything
- [ ] Test archive old tasks changes status to archived
- [ ] Test cleanup confirms count before deleting

### Integration Tests
- [ ] Test export → import round-trip preserves all data
- [ ] Test backup → restore round-trip recreates database
- [ ] Test import merges with existing data correctly
- [ ] Test import replaces all data correctly
- [ ] Test data integrity check finds real issues
- [ ] Test data repair fixes real issues

### UI Tests
- [ ] Test export button shows share sheet
- [ ] Test import button shows file picker
- [ ] Test backup button creates backup file
- [ ] Test restore button restores from backup
- [ ] Test clear data shows confirmations

### Edge Cases
- [ ] Test exporting very large database (10,000+ tasks)
- [ ] Test importing malformed JSON
- [ ] Test importing JSON from older schema version
- [ ] Test importing JSON with circular references (shouldn't exist)
- [ ] Test backup when storage is full
- [ ] Test restore when backup file is corrupted
- [ ] Test concurrent export/import (should be prevented)

---

## Acceptance Criteria

- ✅ Users can export all data to JSON format
- ✅ Users can export tasks to CSV format
- ✅ Users can import data from JSON
- ✅ Import handles duplicates gracefully
- ✅ Users can create manual backups
- ✅ Automatic backups can be configured
- ✅ Users can restore from any backup
- ✅ Data integrity checks find and fix issues
- ✅ Users can cleanup old completed tasks
- ✅ Export/import preserves all data and relationships
- ✅ All operations have proper error handling
- ✅ All tests pass with >75% coverage

---

## Notes

- Export should be human-readable JSON for transparency
- Include schema version in exported JSON for future compatibility
- CSV export is for basic use cases (spreadsheet analysis)
- Import should never overwrite without explicit user confirmation
- Backup files should be compressed to save space
- Consider encrypting backup files (future enhancement)
- Backups should be stored in app's documents directory for iCloud sync
- Consider iCloud Drive integration for cross-device backups
- Migration service is critical for app updates - test thoroughly
- Data integrity checks should run periodically in background
- Consider adding "export to Todoist format" for migration from competitors
- Import preview helps users understand what will happen
- Undo import is important safety feature (keep temporary backup during import)
- Clear data needs multiple confirmations - this is destructive
- Consider GDPR compliance if app goes public (data export is required)

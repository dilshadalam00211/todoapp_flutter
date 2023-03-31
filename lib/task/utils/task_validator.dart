class TaskValidator {
  bool isValidTaskName(String? input) {
    return input?.isNotEmpty ?? false;
  }

  /// Check if Description is valid or not
  bool isValidDescription(String? input) {
    return isValidTaskName(input);
  }

  /// Check if dueDate is valid or not
  bool isValidTaskDueDate(DateTime? input) {
    return input != null;
  }
}

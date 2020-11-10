import 'package:bounty_hub_client/data/enums/user_task_status.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';

int calculateLeftBudgetPercentage(Task task) {
  return (checkNullDouble(task.leftBudget) * 100) ~/ checkNullDouble(task.budget);
}

int getTaskCompletionStepByStatus(UserTaskStatusType status, int approveDate, int confirmationDaysCount) {
  switch(status) {
    case UserTaskStatusType.IN_PROGRESS:
      return 1;
    case UserTaskStatusType.VERIFYING:
      return 2;
    case UserTaskStatusType.REJECTED:
      return 3;
    case UserTaskStatusType.APPROVED:
      return checkIfTaskReadyToReconfirm(approveDate, confirmationDaysCount) ? 4 : 3;
    case UserTaskStatusType.PAID:
    case UserTaskStatusType.CANCELED:
      return 5;
    default:
      return 1;
  }
}

bool checkIfTaskReadyToReconfirm(int approveDate, int confirmationDaysCount) {
  var now = DateTime.now();
  var duration = Duration(days : confirmationDaysCount);
  var approveDateTime = DateTime.fromMillisecondsSinceEpoch(approveDate);
  approveDateTime = approveDateTime.add(duration);
  return now.isAfter(approveDateTime);
}

int getTaskVerificationTime(int confirmationDaysCount, int approveDate) {
  if(approveDate == null) return 0;
  var duration = Duration(days : confirmationDaysCount);
  var approveDateTime = DateTime.fromMillisecondsSinceEpoch(approveDate);
  approveDateTime = approveDateTime.add(duration);
  return approveDateTime.millisecondsSinceEpoch + 1000 * 60;
}

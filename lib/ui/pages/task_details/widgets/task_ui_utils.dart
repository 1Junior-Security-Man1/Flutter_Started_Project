import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';

int calculateLeftBudgetPercentage(Task task) {
  return (checkNullDouble(task.leftBudget) * 100) ~/ checkNullDouble(task.budget);
}
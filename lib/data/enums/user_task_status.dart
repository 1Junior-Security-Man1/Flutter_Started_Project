
enum UserTaskStatusType {
  IN_PROGRESS,
  VERIFYING,
  APPROVED,
  REJECTED,
  PAID,
  CANCELED,
}

const userTaskStatusTypeEnumMap = {
  UserTaskStatusType.IN_PROGRESS: 'IN_PROGRESS',
  UserTaskStatusType.VERIFYING: 'VERIFYING',
  UserTaskStatusType.APPROVED: 'APPROVED',
  UserTaskStatusType.REJECTED: 'REJECTED',
  UserTaskStatusType.PAID: 'PAID',
  UserTaskStatusType.CANCELED: 'CANCELED',
};
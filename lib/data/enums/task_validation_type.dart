/// Types of Bountyhub tasks validators. Depending on them, the user has a different flows for executing and confirming tasks on client side
enum TaskValidationType {
  SOCIAL_PARSER,
  AUTO_CHECK,
}

const socialStatusTypeEnumMap = {
  TaskValidationType.SOCIAL_PARSER: 'SOCIAL_PARSER',
  TaskValidationType.AUTO_CHECK: 'AUTO_CHECK',
};



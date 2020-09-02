///
/// Members API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/group_member_procedures.html
///
/// [MembersProcedures] enum of all the used API methods
/// [membersCommands] map from [MembersProcedures] -> actual api command
///
/// From a logical standpoint, these procedures will not get their own
/// repository class, rather they will be included in the [GroupRepository] and
/// [UserRepository]
///
enum MembersProcedures {
  getGroups,
  getMembers,
  addToGroup,
  removeFromGroup,
  isInGroup,
}

const Map<MembersProcedures, String> membersCommands = {
  MembersProcedures.getGroups: 'getMemberGroups', // UserRepository
  MembersProcedures.getMembers: 'getGroupMembers', // GroupRepository
  MembersProcedures.addToGroup: 'addGroupMember', // GroupRepository
  MembersProcedures.removeFromGroup: 'removeGroupMember', // GroupRepository
  MembersProcedures.isInGroup: 'isGroupMember', // GroupRepository
};

import 'package:notify/features/group/domin/usecases/add_supervisor.dart';
import 'package:notify/features/group/domin/usecases/create_group.dart';
import 'package:notify/features/group/domin/usecases/join_group.dart';
import 'package:notify/features/group/domin/usecases/leave_group.dart';

abstract class GroupRemoteDataSource {
  // Group monopilation
  Future<void> createGroup(CreateGroupParams params);
  Future<void> leaveGroup(LeaveGroupParams params);
  Future<void> joinGroup(JoinGroupParams params);
  Future<void> addSupervisorGroup(AddSupervisorParams params);
}
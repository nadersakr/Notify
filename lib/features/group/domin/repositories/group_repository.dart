import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/group/domin/usecases/add_supervisor.dart';
import 'package:notify/features/group/domin/usecases/create_group.dart';
import 'package:notify/features/group/domin/usecases/join_group.dart';
import 'package:notify/features/group/domin/usecases/leave_group.dart';

abstract class GroupRepository {
  Future<Either<Failure,void>> createGroup(CreateGroupParams params);
  Future<Either<Failure,void>> leaveGroup(LeaveGroupParams params);
  Future<Either<Failure,void>> joinGroup(JoinGroupParams params);
  Future<Either<Failure,void>> addSupervisor(AddSupervisorParams params);
}

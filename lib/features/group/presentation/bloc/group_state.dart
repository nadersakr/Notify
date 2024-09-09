part of 'group_bloc.dart';

sealed class GroupState extends Equatable {
  const GroupState();
  
  @override
  List<Object> get props => [];
}

final class GroupInitial extends GroupState {}

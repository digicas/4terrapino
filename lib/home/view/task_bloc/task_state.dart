part of 'task_bloc.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({int? level}) = _TaskState;

  factory TaskState.initial() => const TaskState();
}

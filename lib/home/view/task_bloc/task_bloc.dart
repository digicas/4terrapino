// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_event.dart';
part 'task_state.dart';
part 'task_bloc.freezed.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<_ResetTaskEvent>(_mapResetToState);
  }
  Future<void> _mapResetToState(
    _ResetTaskEvent event,
    Emitter<TaskState> emit,
  ) async {}
}

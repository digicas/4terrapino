// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:js';

import 'package:terrapino/models/activity_event/activity_event.dart';
import 'package:terrapino/models/enums/index.dart';

void handleOnLevelStartedEvent(TaskType type, int level) {
  log('Level started event');

  ActivityEvent(
    event: EventType.levelStarted,
    type: type,
    levelNumber: level,
  ).onEvent();
}

void handleOnLevelFinishedEvent(TaskType type, int level, int duration) {
  log('Level finished event');

  ActivityEvent(
    event: EventType.levelFinished,
    type: type,
    levelNumber: level,
    duration: duration,
    tries: 0,
  ).onEvent();
}

void simulateOnBackPressed() {
  log('On back pressed');
  context.callMethod('onBackPressed');
}

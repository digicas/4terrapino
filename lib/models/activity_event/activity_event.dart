// ignore: lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs, sort_constructors_first, no_default_cases, avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:js';

import 'package:terrapino/models/enums/index.dart';

class ActivityEvent {
  ActivityEvent({
    required this.event,
    required this.type,
    required this.levelNumber,
    this.duration,
    this.tries,
  });

  final EventType event;
  final TaskType type;

  final int? levelNumber;
  final int? duration;
  final int? tries;

  factory ActivityEvent.fromMap(Map<String, dynamic> map) {
    return ActivityEvent(
      event: EventType.fromString(map['event'] as String),
      type: TaskType.fromString(map['type'] as String),
      levelNumber:
          map['levelNumber'] != null ? map['levelNumber'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      tries: map['tries'] != null ? map['tries'] as int : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event.toString(),
      'type': type.toString(),
      if (levelNumber != null) 'levelNumber': levelNumber,
      if (event == EventType.levelFinished) 'duration': duration,
      if (event == EventType.levelFinished) 'tries': tries,
    };
  }

  factory ActivityEvent.fromJson(String source) =>
      ActivityEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  void onEvent() {
    context.callMethod('onEvent', [toJson()]);
  }
}

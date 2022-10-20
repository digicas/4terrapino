// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActivityEvent {
  ActivityEvent({
    required this.event,
    required this.type,
    required this.levelNumber,
    this.seconds,
    this.tries,
  });
  final ActivityEventType event;
  final TaskType type;

  final int levelNumber;
  final int? seconds;
  final int? tries;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event.toString(),
      'type': type.toString(),
      'levelNumber': levelNumber,
      'seconds': seconds,
      'tries': tries,
    };
  }

  factory ActivityEvent.fromMap(Map<String, dynamic> map) {
    return ActivityEvent(
      event: ActivityEventType.fromString(map['event'] as String),
      type: TaskType.fromString(map['type'] as String),
      levelNumber: map['levelNumber'] as int,
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
      tries: map['tries'] != null ? map['tries'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityEvent.fromJson(String source) =>
      ActivityEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ActivityEventType {
  levelStarted('levelStarted'),
  levelFinished('levelFinished');

  final String eventType;
  const ActivityEventType(this.eventType);

  factory ActivityEventType.fromString(String eventType) {
    return values.firstWhere((e) => e.eventType == eventType);
  }
}

enum TaskType {
  funnel('funnel'),
  pyramid('pyramid'),
  wordle('wordle');

  const TaskType(this.type);
  factory TaskType.fromString(String type) {
    return values.firstWhere((e) => e.type == type);
  }
  final String type;
}

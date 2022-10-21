enum EventType {
  levelStarted('levelStarted'),
  levelFinished('levelFinished');

  const EventType(this.eventType);

  factory EventType.fromString(String eventType) {
    return values.firstWhere((e) => e.eventType == eventType);
  }

  final String eventType;
  @override
  String toString() {
    switch (this) {
      case EventType.levelFinished:
        return 'levelFinished';
      // ignore: no_default_cases
      default:
        return 'levelStarted';
    }
  }
}

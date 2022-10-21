enum TaskType {
  funnel('funnel'),
  pyramid('pyramid'),
  wordle('wordle'),
  undefined('undefined');

  const TaskType(this.type);
  factory TaskType.fromString(String type) {
    return values.firstWhere(
      (e) => e.type == type,
      orElse: () => TaskType.undefined,
    );
  }
  final String type;

  @override
  String toString() {
    switch (this) {
      case TaskType.wordle:
        return 'wordle';
      case TaskType.pyramid:
        return 'pyramid';
      // ignore: no_default_cases
      default:
        return 'funnel';
    }
  }
}

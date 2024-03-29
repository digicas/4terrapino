import 'package:flutter/material.dart';
import 'package:flutter_cognitive_training_screens/models/level_type.dart';
import 'package:flutter_cognitive_training_screens/task_screen.dart';
import 'package:levels_dart_pyramid_funnels/models/level_tree/level_tree.dart';
import 'package:terrapino/models/enums/index.dart';
import 'package:terrapino/models/uri_result.dart';
import 'package:terrapino/utils/handle_events.dart';

class FunnelsPage extends StatelessWidget {
  const FunnelsPage({super.key, required this.uriResult});

  final UriResultFunnels uriResult;

  @override
  Widget build(BuildContext context) {
    handleOnLevelStartedEvent(
      TaskType.fromString(uriResult.type),
      uriResult.level,
    );
    final stopwatch = Stopwatch()..start();
    return TaskScreen(
      lang: uriResult.lang,
      backOptionText:
          uriResult.lang == 'cs' ? 'UKONČIT CVIČENÍ' : 'END EXERCISE',
      onBackOption: () {
        handleOnBackPressed();
        Navigator.of(context).popAndPushNamed('/end');
      },
      onLevelFinished: (type, level) {
        stopwatch.stop();
        handleOnLevelFinishedEvent(
          TaskType.fromString(uriResult.type),
          level,
          stopwatch.elapsedMilliseconds ~/ 1000,
          null,
        );
      },
      onLevelChanged: (type, level) {
        handleOnLevelStartedEvent(TaskType.fromString(uriResult.type), level);
        stopwatch
          ..reset()
          ..start();
      },
      level: LevelTree.getLevelByLevelIndex(uriResult.level)!,
      taskType: uriResult.type == 'funnel'
          ? TriangleLevelType.funnel
          : TriangleLevelType.pyramid,
    );
  }
}

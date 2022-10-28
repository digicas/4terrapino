import 'package:flutter/material.dart';
import 'package:flutter_cognitive_training_screens/models/level_type.dart';
import 'package:flutter_cognitive_training_screens/task_screen.dart';
import 'package:levels_dart_pyramid_funnels/models/level_tree/level_tree.dart';
import 'package:terrapino/models/enums/index.dart';
import 'package:terrapino/models/uri_result.dart';
import 'package:terrapino/utils/handle_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.uriResult});

  final UriResult uriResult;

  @override
  Widget build(BuildContext context) {
    handleOnLevelStartedEvent(
      TaskType.fromString(uriResult.type),
      uriResult.level,
    );
    final stopwatch = Stopwatch()..start();
    return TaskScreen(
      onLevelFinished: (type, level) {
        stopwatch.stop();
        handleOnLevelFinishedEvent(
          TaskType.fromString(type.toString()),
          level,
          stopwatch.elapsedMilliseconds ~/ 1000,
        );
      },
      level: LevelTree.getLevelByLevelIndex(uriResult.level)!,
      taskType: uriResult.type == 'funnel'
          ? TriangleLevelType.funnel
          : TriangleLevelType.pyramid,
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({required this.uriResult, super.key});

  final UriResult uriResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Text(
                'type: ${uriResult.type}',
              ),
              const SizedBox(height: 8),
              Text(
                'level: ${uriResult.level}',
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EventButton(
                    title: 'Simulate Level Started',
                    onPressed: () => handleOnLevelStartedEvent(
                      TaskType.fromString(uriResult.type),
                      uriResult.level,
                    ),
                  ),
                  const SizedBox(width: 32),
                  // EventButton(
                  //   title: 'Simulate Level Finished',
                  //   // onPressed: () => handleOnLevelFinishedEvent(
                  //   //   TaskType.fromString(uriResult.type),
                  //   //   uriResult.level,
                  //   // ),
                  // ),
                  const SizedBox(width: 32),
                  const EventButton(
                    title: 'Simulate on back pressed',
                    onPressed: simulateOnBackPressed,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventButton extends StatelessWidget {
  const EventButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}

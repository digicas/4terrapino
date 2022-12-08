import 'package:flutter/material.dart';
import 'package:terrapino/models/enums/index.dart';
import 'package:terrapino/models/uri_result.dart';
import 'package:terrapino/utils/handle_events.dart';
import 'package:wordle/wordle.dart';

class WordlePage extends StatelessWidget {
  const WordlePage({super.key, required this.uriResult});

  final UriResultWordle uriResult;

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();
    return WordleGame(
      menuImage: Image.asset('assets/ada_head_only.png',height: 32),
      langs: uriResult.langs,
      onLevelStarted: () {
        handleOnLevelStartedEvent(TaskType.fromString(uriResult.type), null);
        stopwatch
          ..reset()
          ..start();
      },
      onFinished: (tries) {
        stopwatch.stop();
        handleOnLevelFinishedEvent(
          TaskType.fromString(
            uriResult.type,
          ),
          null,
          stopwatch.elapsedMilliseconds ~/ 1000,
          tries,
        );
      },
    );
  }
}

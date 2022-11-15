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
    handleOnLevelStartedEvent(TaskType.fromString(uriResult.type), null);
    return WordleGame(
      langs: uriResult.langs,
    );
  }
}

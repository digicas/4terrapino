// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrapino/home/home.dart';
import 'package:terrapino/models/activity_event/activity_event.dart';
import 'package:terrapino/models/enums/index.dart';
import 'package:terrapino/models/uri_result.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.uriResult});

  final UriResult uriResult;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(initialState: uriResult),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _handleOnLevelStartedEvent(TaskType type, int level) {
    log('Level started event');

    ActivityEvent(
      event: EventType.levelStarted,
      type: type,
      levelNumber: level,
    ).onEvent();
  }

  void _handleOnLevelFinishedEvent(TaskType type, int level) {
    log('Level finished event');

    ActivityEvent(
      event: EventType.levelFinished,
      type: type,
      levelNumber: level,
      seconds: 9200,
      tries: 3,
    ).onEvent();
  }

  void _simulateOnBackPressed() {
    log('On back pressed');
    context.callMethod('onBackPressed');
  }

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
                context.select(
                  (HomeCubit cubit) => 'type: ${cubit.state.type}',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.select(
                  (HomeCubit cubit) => 'level: ${cubit.state.level}',
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<HomeCubit, UriResult>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EventButton(
                        title: 'Simulate Level Started',
                        onPressed: () => _handleOnLevelStartedEvent(
                          TaskType.fromString(state.type),
                          state.level,
                        ),
                      ),
                      const SizedBox(width: 32),
                      EventButton(
                        title: 'Simulate Level Finished',
                        onPressed: () => _handleOnLevelFinishedEvent(
                          TaskType.fromString(state.type),
                          state.level,
                        ),
                      ),
                      const SizedBox(width: 32),
                      EventButton(
                        title: 'Simulate on back pressed',
                        onPressed: _simulateOnBackPressed,
                      )
                    ],
                  );
                },
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

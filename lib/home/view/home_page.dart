// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrapino/home/home.dart';
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
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final l10n = context.l10n;
  //   return Scaffold(
  //     appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
  //     body: const Center(child: HomeText()),
  //     floatingActionButton: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         FloatingActionButton(
  //           onPressed: () => context.read<HomeCubit>().increment(),
  //           child: const Icon(Icons.add),
  //         ),
  //         const SizedBox(height: 8),
  //         FloatingActionButton(
  //           onPressed: () => context.read<HomeCubit>().decrement(),
  //           child: const Icon(Icons.remove),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class HomeText extends StatelessWidget {
  const HomeText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((HomeCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}

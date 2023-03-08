// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:terrapino/app/practice_end/practice_end.dart';
import 'package:terrapino/funnels/funnels.dart';
import 'package:terrapino/models/parse_error.dart';
import 'package:terrapino/models/uri_result.dart';
import 'package:terrapino/utils/uri_parser.dart';
import 'package:terrapino/wordle/view/wordle_page.dart';

class App extends StatelessWidget {
  App({
    super.key,
  }) {
    uriResult = parseUri();
  }

  late final Either<ParseError, UriResult> uriResult;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.blue),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      home: uriResult.fold(
        (l) => Text('${l.code} ${l.message}'),
        (r) => r is UriResultFunnels
            ? FunnelsPage(
                uriResult: r,
              )
            : r is UriResultWordle
                ? WordlePage(
                    uriResult: r,
                  )
                : Container(),
      ),
      routes: {
        '/end': (context) => const PracticeEndPage(),
      },
    );
  }
}

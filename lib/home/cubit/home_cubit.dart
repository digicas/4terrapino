// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:terrapino/models/uri_result.dart';

class HomeCubit extends Cubit<UriResult> {
  HomeCubit({required this.initialState}) : super(initialState);

  final UriResult initialState;

  // void increment() => emit(state + 1);
  // void decrement() => emit(state - 1);
}

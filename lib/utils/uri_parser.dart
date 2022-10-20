import 'package:dartz/dartz.dart';
import 'package:terrapino/models/parse_error.dart';
import 'package:terrapino/models/uri_result.dart';

Either<ParseError, UriResult> parseUri() {
  final type = Uri.base.queryParameters['type'];
  final levelParam = Uri.base.queryParameters['level'];

  if (type == null) {
    return left(
      ParseError(
        code: 400,
        message: 'Parameter [type] is required',
      )..onError(),
    );
  }

  if (levelParam == null) {
    return left(
      ParseError(
        code: 400,
        message: 'Parameter [level] is required',
      )..onError(),
    );
  }

  final level = int.tryParse(levelParam);

  if (level == null) {
    return left(
      ParseError(
        code: 400,
        message: 'Invalid argument for parameter [level]',
      )..onError(),
    );
  }

  return right(UriResult(type: type, level: level));
}

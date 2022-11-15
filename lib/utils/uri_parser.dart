import 'package:dartz/dartz.dart';
import 'package:terrapino/models/enums/task_type.dart';
import 'package:terrapino/models/parse_error.dart';
import 'package:terrapino/models/uri_result.dart';

Either<ParseError, UriResult> parseUri() {
  final typeString = Uri.base.queryParameters['type'];
  final levelParam = Uri.base.queryParameters['level'];
  final langsString = Uri.base.queryParameters['langs'];

  if (typeString == null) {
    return left(
      ParseError(
        code: 400,
        message: 'Parameter [type] is required',
      )..onError(),
    );
  }

  final type = TaskType.fromString(typeString);

  if (type == TaskType.undefined) {
    return left(
      ParseError(
        code: 404,
        message: 'Requested task type is not implemented yet',
      )..onError(),
    );
  }

  if (type == TaskType.funnel || type == TaskType.pyramid) {
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

    return right(UriResultFunnels(type: typeString, level: level));
  }

  if (type == TaskType.wordle) {
    if (langsString == null) {
      return left(
        ParseError(
          code: 404,
          message: 'Parameter [langs] is required with type [$typeString]',
        )..onError(),
      );
    }

    final activeLangs = langsString.split(',');

    for (final lang in activeLangs) {
      if (lang != 'en' && lang != 'cs' && lang != 'de') {
        return left(
          ParseError(
            code: 404,
            message:
                'Unsupported language [$lang] passed as a parameter for [langs]',
          ),
        );
      }
    }

    return right(
      UriResultWordle(type: typeString, langs: activeLangs),
    );
  }
  return left(
    ParseError(code: 400, message: 'Something went wrong')..onError(),
  );
}

import 'package:dartz/dartz.dart';
import 'package:terrapino/models/enums/task_type.dart';
import 'package:terrapino/models/parse_error.dart';
import 'package:terrapino/models/uri_result.dart';

Either<ParseError, UriResult> parseUri() {
  final typeString = Uri.base.queryParameters['type'];
  final levelParam = Uri.base.queryParameters['level'];
  final langsString = Uri.base.queryParameters['langs'];
  final hintsString = Uri.base.queryParameters['hints'];
  final translateString = Uri.base.queryParameters['translate'];

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

    var langCode = 'cs';

    if (!(langsString == null)) {
      langCode = langsString.split(',').first;
    }

    return right(
      UriResultFunnels(type: typeString, level: level, lang: langCode),
    );
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
    final hints = <String>[];

    if (hintsString != null) {
      hints.addAll(hintsString.split(','));
    }

    for (final lang in activeLangs) {
      if (lang != 'en' && lang != 'cs' && lang != 'de') {
        return left(
          ParseError(
            code: 404,
            message:
                '''Unsupported language [$lang] passed as a parameter for [langs]''',
          ),
        );
      }
    }

    for (final lang in hints) {
      if (lang != 'en' && lang != 'cs' && lang != 'de') {
        return left(
          ParseError(
            code: 404,
            message:
                '''Unsupported language [$lang] passed as a parameter for [hints]''',
          ),
        );
      }
    }

    var translate = false;
    if (translateString == 'true') translate = true;

    return right(
      UriResultWordle(
        type: typeString,
        langs: activeLangs,
        hints: hints,
        translate: translate,
      ),
    );
  }
  return left(
    ParseError(code: 400, message: 'Something went wrong')..onError(),
  );
}

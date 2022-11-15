class UriResult {
  UriResult({
    required this.type,
  });
  final String type;
}

class UriResultFunnels extends UriResult {
  UriResultFunnels({
    required super.type,
    required this.level,
  });

  final int level;
}

class UriResultWordle extends UriResult {
  UriResultWordle({
    required super.type,
    required this.langs,
  });

  final List<String> langs;
}

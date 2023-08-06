String generateRoutesClass(Map<String, dynamic> routesMap) {
  final buffer = StringBuffer();
  buffer.writeln('part of "./app_pages.dart";');
  buffer.writeln('abstract class Routes {');

  for (final entry in routesMap.entries) {
    final key = entry.key;
    final value = entry.value;
    buffer.writeln('  static const $key = "$value";');
  }

  buffer.writeln('}');

  return buffer.toString();
}

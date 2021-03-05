import 'package:recase/recase.dart';

String entityTemplate(String entityName) {
  var output = '''
class ${ReCase(entityName).pascalCase}Entity {
  final String id;
  final String userName;

  ${ReCase(entityName).pascalCase}Entity({required this.id, required this.userName});
}
  ''';

  return output;
}

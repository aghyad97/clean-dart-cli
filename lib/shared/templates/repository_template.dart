import 'package:recase/recase.dart';

String domainRepositoryTemplate(String repositoryName) {
  var output = '''
abstract class ${ReCase(repositoryName).pascalCase}Repository {
  
}
  ''';

  return output;
}

String dataRepositoryTemplate(String repositoryName, String packageName) {
  var output = '''
import 'package:$packageName/domain/repositories/${ReCase(repositoryName).snakeCase}_repository.dart';

class ${ReCase(repositoryName).pascalCase}RepositoryImpl extends ${ReCase(repositoryName).pascalCase}Repository {

}

  ''';

  return output;
}

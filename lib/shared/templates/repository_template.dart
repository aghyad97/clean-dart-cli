
import 'package:recase/recase.dart';

String domainRepositoryTemplate(String repositoryName) {
  var output = '''
abstract class ${ReCase(repositoryName).pascalCase}Repository {
  
}
  ''';

  return output;
}

String dataRepositoryTemplate(String repositoryName) {
  var output = '''
class ${ReCase(repositoryName).pascalCase}RepositoryImpl extends ${ReCase(repositoryName).pascalCase}Repository {


 
}

  ''';

  return output;
}

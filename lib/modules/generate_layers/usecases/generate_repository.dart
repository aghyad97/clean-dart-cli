import 'dart:io';

import 'package:clean_dart_cli/shared/errors/file_exists_error.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_repository.dart';
import 'package:clean_dart_cli/shared/templates/repository_template.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as p;

class GenerateRepository implements IGenerateRepository {
  @override
  Future<bool> call(
      String repositoryName, String domainPath, String dataPath) async {
    var isDomainValidDirectory = await Directory(domainPath).exists();
    var isDataValidDirectory = await Directory(dataPath).exists();

    var dataFileExist = await File(
            '$domainPath/${ReCase(repositoryName).snakeCase}_repository.dart')
        .exists();

    var domainFileExist = await File(
            '$dataPath/${ReCase(repositoryName).snakeCase}_repository.dart')
        .exists();

    if (dataFileExist || domainFileExist) {
      throw FileExistsError(innerException: Exception());
    }
    final packageName = ReCase(p.current.split('/').last).snakeCase;

    if (isDomainValidDirectory && isDataValidDirectory) {
      File('$domainPath/${ReCase(repositoryName).snakeCase}_repository.dart')
          .createSync(recursive: true);
      var domainContent = domainRepositoryTemplate(repositoryName);
      File('$domainPath/${ReCase(repositoryName).snakeCase}_repository.dart')
          .writeAsStringSync(domainContent);
      File('$dataPath/${ReCase(repositoryName).snakeCase}_repository.dart')
          .createSync(recursive: true);
      var dataContent = dataRepositoryTemplate(repositoryName, packageName);
      File('$dataPath/${ReCase(repositoryName).snakeCase}_repository.dart')
          .writeAsStringSync(dataContent);
      return true;
    } else {
      return false;
    }
  }
}

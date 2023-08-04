import 'package:clean_dart_cli/shared/errors/file_exists_error.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_entity.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_error.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_model.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_model_js.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_presentation.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_repository.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_usecases.dart';
import 'package:clean_dart_cli/shared/utils/output_utils.dart' as output;
import 'package:path/path.dart' as p;

class GenerateDomainController {
  final IGenerateUsecases _generateUsecases;
  final IGenerateEntity _generateEntity;
  final IGenerateModel _generateModel;
  final IGenerateError _generateError;
  final IGenerateModelJs _generateModelJs;
  final IGenerateRepository _generateRepository;
  final IGeneratePresentation _generatePresentation;

  GenerateDomainController(
    this._generateUsecases,
    this._generateEntity,
    this._generateModel,
    this._generateError,
    this._generateModelJs,
    this._generateRepository,
    this._generatePresentation,
  );

  Future<bool> generateUsecase(String usecaseName, String path) async {
    output.warn('generating usecase $usecaseName....');
    var pathNomalized = p.normalize('${p.current}/$path');

    try {
      var result = await _generateUsecases.call(usecaseName, pathNomalized);

      if (result) {
        output.title('$usecaseName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateEntity(String entityName, String path) async {
    output.warn('generating usecase $entityName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateEntity.call(entityName, pathNomalized);
      if (result) {
        output.title('$entityName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateModel(String modelName, String path) async {
    output.warn('generating model $modelName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateModel.call(modelName, pathNomalized);
      if (result) {
        output.title('$modelName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateModelJs(String modelName, String path) async {
    output.warn('generating model $modelName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateModelJs.call(modelName, pathNomalized);
      if (result) {
        output.title('$modelName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateRepository(
      String repositoryName, String domainPath, String dataPath) async {
    output.warn('generating repoistory $repositoryName....');
    var domainPathNomalized = p.normalize('${p.current}/$domainPath');
    var dataPathNomalized = p.normalize('${p.current}/$dataPath');
    try {
      var result = await _generateRepository.call(
          repositoryName, domainPathNomalized, dataPathNomalized);
      if (result) {
        output.title('$repositoryName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generatePresentation(
      String presentationName, String path) async {
    output.warn('generating presentation $presentationName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result =
          await _generatePresentation.call(presentationName, pathNomalized);
      if (result) {
        output.title('$presentationName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateError(String errorName, String path) async {
    output.warn('generating error $errorName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateError.call(errorName, pathNomalized);
      if (result) {
        output.title('$errorName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }
}

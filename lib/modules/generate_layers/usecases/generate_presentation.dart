import 'dart:convert';
import 'dart:io';

import 'package:clean_dart_cli/shared/errors/file_exists_error.dart';
import 'package:clean_dart_cli/shared/interfaces/igenerate_presentation.dart';
import 'package:clean_dart_cli/shared/templates/presentation_template.dart';
import 'package:clean_dart_cli/shared/templates/routes_template.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as p;

class GeneratePresentation implements IGeneratePresentation {
  @override
  Future<bool> call(String presentationName, String path,
      String routesJsonFilePath, String routesDartFilePath) async {
    var isValidDirectory = await Directory(path).exists();

    bool bindingFileExists =
        await File('$path/${ReCase(presentationName).snakeCase}_binding.dart')
            .exists();
    bool controllerFileExists = await File(
            '$path/${ReCase(presentationName).snakeCase}_controller.dart')
        .exists();
    bool pageFileExists =
        await File('$path/${ReCase(presentationName).snakeCase}_page.dart')
            .exists();
    bool screenFileExists =
        await File('$path/${ReCase(presentationName).snakeCase}_screen.dart')
            .exists();

    if (bindingFileExists ||
        controllerFileExists ||
        pageFileExists ||
        screenFileExists) {
      throw FileExistsError(innerException: Exception());
    }
    final packageName = ReCase(p.current.split('/').last).snakeCase;

    if (isValidDirectory) {
      // Generate Binding
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_binding.dart')
          .createSync(recursive: true);
      var bindingContent = bindingTemplate(presentationName);
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_binding.dart')
          .writeAsStringSync(bindingContent);

      // Generate Controller
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_controller.dart')
          .createSync(recursive: true);
      var controllerContent = controllerTemplate(presentationName, packageName);
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_controller.dart')
          .writeAsStringSync(controllerContent);

      // Generate Page
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_page.dart')
          .createSync(recursive: true);
      var pageContent = pageTemplate(presentationName, packageName);
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_page.dart')
          .writeAsStringSync(pageContent);

      // Generate Screen
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_screen.dart')
          .createSync(recursive: true);
      var screenContent = screenTemplate(presentationName, packageName);
      File('$path/${presentationName}/${ReCase(presentationName).snakeCase}_screen.dart')
          .writeAsStringSync(screenContent);

      final jsonFile = File(routesJsonFilePath);
      final dartFile = File(routesDartFilePath);
      final jsonString = jsonFile.readAsStringSync();

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      jsonMap[presentationName] = '/${presentationName}';
      final classString = generateRoutesClass(jsonMap);

      dartFile.writeAsStringSync(classString);
      jsonFile.writeAsStringSync(json.encode(jsonMap));
      print(classString);
      return true;
    } else {
      return false;
    }
  }
}

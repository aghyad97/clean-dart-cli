import 'package:clean_dart_cli/modules/app_module.dart';
import 'package:clean_dart_cli/modules/common_commands/controllers/common_commands_controller.dart';
import 'package:clean_dart_cli/modules/generate_layers/controllers/generate_layer_controller.dart';
import 'package:clean_dart_cli/modules/generate_layers/controllers/generate_domain_controller.dart';
import 'package:clean_dart_cli/shared/utils/output_utils.dart' as output;

AppModule appModule;

// List<String> arguments = ['upgrade'];

void main(List<String> arguments) {
  _wellcomeMessage();
  appModule = AppModule();
  var generateLayerController =
      appModule.generate.getIt<GenerateLayerController>();
  var generateUsecaseController =
      appModule.generate.getIt<GenerateDomainController>();
  var commomCommandsController =
      appModule.commandsModule.getIt<CommomCommandsController>();

  var isValidArguments = _validateArguments(arguments);

  if (isValidArguments != null) {
    switch (isValidArguments) {
      case 'version':
        commomCommandsController.getVersionCli();
        break;
      default:
    }

    switch (arguments[0]) {
      case 'upgrade':
        commomCommandsController.upgradeCli();
        break;
      default:
    }
    return;
  }

  if (isValidArguments != null) {
    switch (arguments[1]) {
      case 'layer':
        if (arguments.length > 2) {
          generateLayerController.generateLayerFolders(
            layeCommand: arguments[2],
            path: arguments.length == 4 ? arguments[3] : './',
          );
        } else {
          output.error('Invalid command, try with --help or -h');
        }

        break;
      case 'usecase':
        if (arguments.length > 3) {
          generateUsecaseController.generateUsecase(arguments[3], arguments[2]);
        } else {
          output.error('Missing arguments, especific your usecase name');
        }
        break;
      case 'entity':
        if (arguments.length > 3) {
          generateUsecaseController.generateEntity(arguments[3], arguments[2]);
        } else {
          output.error('Missing arguments, especific your entity name');
        }
        break;
      case 'model':
        if (arguments.length > 3) {
          generateUsecaseController.generateModel(arguments[3], arguments[2]);
        } else {
          output.error('Missing arguments, especific your model name');
        }
        break;
      case 'error':
        if (arguments.length > 3) {
          generateUsecaseController.generateError(arguments[3], arguments[2]);
        } else {
          output.error('Missing arguments, especific your error name');
        }
        break;
      case 'modelJs':
        if (arguments.length > 3) {
          generateUsecaseController.generateModelJs(arguments[3], arguments[2]);
        } else {
          output.error('Missing arguments, especific your modelJs name');
        }
        break;
      default:
    }
  }
}

String _validateArguments(List<String> arguments) {
  if (arguments.isEmpty) {
    output.error('No arguments, try with --help or -h');
    return null;
  }

  appModule.argResults = appModule.argParser.parse(arguments);
  // print(appModule.argResults.arguments);
  if (appModule.argResults.arguments[0] == 'upgrade') {
    return arguments[0];
  }

  if (appModule.argResults['version']) {
    return 'version';
  }

  if (appModule.argResults['help']) {
    output.warn(
      '''
-------------------------- HELPS -------------------------- 
${appModule.argParser.usage}
''',
    );
    return null;
  }
  if (arguments.length < 2) {
    output.error('Invalid command, try with --help or -h');
    return null;
  }
  var isValidArguments =
      appModule.argParser.options[arguments[0]].allowed.contains(arguments[1]);

  if (isValidArguments) {
    return arguments[1];
  } else {
    output.error('Invalid command, try with --help or -h');
    return null;
  }
}

void _wellcomeMessage() {
  output.title('################### Clean Dart CLI ###################');
}

import 'package:recase/recase.dart';

String bindingTemplate(String bindingName) {
  var output = '''

import 'package:get/get.dart';

import '${bindingName}_controller.dart';

class ${ReCase(bindingName).pascalCase}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ${ReCase(bindingName).pascalCase}Controller());
  }
}
  ''';

  return output;
}

String controllerTemplate(String controllerName, String packageName) {
  var output = '''

import 'package:${packageName}/core/contracts/controller.dart';
import 'package:get/get.dart';

class ${ReCase(controllerName).pascalCase}Controller extends Controller with GetTickerProviderStateMixin {}

  ''';

  return output;
}

String pageTemplate(String pageName, String packageName) {
  var output = '''

import 'package:${packageName}/core/contracts/page.dart';
import 'package:${packageName}/core/navigation/app_pages.dart';
import 'package:get/get.dart';

import '${pageName}_binding.dart';
import '${pageName}_screen.dart';

class ${ReCase(pageName).pascalCase}Page extends Page {
  ${ReCase(pageName).pascalCase}Page()
      : super(
          coreName: Routes.${pageName},
          screen: ${ReCase(pageName).pascalCase}Screen(),
          coreTransition: Transition.cupertino,
          coreBindings: [${ReCase(pageName).pascalCase}Binding()],
        );
}
  ''';

  return output;
}

String screenTemplate(String screenName, String packageName) {
  var output = '''
import 'package:flutter/material.dart';
import 'package:${packageName}/core/contracts/screen.dart';

import '${screenName}_controller.dart';


class ${ReCase(screenName).pascalCase}Screen extends Screen<${ReCase(screenName).pascalCase}Controller> {
  ${ReCase(screenName).pascalCase}Screen({Key? key}) : super(key: key);

  @override
  Widget? desktop() {
    return super.desktop();
  }

  @override
  Widget? tablet() {
    return super.tablet();
  }

  @override
  Widget? phone() {
    return super.phone();
  }
}

  ''';

  return output;
}

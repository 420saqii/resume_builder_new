

import 'package:get/get.dart';

import '../modules/auth_module/controller/auth_controller.dart';

class GetxBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController(),fenix: true);
  }

}
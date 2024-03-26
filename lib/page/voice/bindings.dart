import 'package:get/get.dart';

import 'controller.dart';

class VoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceController>(() => VoiceController());
  }
}

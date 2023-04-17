import 'package:get/get.dart';
import 'package:valorent_sample/app/data/provider/home_provider.dart';

class GetBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put();
    Get.lazyPut(() => HomeProvider());
  }
}

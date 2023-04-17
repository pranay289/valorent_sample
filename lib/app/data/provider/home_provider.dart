import 'package:get/get.dart';
import 'package:valorent_sample/app/data/models/valorent_agents.dart';
import 'package:valorent_sample/app/data/repository/home_repository.dart';

class HomeProvider extends GetConnect implements HomeRepository {
  ///
  static final HomeProvider instanace = Get.find();

  Rx<ValorentAgents>? valorentAgent;

  ///
  @override
  void onInit() async {
    super.onInit();
    final result = await getValorentAgents();
    valorentAgent = Rx<ValorentAgents>(result);
  }

  RxBool isDataLoading = RxBool(true);

  @override
  Future getValorentWepons() {
    throw UnimplementedError();
  }

  @override
  Future<ValorentAgents> getValorentAgents() async {
    try {
      final result = await get("https://valorant-api.com/v1/agents");
      return ValorentAgents.fromJson(result.body);
    } catch (e) {
      isDataLoading(false);
      rethrow;
    } finally {
      isDataLoading(false);
    }
  }
}

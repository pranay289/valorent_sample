import 'package:valorent_sample/app/data/models/valorent_agents.dart';

abstract class HomeRepository {
  Future<ValorentAgents> getValorentAgents();
  Future<dynamic> getValorentWepons();
}

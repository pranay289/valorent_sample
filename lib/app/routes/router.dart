import 'package:get/get.dart';
import 'package:valorent_sample/app/ui/pages/agent_details_screen.dart';
import 'package:valorent_sample/app/ui/pages/home.dart';

/// To get routes
class GetRoutes {
  static final routes = <GetPage>[
    GetPage(
      name: "/",
      page: () =>  HomeScreen(),
    ),
    // GetPage(name: "/agentDetails", page: () => AgentDetailsPage())
  ];
}

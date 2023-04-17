import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valorent_sample/app/data/provider/home_provider.dart';
import 'package:valorent_sample/app/ui/pages/agent_details_screen.dart';
import 'package:valorent_sample/app/ui/utils/controller_constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Permission _permission = Permission.notification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () {
            if (homeProvider.isDataLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }

            // print(homeProvider.valorentAgent?.value.data?[0].bustPortrait);
            return homeProvider.valorentAgent == null
                ? Container()
                : GridView.extent(
                    maxCrossAxisExtent: 500,
                    children: homeProvider.valorentAgent!.value.data!
                        .map((e) => Container(
                              // color: Colors.red,
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          AgentDetailsPage(
                                        transition: animation,
                                        image: e.bustPortrait,
                                        tag: e.bustPortrait,
                                        backgroundImage: e.background,
                                        description: e.description,
                                        abilities: e.abilities,
                                        agentName: e.displayName,
                                        role: e.role,
                                      ),
                                      transitionDuration:
                                          const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    e.background != null
                                        ? Image.network(
                                            e.background!,
                                            color: Colors.blueAccent.shade100,
                                            opacity:
                                                const AlwaysStoppedAnimation(
                                                    0.7),
                                          )
                                        : Container(),
                                    Container(
                                      child: e.bustPortrait != null
                                          ? CachedNetworkImage(
                                              imageUrl: e.bustPortrait!,
                                            )
                                          : Container(),
                                    ),
                                    if (e.displayName != null &&
                                        e.role != null &&
                                        e.role!.displayName != null)
                                      Positioned(
                                        bottom: 100,
                                        right: 20,
                                        child: Column(
                                          children: [
                                            if (e.role != null &&
                                                e.role!.displayIcon != null)
                                              Image.network(
                                                e.role!.displayIcon!,
                                                height: 50,
                                                width: 50,
                                              ),
                                            const SizedBox(height: 20),
                                            Text(
                                              e.displayName!,
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              e.role!.displayName!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  );
          },
        ));
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

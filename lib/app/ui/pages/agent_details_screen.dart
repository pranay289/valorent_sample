import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valorent_sample/app/data/models/valorent_agents.dart';

class AgentDetailsPage extends StatefulWidget {
  final String? tag;
  final String? image;
  final String? backgroundImage;
  final String? description;
  final List<Ability>? abilities;
  final String? agentName;

  final Animation<double> transition;
  final Role? role;
  const AgentDetailsPage(
      {super.key,
      required this.tag,
      required this.image,
      required this.transition,
      required this.backgroundImage,
      required this.description,
      required this.abilities,
      required this.agentName,
      required this.role});

  @override
  State<AgentDetailsPage> createState() => _AgentDetailsPageState();
}

class _AgentDetailsPageState extends State<AgentDetailsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // print(widget.description);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              widget.backgroundImage ??
                  "https://media.valorant-api.com/agents/dade69b4-4f5a-8528-247b-219e5a1facd6/fullportrait.png",
            ),
            opacity: 0.3,
          ),
        ),
        child: AnimatedBuilder(
          animation: widget.transition,
          builder: (context, w) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0.0),
                          end: const Offset(0, 0.0),
                        ).animate(CurvedAnimation(
                          parent: widget.transition,
                          curve: Curves.easeOut,
                        )),
                        child: CachedNetworkImage(
                            imageUrl: widget.image ??
                                "https://media.valorant-api.com/agents/dade69b4-4f5a-8528-247b-219e5a1facd6/fullportrait.png"),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 50,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: const Offset(0.0, 0.0),
                          ).animate(CurvedAnimation(
                            parent: widget.transition,
                            curve: Curves.easeOut,
                          )),
                          child: Column(
                            children: [
                              if (widget.role != null &&
                                  widget.role!.displayIcon != null)
                                Image.network(
                                  widget.role!.displayIcon!,
                                  height: 50,
                                  width: 50,
                                ),
                              const SizedBox(height: 20),
                              Text(
                                widget.agentName ?? "",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.role!.displayName!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: const Offset(0, 0),
                    ).animate(CurvedAnimation(
                      parent: widget.transition,
                      curve: Curves.easeOut,
                    )),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: widget.abilities!
                              .map((e) => e.displayIcon != null
                                  ? Column(
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 7),
                                            child: CachedNetworkImage(
                                                imageUrl: e.displayIcon!)),
                                        Text(e.displayName!.split("/").first,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12))
                                      ],
                                    )
                                  : Container())
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 120),
                          child: Column(
                            children: [
                              Text(
                                widget.description ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  wordSpacing: 5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                widget.description ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  wordSpacing: 5,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

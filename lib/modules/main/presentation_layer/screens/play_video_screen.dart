import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class PlayVideoScreen extends StatefulWidget {
  final Video video;
  const PlayVideoScreen({Key? key, required this.video}) : super(key: key);
  @override
  State<PlayVideoScreen> createState() =>
      // ignore: no_logic_in_create_state
  _PlayVideoFromVimeoIdState(video: video);
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoScreen> {
  final Video video;
  _PlayVideoFromVimeoIdState({required this.video});
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(video.id.toString()),
      podPlayerConfig: const PodPlayerConfig(
        //videoQualityPriority: [720, 360],
        autoPlay: false,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              PodVideoPlayer(
                controller: controller,
                videoThumbnail: const DecorationImage(
                  image: NetworkImage(
                    "video.thumbnails.mediumResUrl",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

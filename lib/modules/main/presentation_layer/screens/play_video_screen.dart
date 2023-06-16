import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:sizer/sizer.dart';

class PlayVideoScreen extends StatefulWidget {
  final String videoId;
  const PlayVideoScreen({Key? key, required this.videoId}) : super(key: key);
  @override
  State<PlayVideoScreen> createState() =>
      // ignore: no_logic_in_create_state
      _PlayVideoFromVimeoIdState(videoId: videoId);
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoScreen> {
  final String videoId;
  _PlayVideoFromVimeoIdState({required this.videoId});
  late final PodPlayerController controller;
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(videoId),
      podPlayerConfig: const PodPlayerConfig(
        videoQualityPriority: [720, 144],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5.sp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: PodVideoPlayer(
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

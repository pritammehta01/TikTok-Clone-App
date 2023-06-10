import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class TikTokVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const TikTokVideoPlayer({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<TikTokVideoPlayer> createState() => _TikTokVideoPlayerState();
}

class _TikTokVideoPlayerState extends State<TikTokVideoPlayer> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    DefaultCacheManager().getSingleFile(widget.videoUrl).then((file) {
      setState(() {
        videoPlayerController = VideoPlayerController.file(file);
        videoPlayerController!.initialize().then((_) {
          videoPlayerController!.play();
          videoPlayerController!.setLooping(true);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: videoPlayerController != null
          ? VideoPlayer(videoPlayerController!)
          : const Center(
              child: CircularProgressIndicator()), // or a placeholder widget
    );
  }
}

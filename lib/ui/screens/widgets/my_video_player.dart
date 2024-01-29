import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MyVideoPlayer extends StatefulWidget {
  final String movieId;
   MyVideoPlayer({super.key,
    required this.movieId
  });

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  YoutubePlayerController? _controller;
  @override
  void initState(){
    super.initState();
    _controller=YoutubePlayerController(
        initialVideoId: widget.movieId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true
      ),
    );
  }
  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return  _controller==null ?  Center(
      child: SpinKitFadingCircle(
        color:Colors.white,
        size: 20,
      ),
    ):YoutubePlayer(controller: _controller!,onEnded: (YoutubeMetaData meta){
      _controller!.play();
      _controller!.pause();
    },);
  }
}

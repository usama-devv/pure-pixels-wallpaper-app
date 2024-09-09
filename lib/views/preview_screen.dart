import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pure_pixels_wallpaper_app/repo/repository.dart';
import 'package:share_plus/share_plus.dart';

class PreviewScreen extends StatefulWidget {
  final int imageId;
  final String imageUrl;
  const PreviewScreen({
    super.key,
    required this.imageId,
    required this.imageUrl,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Repository repo = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CachedNetworkImage(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        imageUrl: widget.imageUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            onPressed: () {
              repo.downloadImage(
                  imageUrl: widget.imageUrl,
                  imageId: widget.imageId,
                  context: context);
            },
            child: const Icon(Icons.download),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            backgroundColor:
                Colors.blue,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            onPressed: () {
              Share.share(widget.imageUrl, subject: 'Checkout this wallpaper!');
            },
            child: const Icon(Icons.share),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

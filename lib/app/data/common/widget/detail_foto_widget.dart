import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailFotoView extends StatelessWidget {
  const DetailFotoView({super.key, required this.urlImage});
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: urlImage,
          ),
        ),
      ),
    );
  }
}
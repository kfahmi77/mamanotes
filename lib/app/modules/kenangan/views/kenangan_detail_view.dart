import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KenanganDetailView extends StatefulWidget {
  const KenanganDetailView({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<KenanganDetailView> createState() => _KenanganDetailViewState();
}

class _KenanganDetailViewState extends State<KenanganDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'detailKenangan+${widget.imageUrl}}',
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 5.0,
              child: CachedNetworkImage(
                imageUrl:
                    widget.imageUrl, // Ganti dengan URL gambar yang diinginkan
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school/core/const.dart';

class ImageViewer {
  static void show(BuildContext context, String imageUrl) {
    final String base = baseUrl.replaceAll('/api', '');
    final String rawUrl = imageUrl.startsWith('http')
        ? imageUrl
        : '$base${imageUrl.startsWith('/') ? '' : '/'}$imageUrl';

    final String fullUrl = Uri.parse(rawUrl).toString();

    print("🟡 [ImageViewer] Final URL: $fullUrl");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black.withOpacity(0.95),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 5.0,
                boundaryMargin: const EdgeInsets.all(20),
                constrained: false,
                child: CachedNetworkImage(
                  imageUrl: fullUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          color: Colors.white70,
                          size: 60,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'فشل تحميل الصورة',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(ctx),
                  splashRadius: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

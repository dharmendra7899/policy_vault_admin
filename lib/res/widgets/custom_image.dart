import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/constants/assets/const_images.dart';

class ImageLock extends StatelessWidget {
  final String? imageUrl;
  final Color? borderColor, color;
  final double? width, height, radius;
  final BoxFit? fit;
  final bool isLocked;

  const ImageLock({
    super.key,
    this.imageUrl,
    this.width,
    this.isLocked = false,
    this.height,
    this.fit,
    this.radius,
    this.borderColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isLocked || imageUrl == null || imageUrl!.isEmpty) {
      return _buildDefaultImage();
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 0),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: fit ?? BoxFit.cover,
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          ),
          errorWidget: (_, __, ___) => _buildDefaultImage(),
        ),
      ),
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          ConstantImage.appLogo,
          fit: BoxFit.contain,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

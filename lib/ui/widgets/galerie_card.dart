import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notnetflex/services/api.dart';

class GalerieCard extends StatelessWidget {
  final String posterPath;

  const GalerieCard({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: CachedNetworkImage(
          width: 350,
          imageUrl: API().baseImageURL + posterPath,
          fit: BoxFit.cover,
          errorWidget: (Context, url, error) {
            return Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }
}

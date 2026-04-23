import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflex/models/personne.dart';
import 'package:notnetflex/services/api.dart';

class CastingCard extends StatelessWidget {
  final Personne personne;

  const CastingCard({super.key, required this.personne});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: CachedNetworkImage(
              width: 160,
              imageUrl: API().baseImageURL + personne.imageName!,
              // fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10, left: 10),
            child: SizedBox(
              width: 150,
              child: Text(
                personne.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: SizedBox(
              width: 150,
              child: Text(
                personne.characterName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

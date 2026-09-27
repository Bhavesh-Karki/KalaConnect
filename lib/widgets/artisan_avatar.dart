import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../models/artisan.dart';

class ArtisanAvatar extends StatelessWidget {
  const ArtisanAvatar({super.key, required this.artisan, this.radius = 24});

  final Artisan artisan;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: teal,
      child: Text(
        artisan.initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * .62,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

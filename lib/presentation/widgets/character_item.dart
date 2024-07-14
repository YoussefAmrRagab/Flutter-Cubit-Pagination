import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubit/config/app_colors.dart';
import 'package:cubit/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:cubit/data/models/character.dart';
import 'package:lottie/lottie.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({required this.character, super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          characterDetailsRoute,
          arguments: character,
        ),
        child: GridTile(
          footer: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
                height: 1.4,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          child: ColoredBox(
            color: AppColors.grey,
            child: Hero(
              tag: character.id,
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                placeholderFadeInDuration: Durations.extralong4,
                placeholder: (_, __) =>
                    LottieBuilder.asset('assets/images/loading_animation.json'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

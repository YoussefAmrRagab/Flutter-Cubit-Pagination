import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubit/config/app_colors.dart';
import 'package:cubit/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo(
                        title: "Species : ", value: character.species),
                    buildDivider(242),
                    characterInfo(title: "Gender : ", value: character.gender),
                    buildDivider(250),
                    characterInfo(title: "Status : ", value: character.status),
                    buildDivider(254),
                    if (character.type != '')
                      characterInfo(
                        title: "Type : ",
                        value: character.type,
                      ),
                    if (character.type != '') buildDivider(268),
                    characterInfo(
                      title: "Episodes : ",
                      value: character.episode.join(' / '),
                    ),
                    buildDivider(232),
                    const SizedBox(height: 10),
                    Center(
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                            shadows: [
                              Shadow(
                                color: AppColors.yellow,
                                blurRadius: 7,
                                offset: Offset.zero,
                              )
                            ]),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            FlickerAnimatedText(character.location)
                          ],
                          repeatForever: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 500),
            ]),
          )
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      leading: const BackButton(color: AppColors.white),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: character.id,
          child: CachedNetworkImage(
            imageUrl: character.image,
            fit: BoxFit.cover,
            placeholderFadeInDuration: Durations.extralong4,
            placeholder: (_, __) =>
                LottieBuilder.asset('assets/images/loading_animation.json'),
          ),
        ),
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        )
      ]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}

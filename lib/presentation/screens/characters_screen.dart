import 'package:cubit/config/app_styles.dart';
import 'package:cubit/presentation/cubits/characters_cubit.dart';
import 'package:cubit/presentation/cubits/searching_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cubit/config/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CharactersCubit cubit = BlocProvider.of<CharactersCubit>(context);
    SearchingCubit searchCubit = BlocProvider.of<SearchingCubit>(context);
    TextEditingController searchingEditingController = TextEditingController();
    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        cubit.getCharacters();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        leading: BlocBuilder<SearchingCubit, bool>(
          builder: (context, state) => state
              ? BackButton(
                  color: AppColors.grey,
                  onPressed: () {
                    searchingEditingController.clear();
                    searchCubit.stopSearch();
                    cubit.filterCharacters('');
                  },
                )
              : const SizedBox(),
        ),
        title: BlocBuilder<SearchingCubit, bool>(
          builder: (context, state) => state
              ? TextFormField(
                  controller: searchingEditingController,
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                      hintText: 'Find a character...',
                      border: InputBorder.none,
                      hintStyle: TextStyles.normal18Grey),
                  style: TextStyles.normal18Grey,
                  onChanged: (value) {
                    cubit.filterCharacters(value);
                  },
                )
              : const Text(
                  'Characters',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
        ),
        actions: [
          BlocBuilder<SearchingCubit, bool>(
            builder: (context, state) => state
                ? IconButton(
                    onPressed: () {
                      searchingEditingController.clear();
                      searchCubit.stopSearch();
                      cubit.filterCharacters('');
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                : IconButton(
                    onPressed: () {
                      searchCubit.startSearch();
                    },
                    icon: const Icon(Icons.search),
                  ),
          )
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          if (connectivity != ConnectivityResult.none) {
            return BlocBuilder<CharactersCubit, CharactersState>(
              builder: (context, state) {
                if (!cubit.dataFetched) {
                  cubit.getCharacters();
                }
                if (state is CharactersLoaded) {
                  return GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(6),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.characters.length,
                    itemBuilder: (_, index) => CharacterItem(
                      character: state.characters[index],
                    ),
                  );
                } else if (state is CharactersFiltered) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(6),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.filteredCharacters.length,
                    itemBuilder: (_, index) => CharacterItem(
                        character: state.filteredCharacters[index]),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.yellow,
                      color: AppColors.white,
                    ),
                  );
                }
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_internet.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Can\'t connect .. check internet!',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            );
          }
        },
        child: Container(),
      ),
    );
  }
}

import 'package:cubit/data/models/character.dart';
import 'package:cubit/presentation/cubits/characters_cubit.dart';
import 'package:cubit/presentation/cubits/searching_cubit.dart';
import 'package:cubit/presentation/screens/details_screen.dart';
import 'package:cubit/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_strings.dart';

class AppRouter {
  final CharactersCubit _cubit;

  AppRouter(this._cubit);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _cubit,
              ),
              BlocProvider(
                create: (context) => SearchingCubit(),
              )
            ],
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsRoute:
        Character character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(character: character),
        );
      default:
        return null;
    }
  }
}

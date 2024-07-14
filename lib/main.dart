import 'package:cubit/config/app_router.dart';
import 'package:cubit/data/data_sources/api.dart';
import 'package:cubit/data/repositories/character_repo.dart';
import 'package:cubit/presentation/cubits/characters_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  final CharacterRepo repo = CharacterRepo(Api());

  runApp(
    Application(
      appRouter: AppRouter(CharactersCubit(repo)),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

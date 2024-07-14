import 'package:bloc/bloc.dart';
import 'package:cubit/data/repositories/character_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:cubit/data/models/character.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepo _repo;

  CharactersCubit(this._repo) : super(CharactersInitial());

  final List<Character> _characters = [];
  List<Character> _filteredCharacter = [];
  bool dataFetched = false;
  int currPage = 0;

  void getCharacters() async {
    currPage += 1;
    List<Character> characters = await _repo.getCharacters(currPage);
    _characters.addAll(characters);
    emit(CharactersLoaded(_characters));
    dataFetched = true;
  }

  void filterCharacters(String text) async {
    _filteredCharacter = _characters
        .where((element) => element.name
            .toLowerCase()
            .trim()
            .startsWith(text.toLowerCase().trim()))
        .toList();
    emit(CharactersFiltered(_filteredCharacter));
  }
}

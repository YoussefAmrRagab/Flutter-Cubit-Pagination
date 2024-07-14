import 'package:cubit/data/data_sources/api.dart';
import 'package:cubit/data/models/character.dart';

class CharacterRepo {
  final Api _api;

  CharacterRepo(this._api);

  Future<List<Character>> getCharacters(int page) async {
    List data = await _api.getCharacters(page);
    List<Character> characters = [];
    for (var item in data) {
      characters.add(Character.fromJson(item));
    }
    return characters;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchingCubit extends Cubit<bool> {
  SearchingCubit() : super(false);

  void startSearch() => emit(true);

  void stopSearch() => emit(false);
}

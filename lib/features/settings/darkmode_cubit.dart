import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkmodeCubit extends Cubit<bool> {
  DarkmodeCubit() : super(false) {
    get();
  }

  void get() => emit(GetIt.I<SharedPreferences>().getBool('darkmode') ?? false);
  void set(bool value) => GetIt.I<SharedPreferences>()
      .setBool('darkmode', value)
      .whenComplete(() => emit(value));
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<String> {
  LocaleCubit() : super('en') {
    get();
  }

  void get() => emit(GetIt.I<SharedPreferences>().getString('locale') ?? 'en');
  void set(String value) => GetIt.I<SharedPreferences>()
      .setString('locale', value)
      .whenComplete(() => emit(value));
}

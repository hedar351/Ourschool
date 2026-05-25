import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(const Locale('ar'))) {
    _loadSavedLocale();
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', locale.languageCode);
    emit(LocaleState(locale));
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('app_locale') ?? 'ar';
    emit(LocaleState(Locale(langCode)));
  }
}

class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

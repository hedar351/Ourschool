// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Our School`
  String get title {
    return Intl.message('Our School', name: 'title', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_continue',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Or explore our school`
  String get or_explore {
    return Intl.message(
      'Or explore our school',
      name: 'or_explore',
      desc: '',
      args: [],
    );
  }

  /// `Browse school information`
  String get browse_school {
    return Intl.message(
      'Browse school information',
      name: 'browse_school',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Our School`
  String get welcome_school {
    return Intl.message(
      'Welcome to Our School',
      name: 'welcome_school',
      desc: '',
      args: [],
    );
  }

  /// `An integrated educational environment that aims to develop skills and build the student's personality in an atmosphere of values, respect, and excellence.`
  String get school_description {
    return Intl.message(
      'An integrated educational environment that aims to develop skills and build the student\'s personality in an atmosphere of values, respect, and excellence.',
      name: 'school_description',
      desc: '',
      args: [],
    );
  }

  /// `We build leaders .. We inspire the future`
  String get we_build_leaders {
    return Intl.message(
      'We build leaders .. We inspire the future',
      name: 'we_build_leaders',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get login_success {
    return Intl.message(
      'Login successful',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Server error, please try again later`
  String get server_failure {
    return Intl.message(
      'Server error, please try again later',
      name: 'server_failure',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get offline_failure {
    return Intl.message(
      'No internet connection',
      name: 'offline_failure',
      desc: '',
      args: [],
    );
  }

  /// `No cached user found`
  String get empty_cache_failure {
    return Intl.message(
      'No cached user found',
      name: 'empty_cache_failure',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error, please try again later`
  String get unexpected_error {
    return Intl.message(
      'Unexpected error, please try again later',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `School Management System`
  String get welcome_screen_subtitle {
    return Intl.message(
      'School Management System',
      name: 'welcome_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse school information`
  String get explore_without_login {
    return Intl.message(
      'Browse school information',
      name: 'explore_without_login',
      desc: '',
      args: [],
    );
  }

  /// `School Management System`
  String get school_management_system {
    return Intl.message(
      'School Management System',
      name: 'school_management_system',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get Unavailable {
    return Intl.message('Unavailable', name: 'Unavailable', desc: '', args: []);
  }

  /// `This account is currently not available for viewing`
  String get account_not_available {
    return Intl.message(
      'This account is currently not available for viewing',
      name: 'account_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message('Ok', name: 'Ok', desc: '', args: []);
  }

  /// `Please enter your username`
  String get Username {
    return Intl.message(
      'Please enter your username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get Password {
    return Intl.message(
      'Please enter your password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Students`
  String get Students {
    return Intl.message('Students', name: 'Students', desc: '', args: []);
  }

  /// `Activities`
  String get Activities {
    return Intl.message('Activities', name: 'Activities', desc: '', args: []);
  }

  /// `Announcements`
  String get Announcements {
    return Intl.message(
      'Announcements',
      name: 'Announcements',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `Theme`
  String get Theme {
    return Intl.message('Theme', name: 'Theme', desc: '', args: []);
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get want_to_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'want_to_logout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Payments`
  String get Payments {
    return Intl.message('Payments', name: 'Payments', desc: '', args: []);
  }

  /// `AcademicRecord`
  String get Info {
    return Intl.message('AcademicRecord', name: 'Info', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

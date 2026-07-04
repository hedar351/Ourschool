import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/cubit/theme_cubit.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/theme/theme.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/features/core_ui/Integration/SplashPage.dart';
import 'package:school/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final prefs = await SharedPreferences.getInstance();
  print("🔵 Stored cache key: ${prefs.getString(authCacheKey)}");
  runApp(const MyApp());
}

// kl;kl;jhkl
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: localeState.locale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: 'Future School',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                home: const SplashPage(),
              );
            },
          );
        },
      ),
    );
  }
}

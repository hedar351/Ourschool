import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/cubit/theme_cubit.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/theme/theme.dart';
import 'package:school/features/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Cross-role/Route/SplashPage.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/FirstStep/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/features/Student/ui/bloc/ProfileBloc/student_bloc.dart';
import 'package:school/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/FirstStep/SchoolsInfo/UI/bloc/school_info_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final prefs = await SharedPreferences.getInstance();
  print("🔵 Stored cache key: ${prefs.getString(authCacheKey)}");

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SchoolInfoBloc>(
          create: (context) => di.sl<SchoolInfoBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider(create: (context) => di.sl<BulletinBloc>()),
        BlocProvider(create: (context) => di.sl<StudentBloc>()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: Builder(
        builder: (context) {
          final localeState = context.select((LocaleCubit c) => c.state);
          final themeMode = context.select((ThemeCubit c) => c.state);

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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_instagram/blocs/app_state_bloc.dart';
import 'package:social_instagram/modules/authentication/bloc/authentication_bloc.dart';
import 'package:social_instagram/modules/authentication/wrapper/service/app_auth_service.dart';
import 'package:social_instagram/modules/localizations/localizations_constants.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/route/routes.dart';
import 'package:social_instagram/themes/app_colors.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appStateBloc = AppStateBloc();
  late AuthenticationBloc _authenticationBloc;
  static final GlobalKey<State> key = GlobalKey();
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(AppAuthService());
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: appStateBloc,
      child: StreamBuilder<AppState>(
        stream: appStateBloc.appState,
        initialData: appStateBloc.initState,
        builder: (context, snapshot) {
          if (snapshot.data == AppState.loading) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Container(
                color: Colors.white,
              ),
            );
          }
          if (snapshot.data == AppState.unAuthorized) {
            return BlocProvider(
              bloc: _authenticationBloc,
              child: MaterialApp(
                key: const ValueKey('UnAuthorized'),
                themeMode: ThemeMode.light,
                builder: _builder,
                // initialRoute: RouteName.welcomePage,
                onGenerateRoute: Routes.unAuthorizedRoute,
                debugShowCheckedModeBanner: false,
              ),
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: Routes.authorizedRoute,
            theme: ThemeData(
              primaryColor: AppColors.darkGray,
            ),
            key: key,
            builder: _builder,
            navigatorKey: MyApp.navigatorKey,
          );
        },
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    // get the current media query
    final data = MediaQuery.of(context);
    // return a new media query with the same data, except with a text scale factor of 1
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1),
      child: child!,
    );
  }
}

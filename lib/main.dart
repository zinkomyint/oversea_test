import 'package:borderlessWorking/screens/main_screen/main_screen.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc/auth.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'repositories/auth_repositories.dart';
import 'screens/auth/intro_screen.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:dio/dio.dart';
import 'package:get/get.dart';

void main() {
  final authRepository = AuthRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)
          ..add(AppStarted());
      },
      child: MyApp(authRepository: authRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dio dio = Dio();
    // dio.interceptors
    //     .add(LogInterceptor(responseBody: true, logPrint: (log) => print(log)));
    // AuthRepository authRepository = AuthRepository();
    // dio.transformer = FlutterTransformer();

    // dio.interceptors.add(DioCacheManager(
    //         CacheConfig(baseUrl: 'http://192.168.100.27:8000/api/v1/'))
    //     .interceptor);
    // Get.put(authRepository);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('mn', 'MN'),
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return MainScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return IntroPage(authRepository: authRepository);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Style.Colors.mainColor),
                        strokeWidth: 4.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Style.Colors.mainColor),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

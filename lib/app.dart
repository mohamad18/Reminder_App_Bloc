import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/pages/home_page.dart';
import 'package:reminderapp_test/features/splash/splash_page.dart';
import 'package:reminderapp_test/configs/routes.dart' as router;
import 'di/injection.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<HomeBloc>()),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.getTheme,
            initialRoute: SplashPage.ROUTE,
            onGenerateRoute: router.generateRoute,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

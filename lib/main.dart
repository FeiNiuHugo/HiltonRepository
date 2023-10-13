import 'package:flutter/material.dart';
import 'package:hilton_quiz/data/repository/PokemonRepository.dart';
import 'package:provider/provider.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(const HiltonApp());
}

class HiltonApp extends StatefulWidget {
  const HiltonApp({super.key});

  @override
  State<StatefulWidget> createState() => HiltonAppState();
}

class HiltonAppState extends State<HiltonApp> {
  late final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final router = _appRouter.router;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => PokemonRepository()
        )
      ],
      child: MaterialApp.router(
        title: 'HiltonQuiz',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
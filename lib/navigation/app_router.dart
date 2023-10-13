import 'package:go_router/go_router.dart';
import 'package:hilton_quiz/ui/detail.dart';
import 'package:hilton_quiz/ui/home.dart';
import 'package:hilton_quiz/ui/splash.dart';

class AppRouter {

  late final router = GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(
        name: 'splash',
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: 'detail',
        path: '/detail',
        builder: (context, state) => const DetailPage(),
      ),
    ],
  );
}
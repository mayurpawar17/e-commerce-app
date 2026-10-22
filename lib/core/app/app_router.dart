import 'package:e_commerce_app/features/product/presentation/pages/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

      // GoRoute(path: '/createPost', builder: (context, state) => const CreatePostScreen()),
    ],
  );
}

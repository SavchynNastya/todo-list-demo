import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/features/history/presentation/screens/tasks_history_main_screen.dart';
import 'package:todolist/features/sections_board/presentation/screens/section_create_screen.dart';
import 'package:todolist/features/sections_board/presentation/screens/tasks_board_main_screen.dart';
import 'package:todolist/features/settings/presentation/screens/settings_main_screen.dart';
import 'package:todolist/features/tasks/create_task/presentation/screens/task_create_screen.dart';
import 'package:todolist/features/tasks/view_task/presentation/screens/due_tasks_main_screen.dart';
import 'package:todolist/features/tasks/view_task/presentation/screens/today_tasks_main_screen.dart';
import 'features/bottom_nav_bar/presentation/screens/parent_screen.dart';
import 'features/tasks/view_task/presentation/screens/task_details.dart';


final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/today-tasks',
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/create-section',
      pageBuilder: (context, state) => customPageTransition(
        const SectionCreateScreen(),
        state,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/create-task',
      pageBuilder: (context, state) => customPageTransition(
        const TaskCreateScreen(),
        state,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/settings',
      pageBuilder: (context, state) => customPageTransition(
        const SettingsMainScreen(),
        state,
      ),
    ),
    GoRoute(
      path: '/tasks/:id',
      pageBuilder: (context, state) => customPageTransition(
        TaskDetailsPage(
          key: UniqueKey(),
          taskId: state.pathParameters['id']!,
        ),
        state,
      ),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return BottomNavBarParentScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/today-tasks',
          pageBuilder: (context, state) => customPageTransition(
            const TodayTasksMainScreen(),
            state,
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/tasks-board/:index',
          pageBuilder: (context, state) => customPageTransition(
            TasksBoardMainScreen(
              initialTab: int.parse(state.pathParameters['index'] ?? '0'),
            ),
            state,
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/due-tasks',
          pageBuilder: (context, state) => customPageTransition(
            const DueTasksMainScreen(),
            state,
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/history',
          pageBuilder: (context, state) => customPageTransition(
            const TasksHistoryMainScreen(),
            state,
          ),
        ),
      ],
    ),
  ],
);

customPageTransition(page, GoRouterState state, {bool maintainState = false}) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    child: page,
    maintainState: maintainState,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

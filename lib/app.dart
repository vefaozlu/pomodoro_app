import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/model/models/models.dart';

import 'package:pomodoro_app/model/repositories/repositories.dart';
import 'package:pomodoro_app/ticker/ticker.dart';
import 'package:pomodoro_app/view/screens/screens.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class App extends StatelessWidget {
  const App(
      {required this.goalsRepository,
      required this.settingsRepository,
      required this.dailyHistoryRepository,
      required this.weeklyHistoryRepository,
      Key? key})
      : super(key: key);

  final GoalsRepository goalsRepository;
  final SettingsRepository settingsRepository;
  final DailyHistoryRepository dailyHistoryRepository;
  final WeeklyHistoryRepository weeklyHistoryRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: goalsRepository),
        RepositoryProvider.value(value: settingsRepository),
        RepositoryProvider.value(value: dailyHistoryRepository),
        RepositoryProvider.value(value: weeklyHistoryRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(
              ticker: const Ticker(),
              gR: context.read<GoalsRepository>(),
              sR: context.read<SettingsRepository>(),
              dHR: context.read<DailyHistoryRepository>(),
              wHR: context.read<WeeklyHistoryRepository>(),
            )..add(const InitializeTimer()),
          ),
          BlocProvider(
            create: (context) => GoalsBloc(
                repository: context.read<GoalsRepository>(),
                dHR: context.read<DailyHistoryRepository>())
              ..add(const FetchItems()),
          ),
        ],
        child: const PomodoroApp(),
      ),
    );
  }
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro App',
      initialRoute: '/',
      routes: {
        '/': (context) => const BaseApp(),
        GoalInputPage.routeName: (context) => const GoalInputPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        InformationPage.routeName: (context) => const InformationPage(),
        SupportPage.routeName: (context) => const SupportPage(),
      },
    );
  }
}

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int currentIndex = 0;

  void pushSettingsPage() {
    Navigator.pushNamed(context, SettingsPage.routeName);
  }

  void pushGoalInputPage(Goal? goalToEdit) {
    Navigator.pushNamed(context, GoalInputPage.routeName,
        arguments: goalToEdit);
  }

  void pushInformationPage() {
    Navigator.pushNamed(context, InformationPage.routeName);
  }

  void pushSupportPage() {
    Navigator.pushNamed(context, SupportPage.routeName);
  }

  void _onTap(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, GoalInputPage.routeName);
    } else if (index != currentIndex) {
      setState(() => currentIndex = index);
      switch (index) {
        case 0:
          _navigatorKey.currentState!.pushReplacementNamed('Home');
          break;
        case 1:
          _navigatorKey.currentState!.pushReplacementNamed('History');
          break;
        case 3:
          _navigatorKey.currentState!.pushReplacementNamed('Quotes');
          break;
        case 4:
          _navigatorKey.currentState!.pushReplacementNamed('Profile');
          break;
      }
    }
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'History':
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      case 'Quotes':
        return MaterialPageRoute(builder: (context) => const QuotesPage());
      case 'Profile':
        return MaterialPageRoute(
            builder: (context) => ProfilePage(
                  pushSettingsPage: pushSettingsPage,
                  pushInformationPage: pushInformationPage,
                  pushSupportPage: pushSupportPage,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) =>
                MainPage(pushGoalInputPage: pushGoalInputPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          _navigatorKey.currentState!.pushReplacementNamed('Home');
          setState(() => currentIndex = 0);
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Navigator(
            key: _navigatorKey,
            onGenerateRoute: _onGenerateRoute,
          ),
          bottomNavigationBar: BottomNavigationBarTheme(
            data: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF8C2920),
              selectedItemColor: Color(0xFF0D0D0D),
              unselectedItemColor: Color(0xFFF2F2F2),
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: _onTap,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Center(
                      child: Icon(
                    Icons.add_circle_outline,
                  )),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_quote),
                  label: 'Quotes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

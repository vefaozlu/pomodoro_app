import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/view/screens/screens.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key, required this.pushGoalInputPage}) : super(key: key);

  final Function pushGoalInputPage;

  final PageController _pageController = PageController();
  void goToInitialPage() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerRunCompleted) {
          print('aaa');
          context.read<GoalsBloc>().add(const FetchItems());
        }
      },
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: [
          TimerPage(pushGoalInputPage: pushGoalInputPage),
          GoalsPage(goToInitialPage: goToInitialPage, pushGoalInputPage: pushGoalInputPage,),
        ],
        onPageChanged: (index) {
/*           if (index == 0) {
            context
                .read<NavigationCubit>()
                .showHideNavBar(isNavBarExpanded: true);
          } */
        },
      ),
    );
  }
}

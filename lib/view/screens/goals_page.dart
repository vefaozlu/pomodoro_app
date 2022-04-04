import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view/widgets/widgets.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage(
      {Key? key,
      required this.goToInitialPage,
      required this.pushGoalInputPage})
      : super(key: key);

  final VoidCallback goToInitialPage;
  final Function pushGoalInputPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PomodoroColors.color1,
      body: BlocBuilder<GoalsBloc, GoalsState>(builder: (context, state) {
        if (state is GoalsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GoalsSuccess) {
          return GoalsView(
            goals: state.goals,
            goToInitialPage: goToInitialPage,
            pushGoalInputPage: pushGoalInputPage,
          );
        }
        return const Center(
          child: Text('Ooops! Something Went Wrong.'),
        );
      }),
    );
  }
}

class GoalsView extends StatefulWidget {
  const GoalsView(
      {Key? key,
      required this.goals,
      required this.goToInitialPage,
      required this.pushGoalInputPage})
      : super(key: key);

  final List<Goal> goals;
  final VoidCallback goToInitialPage;
  final Function pushGoalInputPage;

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
/*   @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(listen);
    super.initState();
  }

  void listen() {
    final scrollDirection = _controller.position.userScrollDirection;
    if (scrollDirection == ScrollDirection.forward) {
      context.read<NavigationCubit>().showHideNavBar(isNavBarExpanded: true);
    } else if (scrollDirection == ScrollDirection.reverse) {
      context.read<NavigationCubit>().showHideNavBar(isNavBarExpanded: false);
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .8,
        decoration: BoxDecoration(
          // color: const Color(0xFFAC4940),
          color: PomodoroColors.color2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.goals.length,
          itemBuilder: (context, index) {
            return A(
                goal: widget.goals[index],
                goToInitialPage: widget.goToInitialPage,
                pushGoalInputPage: widget.pushGoalInputPage);
          },
        ),
      ),
    );
  }

/*   @override
  void dispose() {
    _controller.removeListener(listen);
    _controller.dispose();
    super.dispose();
  } */
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view/widgets/widgets.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class GoalInputPage extends StatelessWidget {
  const GoalInputPage({Key? key, this.goalToEdit}) : super(key: key);

  final Goal? goalToEdit;

  static const routeName = '/goalInputPage';

  @override
  Widget build(BuildContext context) {
    final Goal? goalToEdit = ModalRoute.of(context)!.settings.arguments as Goal?;
    return BlocProvider(
      create: (_) => GoalInputCubit(
          repository: context.read<GoalsRepository>(), goalToEdit: goalToEdit),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: PomodoroColors.color1,
          body: InputForm(),
        ),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GoalInputState state = context.watch<GoalInputCubit>().state;
    return Center(
      child: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldTitle(title: 'What Is Your New Goal'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Input(
                  text: state.name,
                  onChanged: (value) => context
                      .read<GoalInputCubit>()
                      .onValueChanged(name: value),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldTitle(title: 'Add A Note'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Input(
                  text: state.note,
                  maxLines: 5,
                  onChanged: (value) => context
                      .read<GoalInputCubit>()
                      .onValueChanged(note: value),
                  validator: (value) => null,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldTitle(title: 'Set Pomodoro Count'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PomodoroCounter(
                  estimatedPomodoros: state.estimatedPomodoros,
                  increment: (count) => context
                      .read<GoalInputCubit>()
                      .onValueChanged(estimatedPomodoros: count),
                  decrement: (count) => context
                      .read<GoalInputCubit>()
                      .onValueChanged(estimatedPomodoros: count),
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 50)),
            SliverToBoxAdapter(
              child: TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  height: 50,
                  decoration: BoxDecoration(
                    color: PomodoroColors.color2,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<GoalInputCubit>().saveChanges(
                        name: state.name,
                        note: state.note,
                        estimatedPomodoros: state.estimatedPomodoros);
                    Navigator.pop(context);
                    context.read<GoalsBloc>().add(const FetchItems());
                  }
                },
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 25)),
            SliverToBoxAdapter(
              child: TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

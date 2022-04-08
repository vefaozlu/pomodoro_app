import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view_model/history_cubit/history_cubit.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(
          dHR: context.read<DailyHistoryRepository>(),
          wHR: context.read<WeeklyHistoryRepository>())
        ..fetchItems(),
      child: Scaffold(
        backgroundColor: PomodoroColors.color1,
        body: PageView(
          controller: _controller,
          children: const [
            LineChartView(),
            PieChartView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PomodoroColors.color2,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 250),
            turns: currentIndex == 0 ? 0 : -.5,
            child: const Icon(
              Icons.arrow_forward,
            ),
          ),
          onPressed: () {
            if (currentIndex == 0) {
              _controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
              setState(() => currentIndex = 1);
            } else {
              _controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
              setState(() => currentIndex = 0);
            }
          },
        ),
      ),
    );
  }
}

class LineChartView extends StatelessWidget {
  const LineChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryState state = context.watch<HistoryCubit>().state;
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: LineChart(
            LineChartData(
              maxX: 7,
              maxY: 20,
              minY: 0,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                border: const Border(
                  bottom: BorderSide(color: Colors.white),
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) =>
                      const TextStyle(color: Colors.white),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 1:
                        return 'Mon';
                      case 2:
                        return 'Tue';
                      case 3:
                        return 'Wed';
                      case 4:
                        return 'Thu';
                      case 5:
                        return 'Fri';
                      case 6:
                        return 'Sat';
                    }
                    return 'Sun';
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  show: true,
                  colors: [PomodoroColors.color2],
                  isCurved: true,
                  barWidth: 5,
                  spots: data(state.weeklyHistory, -1),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      PomodoroColors.color2.withOpacity(.5),
                      PomodoroColors.color2.withOpacity(.1)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: PomodoroColors.color3),
        Expanded(
          flex: 1,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Least Studied Day\n${state.leastStudiedDay}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Most Studied Day\n${state.mostStudiedDay}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> data(List<WeeklyHistory> items, int touchedIndex) {
    return List.generate(
        items.length,
        (index) => FlSpot(items[index].weekday.toDouble(),
            items[index].pomodorosDone.toDouble()));
  }
}

class PieChartView extends StatefulWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final HistoryState state = context.watch<HistoryCubit>().state;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        setState(() => touchedIndex = -1);
                      } else {
                        setState(() => touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex);
                      }
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 5,
                  centerSpaceRadius: 45,
                  sections: sections(touchedIndex, state.dailyHistory),
                ),
              ),
            ),
          ),
        ),
        const Divider(color: PomodoroColors.color3),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Most Studied Lesson',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      state.mostStudiedLesson != null
                          ? '${state.mostStudiedLesson!.goalName}(${state.mostStudiedLesson!.pomodorosDone})'
                          : '',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Least Studied Lesson',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      state.leastStudiedLesson != null
                          ? '${state.leastStudiedLesson!.goalName}(${state.leastStudiedLesson!.pomodorosDone})'
                          : '',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Pomodoros\n${state.totalPomodoros}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> sections(
      int touchedIndex, List<DailyHistory> items) {
    final Size size = MediaQuery.of(context).size;
    double radius = size.width > size.height ? 100 : size.width * .35;
    return List.generate(
      items.length,
      (index) {
        final String selectedTitle =
            '${items[index].goalName}\n${items[index].pomodorosDone} done';
        return PieChartSectionData(
          color: PomodoroColors.color2,
          value: items[index].pomodorosDone.toDouble(),
          title: touchedIndex == index ? selectedTitle : items[index].goalName,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          radius: touchedIndex == index ? radius * 1.2 : radius,
        );
      },
    );
  }
}

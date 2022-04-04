import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/view_model/quotes_cubit/quotes_cubit.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuotesCubit(Quotes())..initialize(),
      child: const QuotesView(),
    );
  }
}

class QuotesView extends StatefulWidget {
  const QuotesView({Key? key}) : super(key: key);

  @override
  State<QuotesView> createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  @override
  Widget build(BuildContext context) {
    final QuotesState state = context.watch<QuotesCubit>().state;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: state.image,
              fit: BoxFit.cover,
            ),
          ),
          child: PageView.builder(
            onPageChanged: (index) =>
                context.read<QuotesCubit>().onScreenChange(index),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'AAAAAA',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state is Loading
              ? Container(color: Colors.white60)
              : const SizedBox(),
        ),
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

class Quotes {
  List<String> imgLinks = [
    'https://images.unsplash.com/photo-1596237563267-84ffd99c80e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1503435980610-a51f3ddfee50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1508193638397-1c4234db14d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9yZXN0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1511207538754-e8555f2bc187?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9yZXN0fGVufDB8MXwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1496060169243-453fde45943b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZvcmVzdHxlbnwwfDF8MHx8&auto=format&fit=crop&w=500&q=60',
  ];

  List<String> quotes = [
    'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    'Bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
    'Cccccccccccccccccccccccccccccccccc',
    'Dddddddddddddddddddddddddddddddddd',
    'Eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
  ];
}

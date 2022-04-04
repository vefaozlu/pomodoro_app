import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/view/screens/screens.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final Quotes quotes;
  QuotesCubit(this.quotes) : super(const Loading(NetworkImage('aaa')));

  Future<void> initialize() async {
    final String link = quotes.imgLinks[0];
    final NetworkImage image = NetworkImage(link);
    emit(Loading(image));
    await Future.delayed(const Duration(seconds: 1));
    emit(Success(image: image));
  }

  Future<void> onScreenChange(int index) async {
    int i = index % quotes.imgLinks.length;
    final String link = quotes.imgLinks[i];
    final NetworkImage image = NetworkImage(link);
    emit(Loading(image));
    await Future.delayed(const Duration(seconds: 1));
    emit(Success(image: image));
  }
}

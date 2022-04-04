part of 'quotes_cubit.dart';

abstract class QuotesState extends Equatable {
  const QuotesState({required this.image});

  final NetworkImage image;

  @override
  List<Object> get props => [];
}

class Loading extends QuotesState {
  const Loading(NetworkImage image) : super(image: image);
}

class Success extends QuotesState {
  const Success({required NetworkImage image}) : super(image: image);
}

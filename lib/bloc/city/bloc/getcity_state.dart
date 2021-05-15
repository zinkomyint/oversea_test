part of 'getcity_bloc.dart';

abstract class GetcityState extends Equatable {
  const GetcityState();
}

class GetcityInitial extends GetcityState {
   const GetcityInitial();
  @override
  List<Object> get props => [];
}

class GetcitySuccess extends GetcityState {
    final List<Getcity> city;
  // final List<Getcity> city;
 
  const GetcitySuccess(this.city);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [city];
}

class GetcityFail extends GetcityState {
  final String error;
  GetcityFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

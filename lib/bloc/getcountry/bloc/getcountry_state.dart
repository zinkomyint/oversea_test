part of 'getcountry_bloc.dart';

abstract class GetcountryState extends Equatable {
  const GetcountryState();
}

class GetcountryInitial extends GetcountryState {
  const GetcountryInitial();
  @override
  List<Object> get props => [];
}

class GetcountrySuccess extends GetcountryState{
  final List<Getcountry> country;
  final List<Getcity> city;
 
  const GetcountrySuccess(this.country,this.city);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [country,city];
}

class GetcountryFail extends GetcountryState{
  final String error;
  GetcountryFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

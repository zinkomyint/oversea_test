import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/bloc/getcountry/bloc/getcountry_bloc.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:equatable/equatable.dart';

part 'getcity_event.dart';
part 'getcity_state.dart';

class GetcityBloc extends Bloc<GetcityEvent, GetcityState> {
  var idProvince;
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  GetcityBloc() : super(GetcityInitial());

  @override
  Stream<GetcityState> mapEventToState(
    GetcityEvent event,
  ) async* {
    if (event is Getcitylist) {
      try {
        yield GetcityInitial();
        final city = await _getcountryRepository.getcity(idProvince);
        yield GetcitySuccess(city);
      } on NetworkError {
        yield GetcityFail("Failed to fetch data. is your device online?");
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:equatable/equatable.dart';

part 'getcountry_event.dart';
part 'getcountry_state.dart';

class GetcountryBloc extends Bloc<GetcountryEvent, GetcountryState> {
  String idProvince;
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  GetcountryBloc() : super(GetcountryInitial());

  @override
  Stream<GetcountryState> mapEventToState(
    GetcountryEvent event,
  ) async* {
    if (event is Getcountrylist) {
      try {
            yield GetcountryInitial();
            final country = await _getcountryRepository.getcountry();
            // final city = await _getcountryRepository.getcity(idProvince);
            // print("city-list - $city");
            yield GetcountrySuccess(country);
      }on NetworkError {
          yield GetcountryFail("Failed to fetch data. is your device online?");
      }
    }
  }
  
}

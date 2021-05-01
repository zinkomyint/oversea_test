import 'dart:async';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/data/repositories/contact_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository = ContactRepository();
  ContactBloc() : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is GetContactList) {
      try {
        yield ContactInitial();
        final mList = await contactRepository.getContactList();
        yield ContactSuccess(mList);
        // if (mList.error != null) {
        //   yield ContactFail(mList.error);
        // }
      } on NetworkError {
        yield ContactFail("Failed to fetch data. is your device online?");
      }
    }
  }
}

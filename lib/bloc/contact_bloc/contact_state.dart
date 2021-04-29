part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  const ContactInitial();
  @override
  List<Object> get props => [];
}

class ContactSuccess extends ContactState {
  final ContactModel contacts;

  const ContactSuccess(this.contacts);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [contacts];
}

class ContactFail extends ContactState {
  final String error;
  ContactFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

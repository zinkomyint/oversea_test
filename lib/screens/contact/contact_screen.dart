import 'package:borderlessWorking/bloc/contact_bloc/contact_bloc.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactBloc _newsBloc = ContactBloc();

  @override
  void initState() {
    _newsBloc.add(GetContactList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact List')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is ContactFail) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactInitial) {
                return _buildLoading();
              } else if (state is ContactSuccess) {
                return _buildCard(context, state.contacts);
              } else if (state is ContactFail) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, ContactModel model) {
    return ListView.builder(
      itemCount: model.contacts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("ID: ${model.contacts[index].id}"),
                  Text("Name: ${model.contacts[index].name}"),
                  Text("Job: ${model.contacts[index].job}"),
                  Text("Age: ${model.contacts[index].age}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
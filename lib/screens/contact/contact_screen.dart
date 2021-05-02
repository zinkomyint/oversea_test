import 'package:borderlessWorking/Widget/contact/contact_list_widget.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/contact_bloc/contact_bloc.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:get/get.dart';

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
    // Options options = buildCacheOptions(Duration(days: 10), forceRefresh: true);
    // Get.put(options);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.secondBlack,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
        ),
        title: Text("Contact List"),
        actions: [
          IconButton(
              icon: Icon(EvaIcons.logOutOutline),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              })
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    ApiService apiService = Get.find();
    return Container(
      // margin: EdgeInsets.all(8.0),
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
                return buildLoading();
              } else if (state is ContactSuccess) {
                if (state is ContactSuccess) {
                  List<ContactModel> contacts = state.contacts;
                  return ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, position) {
                        return item(contacts[position], context);
                      });
                }
              } else if (state is ContactFail) {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

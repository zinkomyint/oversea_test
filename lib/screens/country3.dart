import 'dart:convert';

import 'package:borderlessWorking/bloc/city/bloc/getcity_bloc.dart';
import 'package:borderlessWorking/bloc/getcountry/bloc/getcountry_bloc.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class Country3 extends StatefulWidget {
  @override
  _Country3State createState() => _Country3State();
}

class _Country3State extends State<Country3> {
  final GetcountryBloc _newsBloc = GetcountryBloc();
  // ignore: close_sinks
  final GetcityBloc _getcityBloc = GetcityBloc();

  @override
  void initState() {
    _newsBloc.add(Getcountrylist());
    // _getcityBloc.add(Getcitylist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          margin: const EdgeInsets.only(top: 80.0),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: new Form(
            child: _buildList(),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    ApiService apiService = Get.find();
    return Container(
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => _newsBloc,
        ),
        BlocProvider(
          create: (_) => _getcityBloc,
        )
      ], child: Bloctesting()),
    );
  }
}

class Bloctesting extends StatefulWidget {
  @override
  _BloctestingState createState() => _BloctestingState();
}

class _BloctestingState extends State<Bloctesting> {
  ApiService apiService = Get.find();
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  final GetcountryBloc _newsBloc = GetcountryBloc();
  final GetcityBloc _getcityBloc = GetcityBloc();
  String dropdownValue, _selectcity;
    List<dynamic> _dataProvince = List(), _dataCity = List();

  void getcity(String idProvince) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = test;
    });
    print("Data City : $test");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Country_bloc
        BlocBuilder<GetcountryBloc, GetcountryState>(
          builder: (context, state) {
            if (state is GetcountryInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetcountrySuccess) {
              if (state is GetcountrySuccess) {
                List<Getcountry> country = state.country;
                return Container(
                  child: DropdownButton<String>(
                    hint: new Text("Select Country"),
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String cname) {
                      setState(() {
                        dropdownValue = cname;
                        _selectcity = null;
                      });
                      getcity(cname);
                    },
                    items: country.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.country_name,
                        child: Text(value.country_name),
                      );
                    }).toList(),
                  ),
                );
              }
            }
          },
        ),
        DropdownButton(
              hint: Text("Select City"),
              value: _selectcity,
              items: _dataCity.map((item){
                return DropdownMenuItem(
                  child: Text(item.city_name),
                  value: item.city_name,
                );
              }).toList(),
              onChanged: (value) {
               setState(() {
                 _selectcity = value;
               });
              },
            ),
        //City_bloc
        // BlocBuilder<GetcityBloc, GetcityState>(
        //   builder: (context, state) {
        //     if (state is GetcityInitial) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (state is GetcitySuccess) {
        //       if (state is GetcitySuccess) {
                
        //       }
        //     }
        //   },
        // )
      ],
    );
  }
}

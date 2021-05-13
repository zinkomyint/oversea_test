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

class Getcountries extends StatefulWidget {
  @override
  _GetcountriesState createState() => _GetcountriesState();
}

class _GetcountriesState extends State<Getcountries> {
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  final GetcountryBloc _newsBloc = GetcountryBloc();
  final GetcityBloc _getcityBloc = GetcityBloc();
  String dropdownValue;
  String _selectcity;
  List<dynamic> _dataCity = List();

  // void getcity(String idProvince) async {
  //   final citeytester = await _getcountryRepository.getcity(idProvince);
  //   // print("getcity : $idProvince");
  // }
  void getcity(String idProvince) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = test;
    });
    print("Data City : $test");
  }

  @override
  void initState() {
    _newsBloc.add(Getcountrylist());
    _selectcity = 'select country';
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
        child: BlocProvider(
      create: (_) => _newsBloc,
      child: BlocListener<GetcountryBloc, GetcountryState>(
        listener: (context, state) {
          if (state is GetcountryFail) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<GetcountryBloc, GetcountryState>(
          builder: (context, state) {
            if (state is GetcountryInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetcountrySuccess) {
              if (state is GetcountrySuccess) {
                List<Getcountry> country = state.country;
                // List<Getcity> city = state.city;
                return Column(children: [
                  Container(
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
                  ),
                  Container(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Select City"),
                      value: _selectcity,
                      items: _dataCity.map((city) {
                        return DropdownMenuItem(
                          child: Text(city.city_name),
                          value: city.city_name,
                        );
                      }).toList(),
                      onChanged: (city) {
                        setState(() {
                          _selectcity = city;
                        });
                      },
                    ),
                  )
                ]);
              }
            } else if (state is GetcountryFail) {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ));
  }
}

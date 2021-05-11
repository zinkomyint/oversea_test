import 'package:borderlessWorking/bloc/getcountry/bloc/getcountry_bloc.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class Country2 extends StatefulWidget {
  @override
  _Country2State createState() => _Country2State();
}

class _Country2State extends State<Country2> {
  String mm;
  Future _state;
  Future _city;
  final GetcountryBloc _newsBloc = GetcountryBloc();
  String dropdownValue;
  @override
  void initState() {
    _newsBloc.add(Getcountrylist());
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
            // key: _key,
            // autovalidate: _validate,
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
                List<Getcity> city = state.city;
                return Column(children: [
                  Container(
                    child: FutureBuilder<List<Getcountry>>(
                        future: _state,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Getcountry>> snapshot) {
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
                                  print("selected : $cname");
                                 _city = apiService.getcity(cname);
                                });
                              },
                              items: country
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value.country_name,
                                  child: Text(value.country_name),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                  ),

                  Container(
                    child: FutureBuilder<List<Getcity>>(
                        future: _city,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Getcity>> snapshot) {
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
                              onChanged: (String ee) {
                                setState(() {
                                  dropdownValue = ee;
                                  // _city = apiService.getcity();
                                });
                              },
                              items:
                                  city.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value.country_name,
                                  child: Text(value.country_name),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                  ),

                  //  return ListView.builder(
                  //     itemCount: country.length,
                  //     itemBuilder: (context, position) => countrylist(country[position], context)
                  //     );
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

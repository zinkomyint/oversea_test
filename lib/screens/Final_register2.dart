import 'dart:convert';

import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:borderlessWorking/data/repositories/register_repositories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class Formregister extends StatefulWidget {
  @override
  _FormregisterState createState() => _FormregisterState();
}

class _FormregisterState extends State<Formregister> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc()..add(InitialState()),
          // child: Testing(),
          child: new Form(
            key: _formKey,
            autovalidate: _validate,
            child: Testing(),
          ),
        ));
  }
}

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final _formKey = GlobalKey<FormState>();
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  String password_check;
  final TextEditingController _confirmController = TextEditingController();
  final _jobseekernameController = TextEditingController();
  final _jobseekerfuriganaController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnameController = TextEditingController();
  final _cityController = TextEditingController();
  String countryName;
  String cityId;
  String unemail;
  var check;
  final RegisterRepository _registerRepository = RegisterRepository();
  bool _obscureText = true;
  List<Getcountry> _dataCountry = List();
  List<Getcity> _dataCity = List();

  mailcheck1(email) async {
    // final test = await _registerRepository.mailcheck(email);
    var params = {
      "email": email,
    };
    final http.Response response = await http.post(
      'http://192.168.99.207:8000/api/v1/jobseeker/mail-unity/',
      headers: {
        "Content-type": "application/json",
      },
      body: jsonEncode(params),
    );
    print(response.statusCode);
    if (email != null) {
      if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('Email already exists')));
      } else {
        return null;
      }
    }
    // if (response.statusCode != 200) {
    //   print("mailrepeat");
    //   return true;r
    // } else {
    //   return null;
    // }
  }

  //Getcountry_API
  void getcity(String idProvince) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = List();
      Getcity defCity = new Getcity(0, "", "???????????????", "");
      _dataCity.add(defCity);
      test.forEach((data) {
        _dataCity.add(data);
      });
    });
    print("Data City : $test");
  }

  //Getcity_API
  void getcountry() async {
    final test = await _getcountryRepository.getcountry();
    setState(() {
      _dataCountry = List();
      Getcountry defCountry = new Getcountry(0, "", "?????????????????????", "");
      _dataCountry.add(defCountry);
      test.forEach((data) {
        _dataCountry.add(data);
      });
    });
    print("Data City : $test");
  }

  @override
  void initState() {
    super.initState();
    getcountry();
  }

  bool _obscureText2 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          jobseeker_name: _jobseekernameController.text,
          jobseeker_furigana_name: _jobseekerfuriganaController.text,
          dob: _dobController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          password: _passwordController.text,
          country_name: _cnameController.text,
          country_id: _cityController.text,
        ),
      );
    }

    //form
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessful) {
          print('success');
        } else if (state is RegisterFailure) {
          print('Fails');
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Register Failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          print('loading');
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0, top: 20),
                  child: Text(
                    '???????????????????????????',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                //name
                Container(
                  // width: 350,
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '??????',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                Container(
                  height: 80,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: this._jobseekernameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '?????????????????????';
                      }
                    },
                  ),
                ),
                // SizedBox(height: 10),

                //furigana
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '??????(????????????)',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  // padding: const EdgeInsets.all(3.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _jobseekerfuriganaController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String patttern = r'(^[\u30a0-\u30ff ]*$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value.isEmpty) {
                        return "???????????????????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "?????????????????????????????????????????????";
                      }
                      return null;
                    },
                  ),
                ),

                // SizedBox(height: 10),

                //brithday
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  // padding: const EdgeInsets.all(3.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _dobController,
                  ),
                ),

                // SizedBox(height: 10),

                //city
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ]),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(6.0),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                            margin: const EdgeInsets.only(right: 15.0),
                            width: 160,
                            height: 55,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text("?????????????????????"),
                                value: countryName,
                                items: _dataCountry.map((cname) {
                                  return DropdownMenuItem(
                                    child: Text(cname.country_name),
                                    value: cname.country_name,
                                  );
                                }).toList(),
                                onChanged: (cname) {
                                  setState(() {
                                    countryName = cname;
                                    _cnameController.text = cname;
                                    print("ddeee $cname");
                                    cityId = null;
                                    _cityController.text = null;
                                  });
                                  getcity(cname);
                                },
                              ),
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(6.0),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                            // margin: const EdgeInsets.only(right: 15.0),
                            width: 160,
                            height: 55,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text("???????????????"),
                                value: cityId,
                                items: _dataCity.map((city) {
                                  return DropdownMenuItem(
                                    // child: Text(city.city_name),
                                    // value: city.id.toString(),
                                    value: city.id.toString(),
                                    child: city.id != 0
                                        ? Text("  " + city.city_name)
                                        : Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_drop_down_outlined,
                                                size: 35.0,
                                              ),
                                              Text("???????????????"),
                                            ],
                                          ),
                                  );
                                }).toList(),
                                onChanged: (city) {
                                  setState(() {
                                    _cityController.text = city;
                                    cityId = city;
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 4),
                // SizedBox(height: 10),
                //mobile
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            // padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String patttern = r'(^[(0-9)+-]*$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value.length == 0) {
                        return "???????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "????????????+-????????????????????????????????????????????????";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                // SizedBox(height: 10),
                //email
                //mobile
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            // padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _emailController,
                    // validator: mailcheck1(email),
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                        unemail = value;
                      });
                      mailcheck1(unemail);
                    },
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = new RegExp(pattern);
                      if (value.isEmpty) {
                        return "????????????????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "?????????????????????????????????????????????????????????";
                      } 
                      else if (mailcheck1(value) != null) {
                        return 'email already exists';
                      } 
                      else {
                        return null;
                      }
                    },
                    autocorrect: false,
                  ),
                ),
                // SizedBox(height: 10.0),

                //password
                //password
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '???????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: new BorderRadius.circular(5.0),
                  // ),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: Icon(Icons.visibility),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: _passwordController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      password_check = value;
                      if (value.isEmpty) {
                        return "??????????????????????????????";
                      } else if (value.length < 8) {
                        return "??????????????????8????????????????????????";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _obscureText,
                  ),
                ),
                //confirm_password
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 80,
                  child: TextFormField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                      ),
                      controller: _confirmController,
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      obscureText: _obscureText2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "????????????????????????????????????";
                        } else if (value != password_check) {
                          return "????????????????????????????????????";
                        } else {
                          return null;
                        }
                        ;
                      }),
                ),
                // SizedBox(height: 10),

                //password
                SizedBox(height: 10),
                // ignore: missing_required_param
                Container(
                    margin: new EdgeInsets.symmetric(horizontal: 120.0),
                    //  padding: const EdgeInsets.all(15.0),
                    child: new RaisedButton(
                      onPressed: _onRegisterButtonPressed,
                      child: new Text('??????'),
                    )),
              ])),
        );
      },
    );
    //form
  }
}

import 'package:borderlessWorking/bloc/getcountry/bloc/getcountry_bloc.dart';
import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/screens/register/fromdata.dart';
import 'package:borderlessWorking/screens/register/test_final.dart';
import 'package:borderlessWorking/screens/register/tets2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final GetcountryBloc _newsBloc = GetcountryBloc();
  int dropDownValue = 0;
  GlobalKey<FormState> _key = new GlobalKey();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _furiganaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final GlobalKey<FormFieldState> _confirmFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _mobileFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _furiganaFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();

  bool _validate = false;
  String name, birthday, furigana, email, mobile, password;

  bool _obscureText = true;
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _newsBloc.add(Getcountrylist());
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFf2f6ff)),
      home: new Scaffold(
        backgroundColor: Colors.blueGrey,
        // appBar: new AppBar(
        //   title: new Text('Register'),
        // ),
        body: new SingleChildScrollView(
          child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 80.0),
          child: Text(
            '求職者会員登録',
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
                '名前',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
          //   decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: new BorderRadius.circular(5.0),
          // ),
          // padding: const EdgeInsets.all(3.0),
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
            // maxLength: 32,
            validator: validatefullname,
            onSaved: (String val) {
              name = val;
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
                '名前(フリガナ)',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
            controller: _furiganaController,
            key: _furiganaFormKey,
            validator: validateName,
            onChanged: (value) {
              setState(() {
                _furiganaFormKey.currentState.validate();
              });
            },
            onSaved: (String val) {
              furigana = val;
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
                '生年月日',
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
            onSaved: (String val) {
              birthday = val;
            },
          ),
        ),

        // SizedBox(height: 10),

        //city
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            Column(children: [
              Text(
                '現住所',
                style: TextStyle(color: Colors.white),
              )
            ]),
          ]),
        ),
        SizedBox(height: 4),
        Container(
            child: Row(children: [
          Expanded(
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(right: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(5.0),
                width: 165,
                child: DropdownButton(
                  value: dropDownValue,
                  onChanged: (int newVal) {
                    setState(() {
                      dropDownValue = newVal;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('国・地域を選択'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('2'),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(5.0),
                width: 165,
                child: DropdownButton(
                  value: dropDownValue,
                  onChanged: (int newVal) {
                    setState(() {
                      dropDownValue = newVal;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('都市を選択'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('2'),
                    ),
                  ],
                ),
              )
            ]),
          )
        ])),
        // SizedBox(height: 10),
        //mobile
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            Column(children: [
              Text(
                '電話番号',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
              controller: _mobileController,
              key: _mobileFormKey,
              // maxLength: 10,
              validator: validateMobile,
              onChanged: (value) {
                setState(() {
                  _mobileFormKey.currentState.validate();
                });
              },
              onSaved: (String val) {
                mobile = val;
              }),
        ),

        // SizedBox(height: 10),
        //email
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            Column(children: [
              Text(
                'メールアドレス',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
              controller: _emailController,
              key: _emailFormKey,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onChanged: (value) {
                setState(() {
                  _emailFormKey.currentState.validate();
                });
              },
              onSaved: (String val) {
                email = val;
              }),
        ),
        // SizedBox(height: 10.0),

        //password
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            Column(children: [
              Text(
                'パスワード',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
            key: _passwordFormKey,
            validator: validatepassword,
            onChanged: (value) {
              setState(() {
                _passwordFormKey.currentState.validate();
              });
            },
            // validator: (String value) {
            //   password = value;
            //   if (value.isEmpty) {
            //     return "パスワードは必須です";
            //   } else if (value.length < 8) {
            //     return "パスワードは8文字以上必要です";
            //   } else {
            //     return null;
            //   }
            // },
            obscureText: _obscureText,
          ),
        ),
        // new FlatButton(
        //     onPressed: _toggle,
        //     child: new Text(_obscureText ? "Show" : "Hide")),

        // SizedBox(height: 10),
        //confirm_password
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            Column(children: [
              Text(
                'パスワード確認',
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
                    margin: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: Text(
                      '必要',
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
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: new BorderRadius.circular(5.0),
          // ),
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
            key: _confirmFormKey,
            validator: validateconfirm,
            onChanged: (value) {
              setState(() {
                _confirmFormKey.currentState.validate();
              });
            },
            obscureText: _obscureText2,
            // validator: (String value) {
            //   if (value.isEmpty) {
            //     // return "Please Re-Enter New Password";
            //     return null;
            //   }
            //   // if (value.length < 8) {
            //   //   return "パスワードが一致しません";
            //   // }
            //   if (value != password) {
            //     return "パスワードが一致しません";
            //   } else {
            //     return null;
            //   }
            // },
          ),
        ),
        //password
        SizedBox(height: 10),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('確認'),
        )
      ],
    );
  }

 

  String validatefullname(String value) {
    if (value.length == 0) {
      return "名前は必須です";
    }
    return null;
  }

  String validatepassword(String value) {
    password = value;
    if (value.isEmpty) {
      return "パスワードは必須です";
    } else if (value.length < 8) {
      return "パスワードは8文字以上必要です";
    } else {
      return null;
    }
  }

  String validateconfirm(String value) {
    if (value.isEmpty) {
      // return "Please Re-Enter New Password";
      return "パスワードが一致しません";
    }
    // if (value.length < 8) {
    //   return "パスワードが一致しません";
    // }
    if (value != password) {
      return "パスワードが一致しません";
    } else {
      return null;
    }
  }

  String validateName(String value) {
    String patttern = r'(^[\u30a0-\u30ff ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "名前（フリガナ）は必須です";
    } else if (!regExp.hasMatch(value)) {
      return "全角カタカナで入力してください";
    }
    return null;
  }

  // r'^\d+(?:\.\d+)?$'
  String validateMobile(String value) {
    String patttern = r'(^[(0-9)+-]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "電話番号は必須です";
    } else if (!regExp.hasMatch(value)) {
      return "半角数字+-スペースを使って入力してください";
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "メールアドレスは必須です";
    } else if (!regExp.hasMatch(value)) {
      return "メールアドレスの形式が正しくありません";
    } else {
      return null;
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print(password);
      //  BlocProvider<RegisterBloc>(
      //       create: (context) => RegisterBloc(registerRepository: null));
      //   Navigator.push(context, MaterialPageRoute(
      //     builder: (routeContext) => Fromdata(),
      //   ));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Formdata(
                name: name,
                birthday: birthday,
                furigana: furigana,
                mobile: mobile,
                email: email,
                password: password,
              )));
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

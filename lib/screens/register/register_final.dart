import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Formregister extends StatefulWidget {
  @override
  _FormregisterState createState() =>
      _FormregisterState();
}

class _FormregisterState extends State<Formregister> {
bool _validate = false;
  GlobalKey<FormState> _key = new GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey,
        //   leading: Padding(
        //     padding: const EdgeInsets.all(10.0),
        //   ),
        //   // title: Text("Confirm Screen"),
        // ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc()..add(InitialState()),
          // key: _key,
          // autovalidate: _validate,
          // child: Testing(),
          child: new Form(
              key: _key,
              autovalidate: _validate,
              child: Testing(),
            ),
        )
        );
  }
}

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  bool _validate = false;
  bool _btnEnabled = false;
  GlobalKey<FormState> _key = new GlobalKey();
   final GlobalKey<FormFieldState> _confirmFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _mobileFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _furiganaFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
 final TextEditingController _confirmController = TextEditingController();

  /////

  
  final _jobseekernameController = TextEditingController();
  final _jobseekerfuriganaController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 

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
 

  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          jobseeker_name: _jobseekernameController.text,
          jobseeker_furigana_name: _jobseekerfuriganaController.text,
          dob: _dobController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          password: _passwordController.text,
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
              child: ListView(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 20),
              child: Text(
                '確認',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                  validator: validatefullname,
                
              ),
            ),
            // SizedBox(height: 10),

            //furigana
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
                controller: _jobseekerfuriganaController,
                 key: _furiganaFormKey,
                  validator: validateName,
                  onChanged: (value) {
                    setState(() {
                      _furiganaFormKey.currentState.validate();
                    });
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
                controller: _dobController,
                
              ),
            ),

            // SizedBox(height: 10),

            //city

            SizedBox(height: 4),
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
                controller: _phoneController,
                validator: validateMobile,
                  key: _mobileFormKey,
                onChanged: (value) {
                  setState(() {
                    _mobileFormKey.currentState.validate();
                  });
                },
                
              ),
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
                 validator: validateEmail,
                 key: _emailFormKey,
              onChanged: (value) {
                setState(() {
                  _emailFormKey.currentState.validate();
                });
              },
                
              ),
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
              child: TextFormField(
                decoration: new InputDecoration(
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
                obscureText: _obscureText,
              ),
            ),

            // SizedBox(height: 10),

            //password
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
            key: _confirmFormKey,
            validator: validateconfirm,
            onChanged: (value) {
              setState(() {
                _confirmFormKey.currentState.validate();
              });
            },
            obscureText: _obscureText2,
          ),
        ),
            SizedBox(height: 10),
            // ignore: missing_required_param
            Container(
                margin: new EdgeInsets.symmetric(horizontal: 120.0),
                //  padding: const EdgeInsets.all(15.0),
                //  child: new RaisedButton(
                //   onPressed: _onRegisterButtonPressed,
                //   child: new Text('送信'),
                // )
                ),
          ])),
        );
      },
    );
    //form
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
  // _sendToServer() {
  //   if (_key.currentState.validate()) {
  //     // No any error in validation
      
  //   } else {
  //     // validation error
  //     setState(() {
  //       _validate = true;
  //     });
  //   }
  // }
}


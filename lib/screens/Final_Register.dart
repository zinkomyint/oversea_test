import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mstate extends StatefulWidget {
  @override
  _MstateState createState() => _MstateState();
}

class _MstateState extends State<Mstate> {
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
  String password_check;
  final TextEditingController _confirmController = TextEditingController();
  final _jobseekernameController = TextEditingController();
  final _jobseekerfuriganaController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
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
                    '求職者会員新規登録',
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return '名前は必須です';
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
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String patttern = r'(^[\u30a0-\u30ff ]*$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value.isEmpty) {
                        return "名前（フリガナ）は必須です";
                      } else if (!regExp.hasMatch(value)) {
                        return "全角カタカナで入力してください";
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
                        return "電話番号は必須です";
                      } else if (!regExp.hasMatch(value)) {
                        return "半角数字+-スペースを使って入力してください";
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
                    controller: _emailController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = new RegExp(pattern);
                      if (value.isEmpty) {
                        return "メールアドレスは必須です";
                      } else if (!regExp.hasMatch(value)) {
                        return "メールアドレスの形式が正しくありません";
                      } else {
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
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                      validator: (value) {
                            password_check = value;
                            if (value.isEmpty) {
                              return "パスワードは必須です";
                            } else if (value.length < 8) {
                              return "パスワードは8文字以上必要です";
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
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
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
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      obscureText: _obscureText2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "パスワードが一致しません";
                        }
                        else if(value != password_check) {
                          return "パスワードが一致しません";
                        } else {
                          return null;
                        }
                        ;
                      }
                      ),
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
                      child: new Text('送信'),
                    )),
              ])),
        );
      },
    );
    //form
  }
}

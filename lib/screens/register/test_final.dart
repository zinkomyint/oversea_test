import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Formdata extends StatefulWidget {
  String name, birthday, furigana, mobile, email, password;
  Formdata({
    this.name,
    this.birthday,
    this.furigana,
    this.mobile,
    this.email,
    this.password,
  });
  @override
  _FormdataState createState() =>
      _FormdataState(name, birthday, furigana, mobile, email, password);
}

class _FormdataState extends State<Formdata> {
  String name, birthday, furigana, mobile, email, password;

  _FormdataState(this.name, this.birthday, this.furigana, this.mobile,
      this.email, this.password);

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
          child: Testing(this.name, this.birthday, this.furigana, this.mobile,
              this.email, this.password),
        ));
  }
}

class Testing extends StatefulWidget {
  String name, birthday, furigana, mobile, email, password;
  Testing(this.name, this.birthday, this.furigana, this.mobile, this.email,
      this.password);
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
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
    _jobseekernameController.text = widget.name;
    _jobseekerfuriganaController.text = widget.furigana;
    _dobController.text = widget.birthday;
    _phoneController.text = widget.mobile;
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
              ),
            ),

            // SizedBox(height: 10),
            //email
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(children: [
                Column(children: [
                  Text(
                    'ご担当者様メールアドレス',
                    style: TextStyle(color: Colors.white),
                  )
                ]),
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
                readOnly: true,
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
                readOnly: true,
                obscureText: _obscureText,
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

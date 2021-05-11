import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:borderlessWorking/data/repositories/register_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Fromdata extends StatefulWidget {
  final RegisterRepository registerRepository;

  String name, birthday, furigana, mobile, email, password;
  Fromdata(
      {this.name,
      this.birthday,
      this.furigana,
      this.mobile,
      this.email,
      this.password,
      this.registerRepository});
  @override
  _FromdataState createState() =>
      _FromdataState(name, birthday, furigana, mobile, email, password);
}

class _FromdataState extends State<Fromdata> {
  TextEditingController textController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String name, birthday, furigana, mobile, email, password;
  var _username,test;

  RegisterRepository registerRepository;
  _FromdataState(this.name, this.birthday, this.furigana, this.mobile,
      this.email, this.password);
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // final _jobseekernameController = TextEditingController();
  // final _jobseekerfuriganaController = TextEditingController();
  // final dobController = TextEditingController();
  // final _phoneController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // //  TextEditingController _nameController = new TextEditingController();

  // final GlobalKey<FormFieldState> _nameFormKey = GlobalKey<FormFieldState>();
    // void _loginButton({String name}) {
    // // print("Login from Page");
    // this._username = name;
    //    print(_username);
    // }
  @override
    void initState() {
    super.initState();
    // _nameController = new TextEditingController(text: name);
    // _jobseekernameController.text=name;
  }

  Widget build(BuildContext context) {
 
    // _onRegisterButtonPressed() {
    //   BlocProvider.of<RegisterBloc>(context).add(
    //     RegisterButtonPressed(
    //       jobseeker_name: _jobseekernameController.text,
    //       jobseeker_furigana_name: _jobseekerfuriganaController.text,
    //       dob: birthday,
    //       phone: mobile,
    //       email: email,
    //       password: password,
    //     ),
    //   );
    // }
  
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
          ),
          title: Text("Confirm Screen"),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc()..add(InitialState()),
          child:ContactDetail(),
        )
        );


  }
}

class ContactDetail extends StatefulWidget {
  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final _jobseekernameController = TextEditingController();
  final _jobseekerfuriganaController = TextEditingController();
  final dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          jobseeker_name: _jobseekernameController.text,
          jobseeker_furigana_name: _jobseekerfuriganaController.text,
          dob: dobController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
     //form
        return BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
           if(state is RegisterFailure)
           {
              Scaffold.of(context).showSnackBar(
              SnackBar(
              content: Text(state.error),
            ),
          );
           }
          },
          builder: (context, state) {
            return Container(
              child: Form(child: 
               ListView(
                 children:[
                   TextFormField(
                     controller: _jobseekernameController,
                   ),
                    TextFormField(
                     controller: _jobseekerfuriganaController,
                   ),
                    TextFormField(
                     controller: _phoneController,
                   ),
                   TextFormField(
                     controller: _emailController,
                   ),
                    TextFormField(
                     controller: _passwordController,
                   ),
                   RaisedButton(onPressed: onRegisterButtonPressed,child: Text('Register'),)
                 ]
               )
              ),
            );
          },
        );
        //form
  }
}
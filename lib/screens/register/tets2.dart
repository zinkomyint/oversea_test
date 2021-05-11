import 'package:flutter/material.dart';


class ConfirmScreen extends StatefulWidget {
  // ConfirmScreen({Key key}) : super(key: key);
  String name,birthday, furigana,mobile,email,password;
  ConfirmScreen({this.name,this.birthday,this.furigana,this.mobile,this.email,this.password});
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState(name,birthday, furigana,mobile,email,password);
}

class _ConfirmScreenState extends State<ConfirmScreen> {
 final _formkey = GlobalKey<FormState>();
String name,birthday, furigana,mobile,email,password,job, age;
 _ConfirmScreenState(this.name,this.birthday,this.furigana,this.mobile,this.email,this.password);
   bool _obscureText = true;

  // Toggles the password show status
  // ignore: unused_element
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formkey,
              // autovalidate: _validate,
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
            '確認',
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
             initialValue: this.name,
           
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
             initialValue: this.furigana,
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
             initialValue: this.birthday,
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
               initialValue: this.mobile,
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
               initialValue: this.email,
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
               initialValue: this.password,
                 obscureText: _obscureText,
          ),
        ),

        // SizedBox(height: 10),
   
        //password
        SizedBox(height: 10),
        // ignore: missing_required_param
        new RaisedButton(
          // onPressed: _sendToServer,
          child: new Text('確認'),
        )
      ],
    );
  }

  

}

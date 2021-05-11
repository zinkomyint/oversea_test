import 'package:flutter/material.dart';

class Homestack extends StatefulWidget {
  @override
  _HomestackState createState() => _HomestackState();
}

class _HomestackState extends State<Homestack> {

  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  Map<String,String> _CountryState = {
    "AAA":"A",
    "BBB":"B",
    "CCC":"C",
    "DDD":"D"
  };

  Map<String,String> _navigate = {
    "aa":"/abcPage",
    "BB":"/defPage"
  };

  List<String> _state =[];

  String _selectedLocation;
  String _selectedState;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Scaffold(
            body:Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Select a Country",style: TextStyle(fontWeight: FontWeight.bold),),
                    DropdownButton(
                      key: Key("Country"),
                      hint: Text('Please choose a Country'),
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _CountryState.forEach((k,v){
                            print("${k} and ${v}" );
                            _state.clear();
                            if(v==newValue){
                              _state.add(k);
                            }
                          });
                          _selectedLocation = newValue;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Select a State",style: TextStyle(fontWeight: FontWeight.bold),),

                        DropdownButton(
                          key: Key("state"),
                          hint: Text('Please choose a State'),
                          value: _selectedState,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedState = newValue;
                            });
                          },
                          items: _state.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: (){
                            Navigator.pushNamed(context,_navigate[_selectedState] );
                          },
                          child: new Text("OK"),
                        ),
                      ],
                    )
                  ],
                )
            )
        )
    );

  }
}

class abcPage extends StatefulWidget {
  @override
  _abcPageState createState() => _abcPageState();
}

class _abcPageState extends State<abcPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Colors.green,
        ));
  }
}

class defPage extends StatefulWidget {
  @override
  _defPageState createState() => _defPageState();
}

class _defPageState extends State<defPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
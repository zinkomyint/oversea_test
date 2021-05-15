
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
      
class Country4 extends StatefulWidget {
  @override
  _Country4State createState() => _Country4State();
}

class _Country4State extends State<Country4> {
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  String dropdownValue;
  String _selectcity;
  List<dynamic> _dataCountry = List(), _dataCity = List();
  void getcity(String idProvince) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = test;
    });
    print("Data City : $test");
  }

  void getcountry() async {
    final test = await _getcountryRepository.getcountry();
    setState(() {
      _dataCountry = test;
    });
    print("Data City : $test");
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcountry();
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

  Widget _buildList()
  {
    return Column(
      children: [
          Container(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Select country"),
                      value: dropdownValue,
                      items: _dataCountry.map((cname) {
                        return DropdownMenuItem(
                          child: Text(cname.country_name),
                          value: cname.country_name,
                        );
                      }).toList(),
                      onChanged: (cname) {
                        setState(() {
                          dropdownValue = cname;
                          print("ddeee $cname");
                          _selectcity = null;
                        });
                        getcity(cname);
                      },
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
      ],
    );
  }
  
}
  


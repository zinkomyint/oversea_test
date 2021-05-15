import 'dart:convert';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String baseUrl = Apis.mailURL + Apis.country_list ;
  String _valProvince, _valCity;
  List<dynamic> _dataProvince = List(), _dataCity = List();


  void getProvince() async {
    final response = await http.get(baseUrl + "getProvince1"); //untuk melakukan request ke webservice
    var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
    setState(() {
      _dataProvince = listData; // dan kita set kedalam variable _dataProvince
    });
    print("Data Province : $listData");
  }


  void getCity(String idProvince)async{
    final response = await http.post(baseUrl + "getCity",body: {
      'id' : idProvince
    });

    var listData = jsonDecode(response.body);
    setState(() {
      _dataCity = listData;
    });
    print("Data City : $listData");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvince();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Bercabang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Silahkan pilih provinsi tujuan"),

            DropdownButton(
              hint: Text("Select Province"),
              value: _valProvince,
              items: _dataProvince.map((item){
                return DropdownMenuItem(
                  child: Text(item['province']),
                  value: item['id'],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _valProvince = value;
                  _valCity = null;
                });
                getCity(value);
              },
            ),


            Text("Silahkan pilih kota tujuan"),
            DropdownButton(
              hint: Text("Select City"),
              value: _valCity,
              items: _dataCity.map((item){
                return DropdownMenuItem(
                  child: Text("${item['type']} ${item['city']}"),
                  value: item['id'],
                );
              }).toList(),
              onChanged: (value) {
               setState(() {
                 _valCity = value;
               });
              },
            ),

          ],
        ),
      ),
    );
  }
}
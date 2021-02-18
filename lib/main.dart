import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "simple interest calculate",
    debugShowCheckedModeBanner: false,
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees'];
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: [
                getImageAsset(),

                //Principal
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalControlled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter Principal amount';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter a amount',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),

                //Rate of Interest
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiControlled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'In Percentage',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        //
                        Expanded(
                          child: TextFormField(
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            controller: termControlled,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Time';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in Years',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),

                        Container(
                          width: 25.0,
                        ),

                        Expanded(
                            child: DropdownButton(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),

                //calculate button
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(children: [
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formkey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturn();
                            }
                          });
                        },
                      ),
                    ),
                    // reset button
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/Si.jpg");
    Image image = Image(image: assetImage, width: 500.0, height: 120.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double totalAmountPaybale = principal + (principal * roi * term) / 100;
    String result =
        'After $term years,your investment will be worth $totalAmountPaybale $_currentItemSelected';
    return result;
  }

  void reset() {
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}

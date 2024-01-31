import 'package:firebase_crud/model/details.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  var fullName = TextEditingController();
  var mobileNumber = TextEditingController();
  var buildingName = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text("Registration",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 6),
                child: Text("Add User Details",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    fontFamily: "sans-serif-condensed-light"),),
              ),
              SizedBox(height: 10,),
              Card(
                shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                elevation: 10,
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(alignment: Alignment.topLeft,
                          child: Text("User Info :",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontFamily: "sans-serif-condensed-light"),),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                            controller: fullName,
                            cursorColor: Color(0xffF67952),
                            decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: TextStyle(color: Color(0xffF67952)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                            )
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: mobileNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color(0xffF67952)),
                              labelText: "Mobile Number",
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    )
                ) ,
              ),
              SizedBox(height: 30,),
              Card(
                shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                elevation: 10,
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(alignment: Alignment.topLeft,
                          child: Text("Address Info :",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontFamily: "sans-serif-condensed-light"),),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                            controller: buildingName,
                            cursorColor: Color(0xffF67952),
                            decoration: InputDecoration(
                                labelText: "Building Name/Flat no/Door no ",
                                labelStyle: TextStyle(color: Color(0xffF67952)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                            )
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: street,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color(0xffF67952)),
                              labelText: "Street / Area / Locality",
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                            controller: city,
                            cursorColor: Color(0xffF67952),
                            decoration: InputDecoration(
                                labelText: "City / Village ",
                                labelStyle: TextStyle(color: Color(0xffF67952)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                            )
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 160,
                              child: TextField(
                                  controller: pinCode,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xffF67952),
                                  decoration: InputDecoration(
                                      labelText: "Pin Code",
                                      labelStyle: TextStyle(color: Color(0xffF67952)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                  )
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: TextField(
                                  controller: state,
                                  cursorColor: Color(0xffF67952),
                                  decoration: InputDecoration(
                                      labelText: "State",
                                      labelStyle: TextStyle(color: Color(0xffF67952)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],

                    )
                ) ,
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () async{
                    String id = randomAlphaNumeric(10);
                    if(fullName.text.isNotEmpty && mobileNumber.text.isNotEmpty && buildingName.text.isNotEmpty && street.text.isNotEmpty && state.text.isNotEmpty && pinCode.text.isNotEmpty && city.text.isNotEmpty ){
                      var userInfo = UserDetails(id: id,fullName: fullName.text, mobileNumber: mobileNumber.text, buildingName: buildingName.text, street: street.text, state: state.text, pinCode: pinCode.text, city: city.text);
                      await FirebaseMethods().addUserDetails(userInfo, id).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Added Successfully")));
                      });
                      fullName.clear();
                      mobileNumber.clear();
                      buildingName.clear();
                      street.clear();
                      city.clear();
                      pinCode.clear();
                      state.clear();

                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter All the Details")));
                    }

                  },
                  child: Text(
                    "Click to add user",
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans-serif-condensed-light"),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

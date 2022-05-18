// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:attendence_management_system/pages/bottomNavBar.dart';
import 'package:attendence_management_system/theme/colors.dart';
import 'package:attendence_management_system/utils/names.dart';
import 'package:attendence_management_system/utils/foodItems.dart';
import 'package:attendence_management_system/utils/userPrefrences.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'package:http/http.dart' as http;

class AttendencePage extends StatefulWidget {
  const AttendencePage({Key? key}) : super(key: key);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class Menu {
  final columns;
  final data;

  Menu({required this.columns, required this.data});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      columns: json['columns'],
      data: json['data'],
    );
  }
}

Future<Menu> fetchMenu() async {
  final response = await http.get(Uri.parse('http://34.220.11.28/menu'));

  if (response.statusCode == 200) {
    // print(response.body);
    print(json.decode(response.body));
    return Menu.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class _AttendencePageState extends State<AttendencePage> {
  late Future<Menu> futureMenu;

  @override
  void initState() {
    super.initState();
    futureMenu = fetchMenu();
  }

  final studentvar = UserPrefrences.studentlist;
  final mealvar = UserPrefrences.mealList[2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Attendence"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              "Select the items you're interested to take today",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 550,
            width: 400,
            // color: Colors.orange,
            child: new ListView.builder(
                // itemCount: mealvar.mealAvailable.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildAttendenceCard(context, index)),
            // ListTile(

            // )),
          ),
          SizedBox(
            height: 25,
          ),
          //
          //
          //
          ElevatedButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Submit Attendence?'),
                // content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {
                      ResetState(),
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginNavScreen()),
                          (route) => false)
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            child: const Text('Submit'),
            style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
          ),
          // ElevatedButton(
          //     onPressed: () => {
          //       AlertDialog(
          //         title: Text("Submit Attendence?"),
          //         actions: [

          //         ],
          //       )
          //     },
          //     child: Text(
          //       "Submit",
          //       style: TextStyle(fontSize: 15),
          //     ),
          // style: ElevatedButton.styleFrom(
          //   shape: new RoundedRectangleBorder(
          //       borderRadius: new BorderRadius.circular(10.0)),
          //   fixedSize: Size(400, 60),
          // )),
        ],
      ),
    );
  }

  buildAttendenceCard(BuildContext context, int index) {
    var index2 = index + 1;

    return FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.75,
        duration: Duration(milliseconds: 350),
        animateMenuItems: true,
        onPressed: () {
          setState(() {
            ChangeState(isSelectedList, index, 1);
            ChangeColor(isSelectedList, index);
          });
          // Navigator.of(this.context).push(
          // MaterialPageRoute(builder: (context) => ProfilePage()),
          // );
        },
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text(
                "Present",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              onPressed: () {
                setState(() {
                  ChangeState(isSelectedList, index, 1);
                  ChangeColor(isSelectedList, index);
                });
                // Navigator.of(this.context).push(
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );
              },
              backgroundColor: green),
          //00CE2D
          FocusedMenuItem(
              title: Text(
                "Absent",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              onPressed: () {
                setState(() {
                  ChangeState(isSelectedList, index, 0);
                  ChangeColor(isSelectedList, index);
                });
                // Navigator.of(this.context).push(
                //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                // );
              },
              backgroundColor: red),
          FocusedMenuItem(
              title: Text(
                "Leave",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  ChangeState(isSelectedList, index, 2);
                  ChangeColor(isSelectedList, index);
                });
                // Navigator.of(this.context).push(
                //   MaterialPageRoute(builder: (context) => ChangePassword()),
                // );
              },
              backgroundColor: yellow)
        ],
        child: new Container(
          child: Card(
            color: attendencecolor[index],
            elevation: 2,
            shadowColor: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(10.0),

              // child: Row(
              //   children: <Widget>[
              //     Text(
              //       index2.toString(),
              //       style: TextStyle(fontSize: 20),
              //     ),
              //     SizedBox(
              //       width: 25,
              //     ),
              //     Text(
              //       mealvar.mealAvailable[index],
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ],
              // ),

              child: FutureBuilder<Menu>(
                future: futureMenu,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (index < 18)
                      return Text(snapshot.data!.data[index].toString());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // print(snapshot.data);
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ));
  }

  void ChangeState(List<int> isSelectedList, int value, int i) {
    isSelectedList[value] = i;
  }

  void ResetState() {
    for (int state = 0; state < attendencecolor.length; state++) {
      attendencecolor[state] = Colors.white;
    }
  }

  void ChangeColor(List<int> isSelectedList, int index) {
    if (isSelectedList[index] == 1) {
      attendencecolor[index] = green;
      // print("changed to : "+ isSelectedList.toString());
    } else {
      if (isSelectedList[index] == 2) {
        attendencecolor[index] = yellow;
        // print("changed to : "+ isSelectedList.toString());
      } else {
        attendencecolor[index] = red;
        // print("changed to : "+ isSelectedList.toString());
      }
    }
  }
}

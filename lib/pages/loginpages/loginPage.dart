import 'package:attendence_management_system/pages/attendencepages/attendencedropdown1.dart';
import 'package:attendence_management_system/pages/bottomNavBar.dart';
import 'package:attendence_management_system/pages/loginpages/forgetpass.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginNavScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // height: 250,
                  // width: 300,
                  child: Image.asset(
                      /*'assets/images/a2e00219-0473-458c-a589-ace1758f609c.png'*/
                      'assets/LogoLoginPage.png'),
                ),
                //),
                //),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(13),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 400,
                  width: 380,
                  decoration: BoxDecoration(
                      //border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            color: Colors.grey.shade400),
                        //Offset: Offset(0, 2),
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        const Text(
                          'Sign In',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            color: Color.fromARGB(255, 6, 0, 79),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@geu.ac.in")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              labelText: 'Email ID',
                              hintText: 'Enter your Email ID'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Admission Number',
                            hintText: 'Admission Number',
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 14)),
                        Center(
                          child: ElevatedButton(
                            onPressed: _trySubmitForm,
                            child: Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15),
                              ),
                              primary: (Color.fromRGBO(6, 0, 79, 1)),
                              fixedSize: Size(300, 60),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //void setState(Null Function() param0) {}
}

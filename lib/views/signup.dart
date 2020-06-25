import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:quizzify/services/auth.dart';
import 'package:quizzify/views/signin.dart';
import 'package:quizzify/widgets/widgets.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password Is Required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name Is Required'),
  ]);

  final _formKey = GlobalKey<FormState>();

  String name, email, password;

  AuthService authService = new AuthService();

  bool isLoading = false;

  Register() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((val) {
        if (val != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: appBar(context),
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: RefreshProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: 650,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 30),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1D3557))),
                          TextSpan(
                              text: 'In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE63946))),
                        ],
                      ),
                    ),
                    TextFormField(
                      validator: nameValidator,
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    TextFormField(
                      validator: EmailValidator(
                          errorText: 'enter a valid email address'),
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    TextFormField(
                      validator: passwordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Register();
                        },
                    child: pageButton(context: context, label: "Register")
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already Have An Account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Login ",
                            style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

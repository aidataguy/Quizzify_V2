import 'package:flutter/material.dart';
import 'package:quizzify/services/auth.dart';
import 'package:quizzify/views/signup.dart';
import 'package:quizzify/widgets/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password Is Required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email Is Required'),
    PatternValidator(r'(?=.*?[@])',
        errorText: 'Invalid Email you shall have @ in email address')
  ]);

  final _formKey = GlobalKey<FormState>();

  String email, password;

  AuthService authService = new AuthService();

  bool isLoading = false;

  Login() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authService.signInEmailAndPassword(email, password).then((val) {
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
                height: 600,
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
                      validator: emailValidator,
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
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Login();
                      },
                      child: pageButton(context: context, label: "LOGIN")
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't Have An Account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Register ",
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

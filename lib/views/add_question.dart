import 'package:flutter/material.dart';
import 'package:quizzify/views/home.dart';
import 'package:quizzify/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  String question, option1, option2, option3, option4;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          color: Color(0xFFE63946),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Image Url Canot Be empty..." : null,
                      decoration: InputDecoration(
                          hintText: "Question",
                          hintStyle: TextStyle(color: Colors.black87)),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Image Title Canot Be empty..." : null,
                      decoration: InputDecoration(
                          hintText: "Option 1",
                          hintStyle: TextStyle(color: Colors.black87)),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Image Title Canot Be empty..." : null,
                      decoration: InputDecoration(
                          hintText: "Option 2(correct answer) ",
                          hintStyle: TextStyle(color: Colors.black87)),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Image Title Canot Be empty..." : null,
                      decoration: InputDecoration(
                          hintText: "Option 3 ",
                          hintStyle: TextStyle(color: Colors.black87)),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Image Title Canot Be empty..." : null,
                      decoration: InputDecoration(
                          hintText: "Option 4 ",
                          hintStyle: TextStyle(color: Colors.black87)),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(children: <Widget>[
                      GestureDetector(
                      onTap: () {
                        // createQuiz();
                      },
                      child: pageButton(
                          context: context,
                          label: "Submit",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 80),
                    ),
                    SizedBox(width: 24,),
                    GestureDetector(
                      onTap: () {
                        // createQuiz();
                      },
                      child: pageButton(
                          context: context,
                          label: "Add Question",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 50),
                    ),
                    ],)
                    
                  ],
                ),
              ),
      ),
    );
  }
}

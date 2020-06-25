
import 'package:flutter/material.dart';
import 'package:quizzify/services/database.dart';
import 'package:quizzify/views/add_question.dart';
import 'package:quizzify/views/home.dart';
import 'package:quizzify/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  String quizImageUrl, quizTitle, quizDescription , quizId;
  DatabaseService databaseService = new DatabaseService();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  createQuiz() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      quizId = randomAlphaNumeric(20);
      Map<String , String> quizMap = {
        "quizId": quizId,
        "quizImageUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value){
          setState(() {
            isLoading = false;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestion()));
          });
      });
      
    }
  }

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

        child: isLoading ? Container(
          child: Center(child: CircularProgressIndicator(),),
        ) : Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Image Url Canot Be empty..." : null,
                decoration: InputDecoration(
                hintText: "Upload Image URl",
                hintStyle: TextStyle(color: Colors.black87)),
                onChanged: (val){
                  quizImageUrl = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Image Title Canot Be empty..." : null,
                decoration: InputDecoration(
                hintText: "Quiz Title",
                hintStyle: TextStyle(color: Colors.black87)),
                onChanged: (val){
                  quizTitle = val;
                },
              ),

              TextFormField(
                validator: (val) => val.isEmpty ? "Image Title Canot Be empty..." : null,
                decoration: InputDecoration(
                hintText: "Quiz Description",
                hintStyle: TextStyle(color: Colors.black87)),
                onChanged: (val){
                  quizDescription = val;
                },
              ),
              Spacer(),

              GestureDetector(
                      onTap: () {
                        createQuiz();
                      },
                      child: pageButton(context: context, label: "Create Quiz")
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

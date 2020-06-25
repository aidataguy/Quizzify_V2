import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: Color(0xFF1D3557))),
        TextSpan(
            text: 'zify',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFE63946))),
      ],
    ),
  );
}

Widget pageButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    height: 50,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 35,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Color(0xFFE63946), borderRadius: BorderRadius.circular(17)),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFf1faee),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

InputDecoration getAuthInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white10,
    filled: true,
    focusColor: Colors.white70,

    contentPadding: EdgeInsets.fromLTRB(16,8,16,8),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.lightBlue, width: 2)
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2)
    )
  );
}
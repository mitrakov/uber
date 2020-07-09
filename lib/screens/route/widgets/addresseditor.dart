import 'package:flutter/material.dart';

class AddressEditor extends StatelessWidget {
  final String hint;

  const AddressEditor(this.hint, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Aaaa",
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
        hintText: hint,
      ),
    );
  }
}

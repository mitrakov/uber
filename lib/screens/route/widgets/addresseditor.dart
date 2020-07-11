import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class AddressEditor extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  AddressEditor(this.label, this.onChanged, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        EasyDebounce.debounce("addr-editor", Duration(milliseconds: 500), () => onChanged(text));
      },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
        hintText: "Search address",
      ),
    );;
  }
}

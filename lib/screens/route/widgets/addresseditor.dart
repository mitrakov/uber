import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class AddressEditor extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  AddressEditor(this.label, this.onChanged, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: TextField(
        style: TextStyle(fontSize: 14),
        onChanged: (text) {
          EasyDebounce.debounce("addr-editor", Duration(milliseconds: 500), () => onChanged(text));
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          isDense: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 6),
          hintText: "Search address",
        ),
      ),
    );
  }
}

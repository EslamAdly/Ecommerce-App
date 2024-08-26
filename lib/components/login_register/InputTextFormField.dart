import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  InputTextFormField(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.errorText,
      required this.icons,
        this.validator,})
      : super(key: key);
  TextEditingController textController;
  String hintText;
  String errorText;
  IconData icons;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
            filled: true,
            fillColor:  Color(0xd3d3d3),
            hintText: hintText,
            prefixIcon: Icon(
              icons,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.grey))),
        validator: validator,
      ),
    );
  }
}

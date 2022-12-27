import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({Key? key ,this.hint ,this.obscureText, this.onChanged}) : super(key: key);

  String? hint;
  bool? obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscureText!,
      onChanged: onChanged,
      validator: (data){
        if(data!.isEmpty){
          return 'Field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}

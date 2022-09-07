import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  bool isClickable = true,
  onTap,
  validator,
}) =>
    TextFormField(
      
      validator: validator,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );

    Widget defaultTextButton({
  required function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField2({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  required  validate,
  required String label,
  required IconData prefix,
  suffix,
  suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

    Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUpperCase = true,
  double radius = 3.0,
  required  function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
    
  enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
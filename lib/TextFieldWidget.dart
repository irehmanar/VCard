import 'package:flutter/material.dart';
import 'GlobalAppColor.dart';

class MainTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color backgroundColor;
  final TextInputAction textInputAction;
  final Color textColor;
  final bool isReadOnly;
  bool showAsterisk;
  bool isTextCapitalization;
  bool isSentenceCapitalization;
  final String placeHolder;
  final Function(String)? onChanged; // New parameter for onChanged callback

  MainTextFieldWidget({
    required this.controller,
    required this.keyboardType,
    this.backgroundColor = AppColours.textFieldColour,
    this.textColor = Colors.white,
    required this.isReadOnly,
    required this.textInputAction,
    required this.showAsterisk,
    required this.placeHolder,
    this.onChanged,
    this.isTextCapitalization = false,
    this.isSentenceCapitalization = false,
  });

  @override
  State<MainTextFieldWidget> createState() => _MainTextFieldWidgetState();
}

class _MainTextFieldWidgetState extends State<MainTextFieldWidget> {
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    // Check if the initial text of the controller is empty
    isTextFieldEmpty = widget.controller.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    bool shouldShowAsterisk = widget.showAsterisk &&
        widget.keyboardType != TextInputType.emailAddress;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          // height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Center(
              child: TextFormField(
                textInputAction: widget.textInputAction,
                onChanged: (value) {
                  setState(() {
                    // Update the state based on the text field content
                    widget.showAsterisk = value.isEmpty;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(value); // Call the onChanged callback if it is not null
                  }
                },
                textCapitalization:
                (widget.keyboardType == TextInputType.emailAddress || widget
                    .isTextCapitalization)
                    ? widget.isSentenceCapitalization? TextCapitalization
                    .sentences : TextCapitalization.none
                    : TextCapitalization.words,
                readOnly: widget.isReadOnly,
                controller: widget.controller,
                style: TextStyle(color: widget.textColor),
                keyboardType: widget.keyboardType,
                cursorColor: widget.textColor,
                decoration: InputDecoration(
                  hintText: widget.placeHolder,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  labelStyle: TextStyle(color: widget.textColor),
                  border: InputBorder.none,
                ),
                maxLines: 5,
                minLines: 1,
              ),
            ),
          ),
        ),
        if (shouldShowAsterisk)
          Positioned(
            right: 10,
            top: 5,
            child: Text(
              '*',
              style: TextStyle(
                color: Color(0xFFFF5757),
                fontSize: 24,
              ),
            ),
          ),
      ],
    );
  }
}
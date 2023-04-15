import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ICTextField extends StatefulWidget {
  final String hint, prefix, label;
  final int max;
  final bool suffixicon;
  final bool enabled;
  final TextInputType keyboard;
  final bool isprefix;
  final bool ispreicon;
  final IconData preicon;
  final Widget prefixedIcon;
  final bool ispass;
  final bool isvisible;
  final bool istheme;
  final double padd;
  final bool obs;
  final bool islabel;
  final bool autofocus;
  final VoidCallback passontap;
  final VoidCallback ontap;
  final ValueChanged onchage;
  final ValueChanged onsubmit;
  final TextEditingController controller;
  static _defaultFunction() {}
  static _otap() {}
  static _onchageFunction(o) {}
  static _onsubmit(o) {}
  const ICTextField(
      {Key? key,
      this.hint = '',
      this.prefix = '',
      this.padd = 13,
      this.autofocus = false,
      this.obs = false,
      this.enabled = true,
      this.suffixicon = false,
      this.istheme = false,
      this.label = '',
      this.ispass = false,
      this.onsubmit = _onsubmit,
      this.isvisible = false,
      this.prefixedIcon = const SizedBox(),
      this.passontap = _defaultFunction,
      this.ontap = _otap,
      this.onchage = _onchageFunction,
      this.preicon = Icons.person,
      this.ispreicon = false,
      this.isprefix = false,
      this.islabel = false,
      this.max = 500,
      required this.controller,
      this.keyboard = TextInputType.text})
      : super(key: key);

  @override
  State<ICTextField> createState() => _ICTextFieldState();
}

class _ICTextFieldState extends State<ICTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8.sp,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
          child: TextField(
            onSubmitted: (o) {
              widget.onsubmit(o);
            },
            autofocus: widget.autofocus,
            onTap: widget.ontap,
            obscureText: widget.obs ? true : false,
            focusNode: widget.enabled ? FocusNode() : AlwaysDisabledFocusNode(),
            controller: widget.controller,
            keyboardType: widget.keyboard,
            inputFormatters: <TextInputFormatter>[
              if (widget.max == 10 || widget.max == 6 || widget.max == 3)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            maxLength: widget.max,
            cursorColor: Get.theme.primaryColor,
            cursorWidth: 2,
            onChanged: (o) {
              // setState(() {
              widget.onchage(o);
              // });
            },
            style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    letterSpacing: .8)),
            decoration: InputDecoration(
              suffixIcon: widget.ispass
                  ? InkWell(
                      onTap: widget.passontap,
                      child: Icon(!widget.isvisible
                          ? Icons.visibility_off
                          : Icons.visibility))
                  : null,
              counterText: '',
              label: Text(
                widget.hint,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        fontSize: 11.5.sp,
                        color: Colors.grey,
                        letterSpacing: .8)),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              floatingLabelBehavior: widget.islabel
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.never,
              labelStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontSize: 11.sp, color: Colors.black, letterSpacing: .8)),
              hintStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontSize: 11.sp, color: Colors.grey, letterSpacing: .8)),
              hintText: widget.label,
              prefixIcon: !widget.ispreicon
                  ? widget.prefixedIcon
                  : Icon(widget.preicon,
                      color: widget.ispreicon
                          ? Colors.grey[400]
                          : Colors.grey[400]),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: widget.istheme
                        ? Get.theme.primaryColor
                        : Get.theme.primaryColor,
                    width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.all(widget.padd.sp),
            ),
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

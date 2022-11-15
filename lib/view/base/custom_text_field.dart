import 'package:flutter/material.dart';
import 'package:new_camelclub/provider/language_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/utill/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final Color? hintTextColor;
  final int? maxLines;
  final int? maxLength;
  final bool? isPassword;
  final bool? isCountryPicker;
  final bool hasUnderLineBorder;
  final bool? hasBorder;
  final bool? isShowBorder;
  final bool? isIcon;
  final bool defultFont;
  final bool? isShowSuffixIcon;
  final bool? isReadOnly;
  final bool? isShowPrefixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Function? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool? isSearch;
  final Function? onSubmit;
  final bool? isEnabled;
  final TextCapitalization? capitalization;
  final LanguageProvider? languageProvider;

  CustomTextField(
      {this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.isReadOnly = false,
      this.defultFont = true,
      this.hintTextColor = Colors.black26,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.maxLength = 50,
      this.onSuffixTap,
      this.fillColor,
      this.hasBorder = false,
      this.hasUnderLineBorder = false,
      this.onSubmit,
      this.onChanged,
      this.capitalization = TextCapitalization.none,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
      this.onTap,
      this.isIcon = false,
      this.isPassword = false,
      this.suffixIconUrl,
      this.prefixIconUrl,
      this.isSearch = false,
      this.languageProvider});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: widget.defultFont
          ? medium.copyWith(color: Colors.black, fontSize: 12)
          : null,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly!,
      maxLength: widget.maxLength,

      autofocus: false,
      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      // inputFormatters: widget.inputType == TextInputType.phone
      //     ? <TextInputFormatter>[
      //         FilteringTextInputFormatter.allow(RegExp('[0-9]'))
      //       ]
      //     : null,

      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
        // contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.hasUnderLineBorder
                  ? Colors.black12
                  : Colors.transparent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.hasUnderLineBorder
              ? Colors.black12
              : Colors.transparent),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.hasUnderLineBorder
              ? Colors.black12
              : Colors.transparent),
        ),

        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor != null
            ? widget.fillColor
            : Theme.of(context).accentColor,
        hintStyle: book.copyWith(color: widget.hintTextColor, fontSize: 16),
        filled: true,
        // prefixIcon: widget.isShowPrefixIcon
        //     ? Padding(
        //         padding: const EdgeInsets.only(
        //             left: Dimensions.PADDING_SIZE_LARGE,
        //             right: Dimensions.PADDING_SIZE_SMALL),
        //         child: Image.asset(widget.prefixIconUrl),
        //       )
        //     : SizedBox.shrink(),
        // prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
        // suffixIcon: widget.isShowSuffixIcon
        //     ? widget.isPassword
        //         ? IconButton(
        //             icon: Icon(
        //                 _obscureText ? Icons.visibility_off : Icons.visibility,
        //                 color: Theme.of(context).hintColor.withOpacity(0.3)),
        //             onPressed: _toggle)
        //         : widget.isIcon
        //             ? IconButton(
        //                 onPressed: widget.onSuffixTap,
        //                 icon: Image.asset(
        //                   widget.suffixIconUrl,
        //                   width: 15,
        //                   height: 15,
        //                   color: Theme.of(context).textTheme.bodyText1.color,
        //                 ),
        //               )
        //             : null
        //     : null,
      ),
      onTap: widget.onTap,
      onSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!(text)
              : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

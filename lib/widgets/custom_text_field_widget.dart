import 'package:expense_tracker/utilities/extensions.dart/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/app_theme.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.helperValue = "",
    this.validator,
    this.readOnly = false,
    this.isEnabled = true,
    this.obscureText = false,
    this.showBorders = true,
    this.readOnlyTextColor = const Color(0xFFB0B8C9),
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.suffixIcon,
    this.suffixIconTap,
    this.hintValue,
    this.onChanged,
    this.prefixIconColor,
    this.type,
    this.prefixText,
    this.prefixStringText,
    this.suffixText,
    this.textCapitalization = TextCapitalization.none,
    this.prefixWidget,
    this.suffixWidget,
    this.fillColor,
    this.maxLength = 50,
    this.maxLines = 1,
    this.minLines,
    this.onSubmit,
    this.helperTextStyle,
    this.hintTextStyle,
    this.textStyle,
    this.focusNode,
    this.upperLabel,
    this.asterisk,
    this.upperLabelWidget,
    this.onEditingComplete,
    this.borderRadius,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.height,
    this.onTap,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.textDirection,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 2.0),
    this.outerPaddingField = const EdgeInsets.symmetric(horizontal: 3.5),
    this.showStaticBottomShadow = false,
    this.staticBottomShadowColor,
  });
  final String? hintValue;
  final String? helperValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixText;
  final String? prefixStringText;
  final Widget? suffixText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? fillColor;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconTap;
  final TextInputType? type;
  final int? minLines;
  final int? maxLines;
  final String? upperLabel;
  final String? asterisk;
  final Widget? upperLabelWidget;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final int maxLength;
  final dynamic onSubmit;
  final TextStyle? helperTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool isEnabled;
  final bool showBorders;
  final Color readOnlyTextColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final BorderRadius? borderRadius;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final double? height;
  final bool? enableInteractiveSelection;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextDirection? textDirection;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry outerPaddingField;
  final bool showStaticBottomShadow;
  final Color? staticBottomShadowColor;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late FocusNode _focusNode;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          if (!(widget.readOnly && !widget.isEnabled) && widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: AbsorbPointer(
          absorbing: widget.readOnly,
          child: Directionality(
            textDirection: widget.textDirection ?? TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.upperLabel.isNotNullAndNotEmpty
                    ? Padding(
                        padding: widget.outerPadding,
                        child: Row(
                          children: [
                            Text(
                              widget.upperLabel!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: widget.readOnly ? AppTheme.darkGreyColor : AppTheme.darkColor),
                            ),
                            if (widget.asterisk != null)
                              Text(
                                widget.asterisk!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: widget.readOnly ? AppTheme.darkGreyColor : AppTheme.errorColor),
                              ),
                          ],
                        ),
                      )
                    : widget.upperLabelWidget ?? const SizedBox(),
                Focus(
                  onFocusChange: (focus) {
                    setState(() {});
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 55,
                        width: MediaQuery.sizeOf(context).width,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: widget.outerPaddingField,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                          boxShadow: !widget.showBorders
                              ? [const BoxShadow(color: Colors.transparent)]
                              : [
                                  BoxShadow(
                                    color: _focusNode.hasFocus ? Colors.grey.withOpacity(0.15) : Colors.transparent,
                                    spreadRadius: _focusNode.hasFocus ? 4 : 0,
                                    blurRadius: _focusNode.hasFocus ? 2 : 0,
                                    offset: const Offset(0, 0),
                                  ),
                                  BoxShadow(
                                    color: _focusNode.hasFocus ? Colors.grey.withOpacity(0.1) : Colors.transparent,
                                  ),
                                ],
                        ),
                      ),
                      PhysicalModel(
                        color: Colors.transparent,
                        elevation: widget.showStaticBottomShadow ? 6 : 0,
                        shadowColor: widget.showStaticBottomShadow
                            ? widget.staticBottomShadowColor ?? AppTheme.grey100Color.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(08),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: widget.outerPaddingField,
                          child: TextFormField(
                            autofocus: widget.autofocus,
                            textInputAction: widget.textInputAction,
                            inputFormatters: widget.inputFormatters,
                            style: widget.textStyle ??
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: widget.readOnly ? widget.readOnlyTextColor : AppTheme.darkColor,
                                    ),
                            autocorrect: widget.autocorrect,
                            readOnly: widget.readOnly,
                            enabled: widget.isEnabled,
                            cursorColor: AppTheme.darkGreyColor,
                            focusNode: _focusNode,
                            enableInteractiveSelection: widget.enableInteractiveSelection ?? !widget.obscureText,
                            enableSuggestions: widget.enableSuggestions,
                            keyboardType: widget.type,
                            minLines: widget.minLines,
                            maxLines: widget.maxLines,
                            obscureText: obscureText,
                            textCapitalization: widget.textCapitalization,
                            decoration: InputDecoration(
                                floatingLabelAlignment: FloatingLabelAlignment.start,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                prefixIconConstraints: widget.prefixIconConstraints ??
                                    const BoxConstraints(
                                      minWidth: 20,
                                      maxWidth: 35,
                                    ),
                                suffixIconConstraints: widget.suffixIconConstraints ??
                                    const BoxConstraints(
                                      minWidth: 45,
                                      maxWidth: 55,
                                    ),
                                suffixIcon: (widget.obscureText)
                                    ? GestureDetector(
                                        onTap: () {
                                          if (widget.obscureText) {
                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          widget.suffixIcon ?? (obscureText ? Icons.visibility_off : Icons.visibility),
                                          color: widget.readOnly ? AppTheme.grey300Color : AppTheme.greyColor,
                                        ),
                                      )
                                    : widget.suffixIcon != null
                                        ? GestureDetector(
                                            onTap: () {
                                              if (widget.suffixIconTap != null) {
                                                widget.suffixIconTap!();
                                              }
                                            },
                                            child: Icon(
                                              widget.suffixIcon,
                                              color: widget.readOnly ? AppTheme.grey300Color : AppTheme.greyColor,
                                            ),
                                          )
                                        : widget.suffixText,
                                prefixIcon: (widget.prefixIcon != null)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Icon(
                                          widget.prefixIcon,
                                          color: widget.prefixIconColor ?? AppTheme.greyColor,
                                        ),
                                      )
                                    : widget.prefixText != (null)
                                        ? widget.prefixText
                                        : null,
                                prefix: Padding(
                                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                                    child: Transform.translate(
                                      offset: const Offset(0, 6),
                                      child: widget.prefixWidget,
                                    )),
                                suffix: widget.suffixWidget,
                                prefixText: widget.prefixText == null && widget.prefixWidget == null ? widget.prefixStringText : null,
                                prefixStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: widget.readOnly ? AppTheme.grey300Color : AppTheme.darkColor,
                                    ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: AppTheme.greyTextColor.withOpacity(0.7), width: 0.8),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: AppTheme.greyTextColor.withOpacity(0.7), width: 0.8),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: AppTheme.greyTextColor.withOpacity(0.7), width: 0.8),
                                ),
                                fillColor: widget.fillColor == (null)
                                    ? widget.readOnly
                                        ? AppTheme.grey200Color.withOpacity(0.2)
                                        : AppTheme.lightColor
                                    : widget.fillColor,
                                filled: true,
                                counterText: "",
                                helperText: widget.helperValue.isNullOREmpty ? null : widget.helperValue,
                                hintText: widget.hintValue,
                                hintStyle: widget.hintTextStyle ??
                                    Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: widget.readOnly ? AppTheme.grey300Color : AppTheme.greyColor)),
                            validator: widget.validator,
                            controller: widget.controller,
                            onChanged: widget.onChanged,
                            maxLength: widget.maxLength,
                            onFieldSubmitted: widget.onSubmit,
                            onEditingComplete: widget.onEditingComplete,
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

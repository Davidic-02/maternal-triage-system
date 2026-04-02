import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    required this.focusNode,
    required this.hintText,
    required this.keyboardType,
    this.title,
    super.key,
    this.obscureText = false,
    this.isPassword = false,
    this.isFilled = true,
    this.readOnly = false,
    this.validator,
    this.textInputAction,
    this.onSuffixIconPressed,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.maxLength,
    this.fillColor,
    this.editIcon,
    this.onChanged,
    this.onTap,
    this.errorText,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.showEditIcon,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode focusNode;
  final String? title;
  final String hintText;
  final Color? fillColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? prefixIcon;
  final Widget? editIcon;
  final bool isPassword;
  final bool isFilled;
  final bool readOnly;
  final bool? showEditIcon;
  final Widget? suffixIcon;

  final int? maxLength;
  final String? errorText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function()? onSuffixIconPressed;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final ValueChanged<String>? onChanged;

  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine suffix icon
    Widget? resolvedSuffixIcon;
    if (showEditIcon == true && editIcon != null) {
      resolvedSuffixIcon = Padding(
        padding: const EdgeInsets.all(13),
        child: editIcon,
      );
    } else if (isPassword) {
      resolvedSuffixIcon = IconButton(
        onPressed: onSuffixIconPressed,
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: theme.iconTheme.color,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(title!, style: theme.textTheme.bodySmall),
          AppSpacing.verticalSpaceSmall,
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: obscureText ? 1 : (maxLines ?? 1),
          minLines: minLines,
          maxLength: maxLength,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          readOnly: readOnly,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          onTap: onTap,
          validator: validator,
          style: theme.textTheme.bodyMedium, // text color follows theme
          cursorColor: theme.colorScheme.primary, // cursor adapts to theme
          decoration: InputDecoration(
            filled: isFilled,
            fillColor: fillColor ?? theme.inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: theme.hintColor,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/svg/$prefixIcon.svg',
                      colorFilter: ColorFilter.mode(
                        theme.iconTheme.color ??
                            theme.textTheme.bodySmall!.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
            suffixIcon: suffixIcon ?? resolvedSuffixIcon,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}

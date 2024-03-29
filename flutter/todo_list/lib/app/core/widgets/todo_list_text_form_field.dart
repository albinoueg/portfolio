import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/obscure_password_icons.dart';

class TodoListTextFormField extends StatelessWidget {
  final String labelText;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextValueNotivier;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? formFieldValidator;
  final FocusNode? focusNode;

  TodoListTextFormField({
    super.key,
    required this.labelText,
    this.suffixIconButton,
    this.obscureText = false,
    this.textEditingController,
    this.formFieldValidator,
    this.focusNode,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com suffixIconButton'),
        obscureTextValueNotivier = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextValueNotivier,
      builder: (context, obscureTextValue, child) {
        return TextFormField(
          controller: textEditingController,
          validator: formFieldValidator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(
                          !obscureTextValue
                              ? ObscurePasswordIcons.eyeSlash
                              : ObscurePasswordIcons.eye,
                          size: 15,
                        ),
                        onPressed: () {
                          obscureTextValueNotivier.value = !obscureTextValue;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}

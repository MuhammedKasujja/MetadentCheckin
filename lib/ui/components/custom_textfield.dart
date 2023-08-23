import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:metadent_checkin_app/infra/infra.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final TextInputType inputType;
  final bool isRequired;
  final String? errorText;
  final bool disabled;
  const CustomTextfield({
    Key? key,
    required this.controller,
    this.hint = '',
    required this.label,
    this.inputType = TextInputType.text,
    this.isRequired = true,
    this.errorText,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xff384152)),
        ),
        const SizedBox(
          height: 8,
        ),
        FormBuilderTextField(
          name: label,
          textInputAction: TextInputAction.next,
          controller: controller,
          keyboardType: inputType,
          readOnly: disabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: inputType == TextInputType.emailAddress
              ? FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ])
              : !isRequired
                  ? FormBuilderValidators.compose([])
                  : FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: errorText,
                      ),
                    ]),
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
            ),
            filled: true,
            focusedBorder: AppUtils.buildInputBorder(),
            errorBorder: AppUtils.buildInputBorder(),
            border: AppUtils.buildInputBorder(),
            enabledBorder: AppUtils.buildInputBorder(),
          ),
        ),
      ],
    );
  }
}

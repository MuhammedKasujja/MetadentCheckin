
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:metadent_checkin_app/infra/infra.dart';

class CustomDatepicker extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final bool enabled;
  final bool isDateOfirth;
  final InputType type;
  final bool isRequired;
  final String? errorText;

  const CustomDatepicker({
    Key? key,
    required this.controller,
    this.hint = 'YYYY-MM-DD',
    this.enabled = true,
    this.isDateOfirth = false,
    this.type = InputType.date,
    required this.label,
    this.isRequired = true,
    this.errorText,
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
        FormBuilderDateTimePicker(
          inputType: type,
          name: label,
          enabled: enabled,
          firstDate: type == InputType.date ? DateTime(1960) : null,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          format:type == InputType.date? DateFormat('yyyy-MM-dd'): DateFormat.E(),
          validator: isRequired
              ? FormBuilderValidators.compose<DateTime>(
                  [
                    FormBuilderValidators.required(
                      errorText: errorText,
                    )
                  ],
                )
              : FormBuilderValidators.compose<DateTime>([]),
          initialValue: (controller.text.isNotEmpty)
              ? type == InputType.date
                  ? DateFormat('yyyy-MM-dd').parse(controller.text)
                  : DateFormat.Hm().parse(controller.text)
              : null,
          // valueTransformer: (date) {
          //   return date != null ? DateFormat('DD/MM/yyyy').format(date) : null;
          // },
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
            ),
            suffixIcon: Icon(
              type == InputType.date
                  ? Icons.calendar_month
                  : Icons.access_time_filled,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            suffixIconColor: Theme.of(context).primaryColor,
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

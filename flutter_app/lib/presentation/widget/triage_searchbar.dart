import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';

class TriageSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const TriageSearchBar({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      focusNode: focusNode,
      hintText: 'Search patients...',
      keyboardType: TextInputType.text,
      prefixIcon: 'searchbar',
      onChanged: (value) =>
          context.read<TriageBloc>().add(TriageEvent.searchChanged(value)),
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {
                controller.clear();
                context.read<TriageBloc>().add(
                  const TriageEvent.searchChanged(''),
                );
              },
            )
          : null,
    );
  }
}

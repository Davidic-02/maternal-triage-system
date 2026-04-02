import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/bloc/sign_up/sign_up_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/data/hospital_roles.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';

class StepTwo extends HookWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final medicalFocusNode = useFocusNode();
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalSpaceMedium,
              const Text(
                'Professional Info',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Your clinical credentials',
                style: TextStyle(color: Colors.grey),
              ),
              AppSpacing.verticalSpaceMedium,
              DropdownButtonFormField<String>(
                initialValue: state.role.value.isEmpty
                    ? null
                    : state.role.value,
                hint: const Text('Select Role'),
                decoration: InputDecoration(
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  errorText: !state.role.isPure && state.role.isNotValid
                      ? 'Please select a role'
                      : null,
                ),
                items: hospitalRoles
                    .map(
                      (role) =>
                          DropdownMenuItem(value: role, child: Text(role)),
                    )
                    .toList(),
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.roleChanged(value ?? ''),
                ),
              ),
              AppSpacing.verticalSpaceSmall,
              CustomTextFormField(
                focusNode: medicalFocusNode,
                hintText: 'Medical ID / License Number',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                fillColor: AppColors.white,
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.medicalIdChanged(value),
                ),
                errorText: !state.medicalId.isPure && state.medicalId.isNotValid
                    ? 'Medical ID must be at least 5 characters'
                    : null,
              ),
              AppSpacing.verticalSpaceLarge,
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/assessment_form/assessment_form_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/danger_toggle.dart';
import 'package:maternal_triage/presentation/widget/history_toggle.dart';
import 'package:maternal_triage/presentation/widget/section_header.dart';
import 'package:maternal_triage/services/toast_services.dart';
import 'package:formz/formz.dart';

class DataEntryScreen extends HookWidget {
  static const routeName = '/assessment';
  const DataEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // focus nodes for field-to-field navigation
    final nameFocus = useFocusNode();
    final ageFocus = useFocusNode();
    final gestAgeocus = useFocusNode();
    final systolicFocus = useFocusNode();
    final diastolicFocus = useFocusNode();
    final heartRateFocus = useFocusNode();
    final fetalHRFocus = useFocusNode();
    final bloodSugarFocus = useFocusNode();
    final bodyTempFocus = useFocusNode();
    final weightFocus = useFocusNode();
    final heightFocus = useFocusNode();

    return Scaffold(
      body: BlocListener<AssessmentBloc, AssessmentState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            // clear form after successful assessment
            context.read<AssessmentFormBloc>().add(
              const AssessmentFormEvent.cleared(),
            );
            context.go('/results');
          }

          if (state.status == FormzSubmissionStatus.failure &&
              state.errorMessage != null) {
            ToastService.toast(
              state.errorMessage ?? 'Assessment failed',
              ToastType.error,
            );
          }
        },

        child: BlocBuilder<AssessmentFormBloc, AssessmentFormState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const CustomTopBar(title: 'Clinical Data Intake'),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSpacing.verticalSpaceMedium,
                          const SectionHeader(
                            number: '1',
                            title: 'BASIC IDENTIFICATION',
                            color: AppColors.primaryGreen,
                          ),
                          AppSpacing.verticalSpaceMedium,
                          CustomTextFormField(
                            focusNode: nameFocus,
                            hintText: 'Full Name or PHC-ID',
                            title: 'Patient Name / ID',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => ageFocus.requestFocus(),
                            onChanged: (v) =>
                                context.read<AssessmentFormBloc>().add(
                                  AssessmentFormEvent.patientNameOrIdChanged(v),
                                ),
                          ),
                          AppSpacing.verticalSpaceMedium,

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: ageFocus,
                                  hintText: 'Years',
                                  title: 'Age',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      gestAgeocus.requestFocus(),
                                  onChanged: (v) => context
                                      .read<AssessmentFormBloc>()
                                      .add(AssessmentFormEvent.ageChanged(v)),
                                  errorText:
                                      !state.age.isPure && state.age.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: gestAgeocus,
                                  hintText: 'Weeks',
                                  title: 'Gest. Age (Wks)',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      systolicFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.gestationalAgeChanged(
                                          v,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalSpaceLarge,

                          const SectionHeader(
                            number: '2',
                            title: 'VITAL SIGNS',
                            color: AppColors.primaryGreen,
                          ),
                          AppSpacing.verticalSpaceMedium,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: systolicFocus,
                                  hintText: 'mmHg',
                                  title: 'BP Systolic',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      diastolicFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.systolicBPChanged(
                                          v,
                                        ),
                                      ),
                                  errorText:
                                      !state.systolicBP.isPure &&
                                          state.systolicBP.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: diastolicFocus,
                                  hintText: 'mmHg',
                                  title: 'BP Diastolic',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      heartRateFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.diastolicBPChanged(
                                          v,
                                        ),
                                      ),
                                  errorText:
                                      !state.diastolicBP.isPure &&
                                          state.diastolicBP.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalSpaceMedium,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: heartRateFocus,
                                  hintText: 'bpm',
                                  title: 'Heart Rate',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      fetalHRFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.heartRateChanged(v),
                                      ),
                                  errorText:
                                      !state.heartRate.isPure &&
                                          state.heartRate.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: fetalHRFocus,
                                  hintText: 'bpm',
                                  title: 'Fetal HR',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (_) =>
                                      bloodSugarFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.fetalHeartRateChanged(
                                          v,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.verticalSpaceMedium,

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: bloodSugarFocus,
                                  hintText: 'mmol/L',
                                  title: 'Blood Sugar',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                  onFieldSubmitted: (_) =>
                                      bodyTempFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.bloodSugarChanged(
                                          v,
                                        ),
                                      ),
                                  errorText:
                                      !state.bloodSugar.isPure &&
                                          state.bloodSugar.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: bodyTempFocus,
                                  hintText: '°C',
                                  title: 'Body Temp (°C)',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                  onFieldSubmitted: (_) =>
                                      weightFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.bodyTempChanged(v),
                                      ),
                                  errorText:
                                      !state.bodyTemp.isPure &&
                                          state.bodyTemp.isNotValid
                                      ? 'Required'
                                      : null,
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.verticalSpaceMedium,

                          // weight / BMI — full width
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: weightFocus,
                                  hintText: 'kg',
                                  title: 'Weight (kg)',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                  onFieldSubmitted: (_) =>
                                      heightFocus.requestFocus(),
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.weightChanged(v),
                                      ),
                                ),
                              ),
                              AppSpacing.horizontalSpaceSmall,
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: heightFocus,
                                  hintText: 'cm',
                                  title: 'Height (cm)',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                  onChanged: (v) =>
                                      context.read<AssessmentFormBloc>().add(
                                        AssessmentFormEvent.heightChanged(v),
                                      ),
                                ),
                              ),
                            ],
                          ),

                          if (state.bmi != null) ...[
                            AppSpacing.verticalSpaceSmall,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calculate_outlined,
                                    size: 14,
                                    color: AppColors.primaryGreen,
                                  ),
                                  AppSpacing.horizontalSpaceTiny,
                                  Text(
                                    'BMI: ${state.bmi!.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          AppSpacing.verticalSpaceLarge,

                          const SectionHeader(
                            number: '3',
                            title: 'DANGER SIGNS',
                            color: AppColors.danger,
                          ),
                          AppSpacing.verticalSpaceSmall,

                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.danger.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.danger.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              children: [
                                DangerToggle(
                                  label: 'Headache / Blurred Vision',
                                  value: state.blurredVision,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.blurredVisionToggled(),
                                      ),
                                ),

                                const Divider(),
                                DangerToggle(
                                  label: 'Vaginal Bleeding',
                                  value: state.vaginalBleeding,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.vaginalBleedingToggled(),
                                      ),
                                ),

                                const Divider(),
                                DangerToggle(
                                  label: 'Severe Swelling (Edema)',
                                  value: state.severeSwelling,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.severeSwellingToggled(),
                                      ),
                                ),

                                const Divider(),
                                DangerToggle(
                                  label: 'Reduced Fetal Movement',
                                  value: state.reducedFetalMovement,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.reducedFetalMovementToggled(),
                                      ),
                                ),
                              ],
                            ),
                          ),

                          AppSpacing.verticalSpaceLarge,

                          // ── section 4: medical history ─────────
                          const SectionHeader(
                            number: '4',
                            title: 'MEDICAL HISTORY',
                            color: AppColors.primaryGreen,
                          ),
                          AppSpacing.verticalSpaceSmall,

                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                HistoryToggle(
                                  label: 'Prev. Pre-eclampsia',
                                  value: state.previousComplications,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.previousComplicationsToggled(),
                                      ),
                                ),
                                const Divider(),
                                HistoryToggle(
                                  label: 'Diabetes History',
                                  value: state.preexistingDiabetes,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.preexistingDiabetesToggled(),
                                      ),
                                ),
                                const Divider(),
                                HistoryToggle(
                                  label: 'Gestational Diabetes',
                                  value: state.gestationalDiabetes,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.gestationalDiabetesToggled(),
                                      ),
                                ),
                                const Divider(),
                                HistoryToggle(
                                  label: 'Hypertension',
                                  value: state.hypertension,
                                  onToggle: () =>
                                      context.read<AssessmentFormBloc>().add(
                                        const AssessmentFormEvent.hypertensionToggled(),
                                      ),
                                ),
                                const Divider(),
                                // mental health dropdown
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Mental Health Status',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: state.mentalHealthStatus,
                                        underline: const SizedBox(),
                                        isDense: true,
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'none',
                                            child: Text('None'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'mild',
                                            child: Text('Mild'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'moderate',
                                            child: Text('Moderate'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'severe',
                                            child: Text('Severe'),
                                          ),
                                        ],
                                        onChanged: (v) => context
                                            .read<AssessmentFormBloc>()
                                            .add(
                                              AssessmentFormEvent.mentalHealthStatusChanged(
                                                v ?? 'none',
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          AppSpacing.verticalSpaceLarge,

                          // error message
                          if (state.errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.danger.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: AppColors.danger,
                                    size: 16,
                                  ),
                                  AppSpacing.horizontalSpaceSmall,
                                  Expanded(
                                    child: Text(
                                      state.errorMessage!,
                                      style: const TextStyle(
                                        color: AppColors.danger,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          AppSpacing.verticalSpaceMedium,
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: BlocBuilder<AssessmentBloc, AssessmentState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, assessmentState) {
                        final isLoading =
                            assessmentState.status ==
                            FormzSubmissionStatus.inProgress;

                        return Column(
                          children: [
                            // analyze button
                            Button(
                              'Analyze',
                              busy: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () =>
                                        context.read<AssessmentFormBloc>().add(
                                          const AssessmentFormEvent.submitted(),
                                        ),
                            ),
                            AppSpacing.verticalSpaceSmall,
                            // new assessment button
                            Button(
                              'New Assessment',
                              color: Colors.transparent,
                              textColor: AppColors.primaryGreen,
                              onPressed: () => context
                                  .read<AssessmentFormBloc>()
                                  .add(const AssessmentFormEvent.cleared()),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme.dart';

/// Общий каркас для каждого шага регистрации:
/// прогресс-полоски сверху, стрелка "назад", заголовок,
/// прокручиваемый контент и кнопка действия внизу.
class StepScaffold extends StatelessWidget {
  final int stepIndex; // с 0
  final int totalSteps;
  final String title;
  final String? subtitle;
  final Widget child;
  final String buttonLabel;
  final bool buttonEnabled;
  final VoidCallback onButtonPressed;
  final VoidCallback? onBack;

  const StepScaffold({
    super.key,
    required this.stepIndex,
    required this.totalSteps,
    required this.title,
    this.subtitle,
    required this.child,
    required this.onButtonPressed,
    this.buttonLabel = 'Далее',
    this.buttonEnabled = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: List.generate(totalSteps, (i) {
                        final active = i <= stepIndex;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: i == totalSteps - 1 ? 0 : 6),
                            height: 6,
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primary
                                  : AppColors.disabled,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.h1),
                    if (subtitle != null) ...[
                      const SizedBox(height: 10),
                      Text(subtitle!, style: AppText.body),
                    ],
                    const SizedBox(height: 28),
                    child,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: buttonEnabled ? onButtonPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.disabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonLabel,
                    style: buttonEnabled
                        ? AppText.button
                        : AppText.button.copyWith(
                            color: AppColors.disabledText,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

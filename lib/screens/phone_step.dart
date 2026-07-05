import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../registration_data.dart';
import '../theme.dart';
import '../widgets/step_scaffold.dart';
import 'code_step.dart';

class PhoneStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const PhoneStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<PhoneStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data.phoneNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.replaceAll(' ', '').length >= 6;

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Ваш номер телефона',
      subtitle: 'Мы отправим SMS с кодом подтверждения.',
      buttonEnabled: _isValid,
      onButtonPressed: () {
        widget.data.phoneNumber = _controller.text.trim();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CodeStep(
              data: widget.data,
              stepIndex: widget.stepIndex + 1,
              totalSteps: widget.totalSteps,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Text(
                '🇱🇻 +371',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: 1,
              height: 24,
              color: AppColors.border,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: '00 000 000',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

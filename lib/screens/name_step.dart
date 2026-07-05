import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../theme.dart';
import '../widgets/step_scaffold.dart';
import 'phone_step.dart';

class NameStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const NameStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.trim().length >= 2;

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Как вас зовут?',
      subtitle: 'Это имя увидят другие пользователи в вашей анкете.',
      buttonEnabled: _isValid,
      onButtonPressed: () {
        widget.data.name = _controller.text.trim();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PhoneStep(
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
        child: TextField(
          controller: _controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            hintText: 'Имя',
            hintStyle: TextStyle(color: AppColors.textSecondary),
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

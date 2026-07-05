import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../registration_data.dart';
import '../theme.dart';
import '../widgets/step_scaffold.dart';
import 'birthday_step.dart';

const int _codeLength = 4;

class CodeStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const CodeStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<CodeStep> createState() => _CodeStepState();
}

class _CodeStepState extends State<CodeStep> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();
  bool get _isValid => _code.length == _codeLength;

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Введите код из SMS',
      subtitle: 'Мы отправили 4-значный код на номер +371 ${widget.data.phoneNumber}',
      buttonEnabled: _isValid,
      onButtonPressed: () {
        widget.data.smsCode = _code;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BirthdayStep(
              data: widget.data,
              stepIndex: widget.stepIndex + 1,
              totalSteps: widget.totalSteps,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_codeLength, (i) {
              return SizedBox(
                width: 64,
                height: 64,
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  autofocus: i == 0,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (v) => _onChanged(i, v),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: AppColors.primary, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Код отправлен повторно')),
                );
              },
              child: const Text(
                'Отправить код ещё раз',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

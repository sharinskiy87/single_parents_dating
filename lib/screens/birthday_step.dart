import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../theme.dart';
import '../widgets/step_scaffold.dart';
import 'gender_step.dart';

class BirthdayStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const BirthdayStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<BirthdayStep> createState() => _BirthdayStepState();
}

class _BirthdayStepState extends State<BirthdayStep> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.data.birthday;
  }

  bool get _isValid {
    if (_selected == null) return false;
    final age = DateTime.now().year - _selected!.year;
    return age >= 18;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selected ?? DateTime(now.year - 25, now.month, now.day),
      firstDate: DateTime(now.year - 90),
      lastDate: DateTime(now.year - 18, now.month, now.day),
      helpText: 'Дата рождения',
      cancelText: 'Отмена',
      confirmText: 'Готово',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selected = picked);
    }
  }

  String get _formatted {
    if (_selected == null) return '';
    final d = _selected!.day.toString().padLeft(2, '0');
    final m = _selected!.month.toString().padLeft(2, '0');
    return '$d.$m.${_selected!.year}';
  }

  @override
  Widget build(BuildContext context) {
    final tooYoung = _selected != null && !_isValid;
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Дата рождения',
      subtitle: 'Регистрация доступна с 18 лет. Дату нельзя будет изменить позже.',
      buttonEnabled: _isValid,
      onButtonPressed: () {
        widget.data.birthday = _selected;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GenderStep(
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
          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: tooYoung ? AppColors.error : AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cake_outlined, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    _selected == null ? 'ДД.ММ.ГГГГ' : _formatted,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _selected == null
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (tooYoung) ...[
            const SizedBox(height: 10),
            const Text(
              'К сожалению, регистрация доступна только с 18 лет.',
              style: TextStyle(color: AppColors.error, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}

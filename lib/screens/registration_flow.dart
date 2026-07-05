import 'package:flutter/material.dart';
import '../registration_data.dart';
import 'name_step.dart';

/// Точка входа в регистрацию. Каждый шаг сам "пушит" следующий экран
/// в навигационный стек, поэтому системная кнопка "назад" и стрелка
/// в шапке работают естественным образом.
class RegistrationFlow extends StatelessWidget {
  const RegistrationFlow({super.key});

  static const int totalSteps = 8;

  @override
  Widget build(BuildContext context) {
    final data = RegistrationData();
    return NameStep(data: data, stepIndex: 0, totalSteps: totalSteps);
  }
}

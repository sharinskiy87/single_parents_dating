import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../widgets/option_card.dart';
import '../widgets/step_scaffold.dart';
import 'photo_step.dart';

class GoalStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const GoalStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<GoalStep> createState() => _GoalStepState();
}

class _GoalStepState extends State<GoalStep> {
  DatingGoal? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.data.goal;
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Я хочу...',
      subtitle: 'Выберите, что вы ищете сейчас. Это можно изменить позже в настройках.',
      buttonLabel: _selected == null ? 'Нет выбора' : 'Далее',
      buttonEnabled: _selected != null,
      onButtonPressed: () {
        widget.data.goal = _selected;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PhotoStep(
              data: widget.data,
              stepIndex: widget.stepIndex + 1,
              totalSteps: widget.totalSteps,
            ),
          ),
        );
      },
      child: Column(
        children: DatingGoal.values.map((g) {
          return OptionCard(
            label: g.title,
            emoji: g.emoji,
            selected: _selected == g,
            onTap: () => setState(() => _selected = g),
          );
        }).toList(),
      ),
    );
  }
}

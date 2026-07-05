import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../widgets/option_card.dart';
import '../widgets/step_scaffold.dart';
import 'goal_step.dart';

class ChildrenStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const ChildrenStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<ChildrenStep> createState() => _ChildrenStepState();
}

class _ChildrenStepState extends State<ChildrenStep> {
  int? _selected;

  static const _options = <int, String>{
    0: 'Нет детей',
    1: '1 ребёнок',
    2: '2 ребёнка',
    3: '3 и больше',
  };

  @override
  void initState() {
    super.initState();
    _selected = widget.data.childrenCount;
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Сколько у вас детей?',
      subtitle: 'Эта информация будет видна в вашей анкете.',
      buttonEnabled: _selected != null,
      onButtonPressed: () {
        widget.data.childrenCount = _selected;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GoalStep(
              data: widget.data,
              stepIndex: widget.stepIndex + 1,
              totalSteps: widget.totalSteps,
            ),
          ),
        );
      },
      child: Column(
        children: _options.entries.map((e) {
          return OptionCard(
            label: e.value,
            selected: _selected == e.key,
            onTap: () => setState(() => _selected = e.key),
          );
        }).toList(),
      ),
    );
  }
}

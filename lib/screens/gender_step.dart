import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../widgets/option_card.dart';
import '../widgets/step_scaffold.dart';
import 'children_step.dart';

class GenderStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const GenderStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<GenderStep> createState() => _GenderStepState();
}

class _GenderStepState extends State<GenderStep> {
  Gender? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.data.gender;
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Ваш пол',
      subtitle: 'Это поможет подобрать для вас подходящие анкеты.',
      buttonEnabled: _selected != null,
      onButtonPressed: () {
        widget.data.gender = _selected;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChildrenStep(
              data: widget.data,
              stepIndex: widget.stepIndex + 1,
              totalSteps: widget.totalSteps,
            ),
          ),
        );
      },
      child: Column(
        children: [
          OptionCard(
            label: 'Мужчина',
            emoji: '🙋‍♂️',
            selected: _selected == Gender.male,
            onTap: () => setState(() => _selected = Gender.male),
          ),
          OptionCard(
            label: 'Женщина',
            emoji: '🙋‍♀️',
            selected: _selected == Gender.female,
            onTap: () => setState(() => _selected = Gender.female),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../theme.dart';
import '../widgets/step_scaffold.dart';
import 'moderation_screen.dart';

/// Готовые "фото"-плейсхолдеры для симуляции выбора из галереи —
/// проект без сторонних зависимостей, поэтому реальный image_picker
/// не подключаем, а показываем цветные аватары с эмодзи.
const List<List<Object>> _samplePhotos = [
  [Color(0xFFFFC48C), '🧑‍🦱'],
  [Color(0xFFFFAFA3), '👩'],
  [Color(0xFFAEE9D1), '🧔'],
  [Color(0xFFA9D4FF), '👨‍🦰'],
  [Color(0xFFE3C6FF), '👩‍🦳'],
  [Color(0xFFFFE38C), '🧑'],
];

class PhotoStep extends StatefulWidget {
  final RegistrationData data;
  final int stepIndex;
  final int totalSteps;

  const PhotoStep({
    super.key,
    required this.data,
    required this.stepIndex,
    required this.totalSteps,
  });

  @override
  State<PhotoStep> createState() => _PhotoStepState();
}

class _PhotoStepState extends State<PhotoStep> {
  int _photoIndex = -1;

  @override
  void initState() {
    super.initState();
    _photoIndex = widget.data.photoIndex;
  }

  Future<void> _openPicker() async {
    final choice = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text('Выберите фото', style: AppText.h2),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _samplePhotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, i) {
                  final color = _samplePhotos[i][0] as Color;
                  final emoji = _samplePhotos[i][1] as String;
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(i),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(emoji, style: const TextStyle(fontSize: 30)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
    if (choice != null) {
      setState(() => _photoIndex = choice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = _photoIndex >= 0;
    return StepScaffold(
      stepIndex: widget.stepIndex,
      totalSteps: widget.totalSteps,
      title: 'Добавьте фото',
      subtitle: 'Анкеты с фото получают в разы больше внимания.',
      buttonLabel: 'Завершить регистрацию',
      buttonEnabled: hasPhoto,
      onButtonPressed: () {
        widget.data.photoIndex = _photoIndex;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => ModerationScreen(data: widget.data),
          ),
          (route) => false,
        );
      },
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: _openPicker,
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasPhoto
                          ? _samplePhotos[_photoIndex][0] as Color
                          : AppColors.disabled,
                      border: Border.all(
                        color: hasPhoto ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: hasPhoto
                          ? Text(
                              _samplePhotos[_photoIndex][1] as String,
                              style: const TextStyle(fontSize: 56),
                            )
                          : const Icon(Icons.add_a_photo_outlined,
                              size: 36, color: AppColors.textSecondary),
                    ),
                  ),
                  if (hasPhoto)
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,
                            size: 18, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Требования к фото', style: AppText.h2Small),
                SizedBox(height: 10),
                _Requirement(text: 'Ваше лицо хорошо видно и без фильтров'),
                _Requirement(text: 'Никаких чужих людей на фото'),
                _Requirement(text: 'Без чёрно-белых и групповых снимков'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  final String text;
  const _Requirement({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../registration_data.dart';
import '../theme.dart';
import 'splash_screen.dart';

const List<List<Object>> _avatarPalette = [
  [Color(0xFFFFC48C), '🧑‍🦱'],
  [Color(0xFFFFAFA3), '👩'],
  [Color(0xFFAEE9D1), '🧔'],
  [Color(0xFFA9D4FF), '👨‍🦰'],
  [Color(0xFFE3C6FF), '👩‍🦳'],
  [Color(0xFFFFE38C), '🧑'],
];

/// Финальный экран: анкета отправлена, ждём модерацию фото.
/// Также служит "домашним" экраном прототипа — отсюда можно
/// начать демонстрацию заново.
class ModerationScreen extends StatelessWidget {
  final RegistrationData data;
  const ModerationScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final photo = data.photoIndex >= 0
        ? _avatarPalette[data.photoIndex]
        : [AppColors.disabled, '🙂'];
    final age = data.age;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: photo[0] as Color,
                    ),
                    child: Center(
                      child: Text(photo[1] as String,
                          style: const TextStyle(fontSize: 56)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.hourglass_top,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Фото вашего профиля\nна модерации',
                textAlign: TextAlign.center,
                style: AppText.h1,
              ),
              const SizedBox(height: 12),
              const Text(
                'Обычно это занимает не больше часа. Мы сообщим, как только анкета будет готова.',
                textAlign: TextAlign.center,
                style: AppText.body,
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SummaryRow(label: 'Имя', value: data.name),
                    if (age != null) _SummaryRow(label: 'Возраст', value: '$age лет'),
                    if (data.gender != null)
                      _SummaryRow(
                        label: 'Пол',
                        value: data.gender == Gender.male ? 'Мужчина' : 'Женщина',
                      ),
                    _SummaryRow(label: 'Дети', value: data.childrenLabel),
                    if (data.goal != null)
                      _SummaryRow(label: 'Я хочу', value: data.goal!.title, isLast: true),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Начать сначала',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _SummaryRow({required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.caption),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

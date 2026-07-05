import 'package:flutter/material.dart';
import '../theme.dart';
import 'registration_flow.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(Icons.family_restroom_rounded,
                    color: Colors.white, size: 48),
              ),
              const SizedBox(height: 28),
              const Text(
                'Вдвоём с ребёнком',
                textAlign: TextAlign.center,
                style: AppText.h1,
              ),
              const SizedBox(height: 12),
              const Text(
                'Знакомства для одиноких родителей.\nБез осуждения и лишних вопросов.',
                textAlign: TextAlign.center,
                style: AppText.body,
              ),
              const Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RegistrationFlow(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Начать', style: AppText.button),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Продолжая, вы соглашаетесь с условиями использования',
                textAlign: TextAlign.center,
                style: AppText.caption,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

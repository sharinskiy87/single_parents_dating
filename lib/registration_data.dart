/// Цель знакомства, которую пользователь выбирает на этапе "Я хочу..."
enum DatingGoal {
  longTerm, // Долгосрочные отношения
  dates, // Ходить на свидания
  chatOnly, // Просто пообщаться
  stillDeciding, // Я ещё думаю
}

extension DatingGoalLabel on DatingGoal {
  String get title {
    switch (this) {
      case DatingGoal.longTerm:
        return 'Долгосрочные отношения';
      case DatingGoal.dates:
        return 'Ходить на свидания';
      case DatingGoal.chatOnly:
        return 'Просто пообщаться';
      case DatingGoal.stillDeciding:
        return 'Я ещё думаю';
    }
  }

  String get emoji {
    switch (this) {
      case DatingGoal.longTerm:
        return '💞';
      case DatingGoal.dates:
        return '🥂';
      case DatingGoal.chatOnly:
        return '💬';
      case DatingGoal.stillDeciding:
        return '🤔';
    }
  }
}

enum Gender { male, female }

/// Копится по мере прохождения регистрации и используется
/// на финальном экране для отображения "карточки" профиля.
class RegistrationData {
  String name = '';
  String phoneNumber = '';
  String smsCode = '';
  DateTime? birthday;
  Gender? gender;
  int? childrenCount; // null = не выбрано, 0 = "нет детей"
  DatingGoal? goal;
  int photoIndex = -1; // -1 = фото не добавлено

  int? get age {
    if (birthday == null) return null;
    final now = DateTime.now();
    int age = now.year - birthday!.year;
    if (now.month < birthday!.month ||
        (now.month == birthday!.month && now.day < birthday!.day)) {
      age--;
    }
    return age;
  }

  String get childrenLabel {
    switch (childrenCount) {
      case 0:
        return 'Нет детей';
      case 1:
        return '1 ребёнок';
      case 2:
        return '2 ребёнка';
      default:
        return childrenCount != null ? '$childrenCount+ детей' : '';
    }
  }
}

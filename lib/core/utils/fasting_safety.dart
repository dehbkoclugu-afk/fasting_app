import 'calculations.dart';

/// Self-reported conditions asked before anyone can use the fasting features.
enum SafetyAnswer {
  under18,
  pregnant,
  eatingDisorder,
  underweight,
  diabetes,
  medical,
}

class FastingSafety {
  FastingSafety._();

  /// SharedPreferences key holding [cleared] or [blocked].
  static const statusKey = 'safety_status';
  static const cleared = 'cleared';
  static const blocked = 'blocked';

  static const minAge = 18;
  static const minHealthyBmi = 18.5;

  /// Plans at or past this need one explicit acknowledgement.
  static const longFastMinutes = 20 * 60;
  static const longFastAckKey = 'long_fast_ack';

  static const _blocking = {
    SafetyAnswer.under18,
    SafetyAnswer.pregnant,
    SafetyAnswer.eatingDisorder,
    SafetyAnswer.underweight,
  };

  static bool blocksFasting(Set<SafetyAnswer> answers) =>
      answers.any(_blocking.contains);

  static bool needsDoctorNotice(Set<SafetyAnswer> answers) =>
      answers.contains(SafetyAnswer.diabetes) ||
      answers.contains(SafetyAnswer.medical);

  static bool isUnderweight(double weightKg, double heightCm) =>
      Calculations.calculateBMI(weightKg, heightCm) < minHealthyBmi;
}

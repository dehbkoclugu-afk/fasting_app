import 'package:fasting_app/core/utils/fasting_safety.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('groups at risk are blocked, not just warned', () {
    for (final answer in [
      SafetyAnswer.under18,
      SafetyAnswer.pregnant,
      SafetyAnswer.eatingDisorder,
      SafetyAnswer.underweight,
    ]) {
      expect(FastingSafety.blocksFasting({answer}), isTrue, reason: '$answer');
    }
  });

  test('diabetes and medication need the doctor notice but do not block', () {
    for (final answer in [SafetyAnswer.diabetes, SafetyAnswer.medical]) {
      expect(FastingSafety.blocksFasting({answer}), isFalse);
      expect(FastingSafety.needsDoctorNotice({answer}), isTrue);
    }
    expect(FastingSafety.needsDoctorNotice(const {}), isFalse);
  });

  test('a blocking answer wins over a warning one', () {
    expect(
      FastingSafety.blocksFasting({
        SafetyAnswer.diabetes,
        SafetyAnswer.pregnant,
      }),
      isTrue,
    );
  });

  test('underweight is BMI below 18.5', () {
    expect(FastingSafety.isUnderweight(53, 170), isTrue); // BMI 18.3
    expect(FastingSafety.isUnderweight(54, 170), isFalse); // BMI 18.7
  });
}

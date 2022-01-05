import 'dart:math';

class VerificationService {
  
  String get6DigitNumber() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 6; i++) {
      number = number + random.nextInt(9).toString();
    }
    return number;
  }
}

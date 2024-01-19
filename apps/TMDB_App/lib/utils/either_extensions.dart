import 'package:fpdart/fpdart.dart';

// Extension on Either<L, R>
extension EitherX<L, R> on Either<L, R?> {
  // Method to get Right value or null if Left
  R? get getRightOrNull {
    return fold(
      (l) => null, // Return null in case of Left
      (r) => r, // Return the Right value
    );
  }
}

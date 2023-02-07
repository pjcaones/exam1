import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

class ConcreteFailure extends Failure {}

void main() {
  late ConcreteFailure failure;

  setUp(() {
    failure = ConcreteFailure();
  });

  testWidgets('just checking the override method', (tester) async {
    expect(failure.props, []);
  });
}

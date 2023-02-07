import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final NoParams noParams = NoParams();

  testWidgets('no params', (tester) async {
    final List<Object?> test = [];

    expect(noParams.props, test);
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qn_base_core/qn_base_core.dart';

void main() {
  const MethodChannel channel = MethodChannel('qn_base_core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await QnBaseCore.platformVersion, '42');
  });
}

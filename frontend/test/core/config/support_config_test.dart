import 'package:artizen/core/api/dio_client.dart';
import 'package:artizen/core/config/support_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('supportEmailProvider reads support_email from GET /config', () async {
    final dio = MockDio();
    when(() => dio.get<Map<String, dynamic>>('/config')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/config'),
        statusCode: 200,
        data: {'support_email': 'aide@artizen.app'},
      ),
    );

    final container = ProviderContainer(
      overrides: [dioProvider.overrideWith((ref) => dio)],
    );
    addTearDown(container.dispose);

    final email = await container.read(supportEmailProvider.future);

    expect(email, 'aide@artizen.app');
    verify(() => dio.get<Map<String, dynamic>>('/config')).called(1);
  });
}

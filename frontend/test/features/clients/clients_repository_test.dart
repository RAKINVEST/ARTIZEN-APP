import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late ClientsRepositoryImpl repository;

  setUp(() {
    dio = MockDio();
    repository = ClientsRepositoryImpl(dio);
  });

  test('list() parses the JSON array response into Client objects', () async {
    when(
      () => dio.get<List<dynamic>>('/clients', queryParameters: {'company_id': 'co1'}),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/clients'),
        statusCode: 200,
        data: [
          {
            'id': 'c1',
            'company_id': 'co1',
            'last_name': 'Dupont',
            'first_name': null,
            'company_name': null,
            'address': null,
            'phone': null,
            'email': null,
            'notes': null,
            'created_at': '2026-01-01T10:00:00Z',
            'updated_at': '2026-01-01T10:00:00Z',
          },
        ],
      ),
    );

    final clients = await repository.list(companyId: 'co1');

    expect(clients, hasLength(1));
    expect(clients.first.lastName, 'Dupont');
  });

  test('list() forwards the search query as the "q" parameter', () async {
    when(
      () => dio.get<List<dynamic>>(
        '/clients',
        queryParameters: {'company_id': 'co1', 'q': 'dup'},
      ),
    ).thenAnswer(
      (_) async => Response(requestOptions: RequestOptions(path: '/clients'), data: <dynamic>[]),
    );

    await repository.list(companyId: 'co1', query: 'dup');

    verify(
      () => dio.get<List<dynamic>>(
        '/clients',
        queryParameters: {'company_id': 'co1', 'q': 'dup'},
      ),
    ).called(1);
  });

  test('list() forwards offset/limit for pagination', () async {
    when(
      () => dio.get<List<dynamic>>(
        '/clients',
        queryParameters: {'company_id': 'co1', 'offset': 30, 'limit': 30},
      ),
    ).thenAnswer(
      (_) async => Response(requestOptions: RequestOptions(path: '/clients'), data: <dynamic>[]),
    );

    await repository.list(companyId: 'co1', offset: 30, limit: 30);

    verify(
      () => dio.get<List<dynamic>>(
        '/clients',
        queryParameters: {'company_id': 'co1', 'offset': 30, 'limit': 30},
      ),
    ).called(1);
  });

  test('delete() calls DELETE /clients/{id}', () async {
    when(() => dio.delete<void>('/clients/c1')).thenAnswer(
      (_) async => Response(requestOptions: RequestOptions(path: '/clients/c1')),
    );

    await repository.delete('c1');

    verify(() => dio.delete<void>('/clients/c1')).called(1);
  });
}

import 'dart:typed_data';

import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class FakeOptions extends Fake implements Options {}

Map<String, dynamic> _quoteJson({String status = 'draft'}) => {
  'id': 'q1',
  'company_id': 'co1',
  'client_id': 'cl1',
  'quote_number': 'DEV-2026-0001',
  'status': status,
  'total_ht': '100.00',
  'total_vat': '20.00',
  'total_ttc': '120.00',
  'lines': <dynamic>[],
  'created_at': '2026-01-01T10:00:00Z',
  'updated_at': '2026-01-01T10:00:00Z',
};

void main() {
  setUpAll(() => registerFallbackValue(FakeOptions()));

  late MockDio dio;
  late QuotesRepositoryImpl repository;

  setUp(() {
    dio = MockDio();
    repository = QuotesRepositoryImpl(dio);
  });

  group('changeStatus', () {
    test('sends the backend wire value, not the French label', () {
      when(
        () => dio.put<Map<String, dynamic>>('/quotes/q1/status', data: {'status': 'sent'}),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1/status'),
          statusCode: 200,
          data: _quoteJson(status: 'sent'),
        ),
      );

      expect(repository.changeStatus('q1', QuoteStatus.sent), completes);
      // "Envoyé" would be a 422 — the backend enum is 'sent'.
      verify(
        () => dio.put<Map<String, dynamic>>('/quotes/q1/status', data: {'status': 'sent'}),
      ).called(1);
    });

    test('returns the quote with its new status', () async {
      when(
        () => dio.put<Map<String, dynamic>>('/quotes/q1/status', data: {'status': 'accepted'}),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1/status'),
          statusCode: 200,
          data: _quoteJson(status: 'accepted'),
        ),
      );

      final quote = await repository.changeStatus('q1', QuoteStatus.accepted);

      expect(quote.status, QuoteStatus.accepted);
    });
  });

  group('downloadPdf', () {
    test('asks for bytes, not JSON', () async {
      // Dio's default responseType would try to decode the PDF as JSON and
      // hand back a mangled string. This is the whole reason the method
      // exists rather than a plain get().
      final captured = <Options>[];
      when(() => dio.get<List<int>>('/quotes/q1/pdf', options: any(named: 'options'))).thenAnswer((
        invocation,
      ) async {
        captured.add(invocation.namedArguments[#options] as Options);
        return Response(
          requestOptions: RequestOptions(path: '/quotes/q1/pdf'),
          statusCode: 200,
          data: <int>[0x25, 0x50, 0x44, 0x46, 0x2d], // %PDF-
        );
      });

      final bytes = await repository.downloadPdf('q1');

      expect(captured.single.responseType, ResponseType.bytes);
      expect(bytes, isA<Uint8List>());
      expect(bytes.sublist(0, 5), [0x25, 0x50, 0x44, 0x46, 0x2d]);
    });
  });

  group('delete', () {
    test('calls DELETE /quotes/{id}', () async {
      when(() => dio.delete<void>('/quotes/q1')).thenAnswer(
        (_) async =>
            Response(requestOptions: RequestOptions(path: '/quotes/q1'), statusCode: 204),
      );

      await repository.delete('q1');

      verify(() => dio.delete<void>('/quotes/q1')).called(1);
    });
  });
}

import 'dart:typed_data';

import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quote_readiness.dart';
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

  group('list', () {
    test(
      'forwards status/client_id/offset/limit as the server filters',
      () async {
        when(
          () => dio.get<List<dynamic>>(
            '/quotes',
            queryParameters: {
              'company_id': 'co1',
              'status': ['sent'],
              'client_id': 'cl1',
              'offset': 0,
              'limit': 30,
            },
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/quotes'),
            statusCode: 200,
            data: [_quoteJson(status: 'sent')],
          ),
        );

        final quotes = await repository.list(
          companyId: 'co1',
          statuses: [QuoteStatus.sent],
          clientId: 'cl1',
          offset: 0,
          limit: 30,
        );

        expect(quotes, hasLength(1));
        // The enum wire value, never the French label — "Envoyé" would 422.
        verify(
          () => dio.get<List<dynamic>>(
            '/quotes',
            queryParameters: {
              'company_id': 'co1',
              'status': ['sent'],
              'client_id': 'cl1',
              'offset': 0,
              'limit': 30,
            },
          ),
        ).called(1);
      },
    );

    test('sends only company_id when no filter or paging is given', () async {
      when(
        () => dio.get<List<dynamic>>(
          '/quotes',
          queryParameters: {'company_id': 'co1'},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes'),
          data: <dynamic>[],
        ),
      );

      await repository.list(companyId: 'co1');

      verify(
        () => dio.get<List<dynamic>>(
          '/quotes',
          queryParameters: {'company_id': 'co1'},
        ),
      ).called(1);
    });
  });

  group('changeStatus', () {
    test('sends the backend wire value, not the French label', () {
      when(
        () => dio.put<Map<String, dynamic>>(
          '/quotes/q1/status',
          data: {'status': 'sent'},
        ),
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
        () => dio.put<Map<String, dynamic>>(
          '/quotes/q1/status',
          data: {'status': 'sent'},
        ),
      ).called(1);
    });

    test('returns the quote with its new status', () async {
      when(
        () => dio.put<Map<String, dynamic>>(
          '/quotes/q1/status',
          data: {'status': 'accepted'},
        ),
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
      when(
        () => dio.get<List<int>>(
          '/quotes/q1/pdf',
          options: any(named: 'options'),
        ),
      ).thenAnswer((invocation) async {
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

  group('duplicate', () {
    test('POSTs to /duplicate and returns the new draft', () async {
      when(
        () => dio.post<Map<String, dynamic>>('/quotes/q1/duplicate'),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1/duplicate'),
          statusCode: 201,
          // The backend always returns a fresh draft with its own number.
          data: _quoteJson(status: 'draft'),
        ),
      );

      final copy = await repository.duplicate('q1');

      expect(copy.status, QuoteStatus.draft);
      verify(
        () => dio.post<Map<String, dynamic>>('/quotes/q1/duplicate'),
      ).called(1);
    });
  });

  group('sendByEmail', () {
    test('POSTs to /send and returns the now-sent quote', () async {
      when(
        () => dio.post<Map<String, dynamic>>('/quotes/q1/send'),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1/send'),
          statusCode: 200,
          // The backend renders the PDF, emails it and flips the status.
          data: _quoteJson(status: 'sent'),
        ),
      );

      final quote = await repository.sendByEmail('q1');

      expect(quote.status, QuoteStatus.sent);
      verify(
        () => dio.post<Map<String, dynamic>>('/quotes/q1/send'),
      ).called(1);
    });
  });

  group('readiness', () {
    test('GETs /quotes/{id}/readiness and parses the verdict', () async {
      when(
        () => dio.get<Map<String, dynamic>>('/quotes/q1/readiness'),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1/readiness'),
          statusCode: 200,
          data: {
            'ready': false,
            'issues': [
              {
                'code': 'no_lines',
                'label': 'Le devis ne contient aucune ligne',
                'target': 'quote',
                'field': null,
              },
            ],
          },
        ),
      );

      final readiness = await repository.readiness('q1');

      expect(readiness.ready, isFalse);
      expect(readiness.issues.single.target, ReadinessTarget.quote);
      verify(
        () => dio.get<Map<String, dynamic>>('/quotes/q1/readiness'),
      ).called(1);
    });
  });

  group('delete', () {
    test('calls DELETE /quotes/{id}', () async {
      when(() => dio.delete<void>('/quotes/q1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/quotes/q1'),
          statusCode: 204,
        ),
      );

      await repository.delete('q1');

      verify(() => dio.delete<void>('/quotes/q1')).called(1);
    });
  });
}

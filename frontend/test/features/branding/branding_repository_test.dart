import 'dart:typed_data';

import 'package:artizen/core/api/api_exception.dart';
import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class FakeOptions extends Fake implements Options {}

void main() {
  setUpAll(() => registerFallbackValue(FakeOptions()));

  late MockDio dio;
  late BrandingRepositoryImpl repository;

  setUp(() {
    dio = MockDio();
    repository = BrandingRepositoryImpl(dio);
  });

  group('uploadLogo', () {
    test('POSTs a multipart body and returns the stored path', () async {
      when(
        () => dio.post<Map<String, dynamic>>('/branding/logo', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/branding/logo'),
          statusCode: 201,
          data: {
            'filename': 'logo.png',
            'content_type': 'image/png',
            'size_bytes': 3,
            'path': 'brand/logo/abc.png',
          },
        ),
      );

      final path = await repository.uploadLogo(filename: 'logo.png', bytes: [1, 2, 3]);

      expect(path, 'brand/logo/abc.png');
      verify(
        () => dio.post<Map<String, dynamic>>('/branding/logo', data: any(named: 'data')),
      ).called(1);
    });
  });

  group('deleteLogo', () {
    test('DELETEs the logo endpoint', () async {
      when(() => dio.delete<void>('/branding/logo')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/branding/logo'),
          statusCode: 204,
        ),
      );

      await repository.deleteLogo();

      verify(() => dio.delete<void>('/branding/logo')).called(1);
    });
  });

  group('uploadSignature', () {
    test('POSTs a multipart body and returns the stored path', () async {
      when(
        () => dio.post<Map<String, dynamic>>('/branding/signature', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/branding/signature'),
          statusCode: 201,
          data: {
            'filename': 'sign.png',
            'content_type': 'image/png',
            'size_bytes': 3,
            'path': 'brand/signature/abc.png',
          },
        ),
      );

      final path = await repository.uploadSignature(filename: 'sign.png', bytes: [1, 2, 3]);

      expect(path, 'brand/signature/abc.png');
      verify(
        () => dio.post<Map<String, dynamic>>('/branding/signature', data: any(named: 'data')),
      ).called(1);
    });
  });

  group('deleteStamp', () {
    test('DELETEs the stamp endpoint', () async {
      when(() => dio.delete<void>('/branding/stamp')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/branding/stamp'),
          statusCode: 204,
        ),
      );

      await repository.deleteStamp();

      verify(() => dio.delete<void>('/branding/stamp')).called(1);
    });
  });

  group('fetchAsset', () {
    test('requests raw bytes and wraps them as Uint8List', () async {
      final captured = <Options>[];
      when(
        () => dio.get<List<int>>('/branding/asset/logo', options: any(named: 'options')),
      ).thenAnswer((invocation) async {
        captured.add(invocation.namedArguments[#options] as Options);
        return Response(
          requestOptions: RequestOptions(path: '/branding/asset/logo'),
          statusCode: 200,
          data: <int>[0x89, 0x50, 0x4e, 0x47], // PNG magic bytes
        );
      });

      final bytes = await repository.fetchAsset(BrandAssetKind.logo);

      expect(captured.single.responseType, ResponseType.bytes);
      expect(bytes, isA<Uint8List>());
      expect(bytes, [0x89, 0x50, 0x4e, 0x47]);
    });

    test('returns null when the asset is absent (404), not an error', () async {
      when(
        () => dio.get<List<int>>('/branding/asset/signature', options: any(named: 'options')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/branding/asset/signature'),
          // The shape ErrorInterceptor produces: a DioException carrying the
          // mapped ApiException.
          error: const ApiException.server(statusCode: 404, code: 'not_found', message: 'absent'),
        ),
      );

      final bytes = await repository.fetchAsset(BrandAssetKind.signature);

      expect(bytes, isNull);
    });
  });
}

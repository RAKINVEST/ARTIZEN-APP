import 'package:artizen/core/api/auth_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  test('falls back to memory when secure storage throws (web over plain HTTP)', () async {
    // Reproduces the browser refusing `crypto.subtle` outside a secure
    // context: every secure-storage call throws, which used to crash the
    // whole app on startup with "Null check operator used on a null value".
    final secure = _MockSecureStorage();
    final boom = Exception('Null check operator used on a null value');
    when(() => secure.read(key: any(named: 'key'))).thenThrow(boom);
    when(() => secure.write(key: any(named: 'key'), value: any(named: 'value'))).thenThrow(boom);
    when(() => secure.delete(key: any(named: 'key'))).thenThrow(boom);

    final storage = SecureAuthTokenStorage(secure);

    expect(await storage.readToken(), isNull); // must not throw
    await storage.saveToken('jwt-123');
    expect(await storage.readToken(), 'jwt-123'); // session still works
    await storage.clearToken();
    expect(await storage.readToken(), isNull);
  });

  test('uses the secure storage when the platform supports it', () async {
    final secure = _MockSecureStorage();
    when(() => secure.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});
    when(() => secure.read(key: any(named: 'key'))).thenAnswer((_) async => 'stored-jwt');

    final storage = SecureAuthTokenStorage(secure);
    await storage.saveToken('jwt-123');

    expect(await storage.readToken(), 'stored-jwt'); // read from the vault
    verify(() => secure.write(key: any(named: 'key'), value: 'jwt-123')).called(1);
  });
}

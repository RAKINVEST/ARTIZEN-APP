import '../data/client_model.dart';

/// The contract the presentation layer depends on. Only one implementation
/// exists ([ClientsRepositoryImpl], backed by Dio), but keeping this as an
/// interface makes providers/tests swap in a fake without touching any
/// screen — the same reasoning as the backend's `BaseRepository` pattern.
abstract class ClientsRepository {
  Future<List<Client>> list({required String companyId, String? query});
  Future<Client> get(String id);
  Future<Client> create(ClientInput input, {required String companyId});
  Future<Client> update(String id, ClientInput input);
  Future<void> delete(String id);
}

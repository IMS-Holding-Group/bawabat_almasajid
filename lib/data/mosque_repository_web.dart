import '../models/mosque.dart';
import 'mosque_data.dart';
import 'mosque_repository_base.dart';

MosqueRepository createRepository() => _MosqueRepositoryWeb();

class _MosqueRepositoryWeb extends MosqueRepository {
  @override
  Future<List<Mosque>> getMosquesFiltered({
    bool? hasIftar,
    bool? hasParking,
    String? searchQuery,
    String? district,
  }) =>
      Future.value(MosqueData.getMosquesFiltered(
        hasIftar: hasIftar,
        hasParking: hasParking,
        searchQuery: searchQuery,
        district: district,
      ));

  @override
  Future<List<String>> getDistricts() =>
      Future.value(MosqueData.getDistricts());

  @override
  Future<Mosque?> getMosque(int id) =>
      Future.value(MosqueData.getMosque(id));

  @override
  Future<bool> insertDonation(int mosqueId, double amount) async => false;

  @override
  bool get isWeb => true;
}

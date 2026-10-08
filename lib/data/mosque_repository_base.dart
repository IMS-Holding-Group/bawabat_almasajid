import '../models/mosque.dart';

abstract class MosqueRepository {
  Future<List<Mosque>> getMosquesFiltered({
    bool? hasIftar,
    bool? hasParking,
    String? searchQuery,
    String? district,
  });
  Future<List<String>> getDistricts();
  Future<Mosque?> getMosque(int id);
  Future<bool> insertDonation(int mosqueId, double amount);
  bool get isWeb;
}

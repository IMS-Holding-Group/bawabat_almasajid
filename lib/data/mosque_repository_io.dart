import '../models/mosque.dart';
import '../models/donation.dart';
import 'database_helper.dart';
import 'mosque_repository_base.dart';

MosqueRepository createRepository() => _MosqueRepositoryIO();

class _MosqueRepositoryIO extends MosqueRepository {
  final _db = DatabaseHelper.instance;

  @override
  Future<List<Mosque>> getMosquesFiltered({
    bool? hasIftar,
    bool? hasParking,
    String? searchQuery,
    String? district,
  }) =>
      _db.getMosquesFiltered(
        hasIftar: hasIftar,
        hasParking: hasParking,
        searchQuery: searchQuery,
        district: district,
      );

  @override
  Future<List<String>> getDistricts() => _db.getDistricts();

  @override
  Future<Mosque?> getMosque(int id) => _db.getMosque(id);

  @override
  Future<bool> insertDonation(int mosqueId, double amount) async {
    final donation = Donation(
      id: 0,
      mosqueId: mosqueId,
      amount: amount,
      createdAt: DateTime.now().toIso8601String(),
    );
    await _db.insertDonation(donation);
    return true;
  }

  @override
  bool get isWeb => false;
}

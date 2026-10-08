import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mosque.dart';
import '../models/donation.dart';
import 'seed_data.dart';
import 'mosque_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bawabat_almasajid.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mosques (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        district TEXT,
        latitude REAL,
        longitude REAL,
        has_iftar INTEGER,
        has_parking INTEGER,
        has_wudu INTEGER,
        has_wheelchair INTEGER,
        has_quran INTEGER,
        women_section TEXT,
        women_courses TEXT,
        quran_circles TEXT,
        eid_prayer TEXT,
        qiyam_prayer TEXT,
        tahajjud_prayer TEXT,
        children_reception TEXT,
        contact_info TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE donations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mosque_id INTEGER,
        amount REAL,
        created_at TEXT
      )
    ''');

    await SeedData.seedMosques(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await SeedData.seedAdditionalMosques(db);
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE mosques ADD COLUMN women_section TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN women_courses TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN quran_circles TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN eid_prayer TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN qiyam_prayer TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN tahajjud_prayer TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN children_reception TEXT');
      await db.execute('ALTER TABLE mosques ADD COLUMN contact_info TEXT');
      // تحديث الصفوف الموجودة بالبيانات الجديدة
      for (var id = 1; id <= 46; id++) {
        final mosque = MosqueData.getMosque(id);
        if (mosque != null) {
          await db.update('mosques', {
            'women_section': mosque.womenSection,
            'women_courses': mosque.womenCourses,
            'quran_circles': mosque.quranCircles,
            'eid_prayer': mosque.eidPrayer,
            'qiyam_prayer': mosque.qiyamPrayer,
            'tahajjud_prayer': mosque.tahajjudPrayer,
            'children_reception': mosque.childrenReception,
            'contact_info': mosque.contactInfo,
          }, where: 'id = ?', whereArgs: [id]);
        }
      }
    }
  }

  Future<List<Mosque>> getMosques() async {
    final db = await database;
    final maps = await db.query('mosques', orderBy: 'name ASC');
    return maps.map((m) => Mosque.fromMap(m)).toList();
  }

  Future<List<Mosque>> getMosquesFiltered({
    bool? hasIftar,
    bool? hasParking,
    String? searchQuery,
    String? district,
  }) async {
    var mosques = await getMosques();

    if (hasIftar == true) {
      mosques = mosques.where((m) => m.hasIftar).toList();
    }
    if (hasParking == true) {
      mosques = mosques.where((m) => m.hasParking).toList();
    }
    if (district != null && district.isNotEmpty) {
      mosques = mosques.where((m) => m.district == district).toList();
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery;
      mosques = mosques
          .where((m) =>
              m.name.contains(q) || m.district.contains(q))
          .toList();
    }

    return mosques;
  }

  Future<List<String>> getDistricts() async {
    final db = await database;
    final maps = await db.rawQuery(
      'SELECT DISTINCT district FROM mosques ORDER BY district ASC',
    );
    return maps.map((m) => m['district'] as String).toList();
  }

  Future<Mosque?> getMosque(int id) async {
    final db = await database;
    final maps = await db.query('mosques', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Mosque.fromMap(maps.first);
  }

  Future<int> insertDonation(Donation donation) async {
    final db = await database;
    final map = donation.toMap();
    map.remove('id');
    return await db.insert('donations', map);
  }

  Future<List<Donation>> getDonationsByMosque(int mosqueId) async {
    final db = await database;
    final maps = await db.query(
      'donations',
      where: 'mosque_id = ?',
      whereArgs: [mosqueId],
      orderBy: 'created_at DESC',
    );
    return maps.map((m) => Donation.fromMap(m)).toList();
  }

  Future<double> getTotalDonationsByMosque(int mosqueId) async {
    final donations = await getDonationsByMosque(mosqueId);
    return donations.fold<double>(0, (sum, d) => sum + d.amount);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

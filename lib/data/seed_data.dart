import 'package:sqflite/sqflite.dart';
import 'mosque_data.dart';

class SeedData {
  static List<Map<String, dynamic>> get _allMosques => MosqueData.seedMaps;

  static Future<void> seedMosques(Database db) async {
    for (final m in _allMosques) {
      await db.insert('mosques', m);
    }
  }

  static const List<Map<String, dynamic>> _additionalMosques = [
    {'name': 'مسجد الهدى الكبير', 'district': 'السلامة', 'latitude': 21.5534, 'longitude': 39.1742, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد عبد الرحمن بن عوف', 'district': 'النعيم', 'latitude': 21.6078, 'longitude': 39.1085, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد خالد بن الوليد', 'district': 'المروة', 'latitude': 21.4869, 'longitude': 39.2098, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد سعد بن أبي وقاص', 'district': 'السامر', 'latitude': 21.6031, 'longitude': 39.2529, 'has_iftar': 0, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الإمام الشافعي', 'district': 'الرويس', 'latitude': 21.5256, 'longitude': 39.1951, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 0},
    {'name': 'مسجد البر', 'district': 'الحمراء', 'latitude': 21.5821, 'longitude': 39.1894, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الفلاح', 'district': 'الفلاح', 'latitude': 21.5898, 'longitude': 39.1372, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد التيسير', 'district': 'الصفا', 'latitude': 21.5468, 'longitude': 39.1962, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد دار السلام', 'district': 'الزهراء', 'latitude': 21.5599, 'longitude': 39.1667, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 0},
    {'name': 'مسجد الأقصى', 'district': 'الفيصلية', 'latitude': 21.5732, 'longitude': 39.1738, 'has_iftar': 1, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد القيروان', 'district': 'الصحافة', 'latitude': 21.5844, 'longitude': 39.1521, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الأنصار', 'district': 'الروضة', 'latitude': 21.5674, 'longitude': 39.1592, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد النخيل', 'district': 'الأندلس', 'latitude': 21.6715, 'longitude': 39.1791, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الولاية', 'district': 'مشرفة', 'latitude': 21.5611, 'longitude': 39.1829, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد المصطفى', 'district': 'الفيحاء', 'latitude': 21.6998, 'longitude': 39.1261, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد اليقين', 'district': 'الشاطئ', 'latitude': 21.5107, 'longitude': 39.1029, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد التوبة الكبير', 'district': 'العزيزية', 'latitude': 21.5499, 'longitude': 39.1871, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الشروق', 'district': 'السامر', 'latitude': 21.6062, 'longitude': 39.2494, 'has_iftar': 0, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الإخلاص', 'district': 'الجامعة', 'latitude': 21.5237, 'longitude': 39.2198, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 0},
    {'name': 'مسجد البنيان', 'district': 'النسيم', 'latitude': 21.5816, 'longitude': 39.2234, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الرضوان', 'district': 'النهضة', 'latitude': 21.6409, 'longitude': 39.1324, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد اليسر', 'district': 'الصفا', 'latitude': 21.5427, 'longitude': 39.2018, 'has_iftar': 1, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الإحسان الكبير', 'district': 'الحمدانية', 'latitude': 21.7081, 'longitude': 39.1859, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد الرفاعي', 'district': 'البلد', 'latitude': 21.4872, 'longitude': 39.1929, 'has_iftar': 0, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الفتح المبين', 'district': 'بريمان', 'latitude': 21.6271, 'longitude': 39.2815, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الهجرة', 'district': 'الواحة', 'latitude': 21.6402, 'longitude': 39.2147, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد النورين', 'district': 'المحجر', 'latitude': 21.5038, 'longitude': 39.2196, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد التوحيد الكبير', 'district': 'السامر', 'latitude': 21.6077, 'longitude': 39.2538, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد الصادق', 'district': 'الفيصلية', 'latitude': 21.5769, 'longitude': 39.1749, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الإيمان الكبير', 'district': 'الروضة', 'latitude': 21.5661, 'longitude': 39.1558, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد الفرج', 'district': 'قويزة', 'latitude': 21.4629, 'longitude': 39.2441, 'has_iftar': 0, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الهاشم', 'district': 'النزهة', 'latitude': 21.5319, 'longitude': 39.2317, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد السلام', 'district': 'السلامة', 'latitude': 21.5521, 'longitude': 39.1768, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد التوفيق', 'district': 'الأجواد', 'latitude': 21.4503, 'longitude': 39.2417, 'has_iftar': 1, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد التقوى الكبير', 'district': 'النسيم', 'latitude': 21.5849, 'longitude': 39.2219, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد الرحاب', 'district': 'السامر', 'latitude': 21.6044, 'longitude': 39.2556, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد البشائر الكبرى', 'district': 'الصفا', 'latitude': 21.5459, 'longitude': 39.1944, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الصالحين', 'district': 'الزهراء', 'latitude': 21.5587, 'longitude': 39.1689, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد النبراس', 'district': 'الحمراء', 'latitude': 21.5804, 'longitude': 39.1918, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 0},
    {'name': 'مسجد الهدى والبيان', 'district': 'الفيحاء', 'latitude': 21.6971, 'longitude': 39.1299, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الفضل', 'district': 'المروة', 'latitude': 21.4888, 'longitude': 39.2081, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الكوثر', 'district': 'العزيزية', 'latitude': 21.5512, 'longitude': 39.1847, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 1},
    {'name': 'مسجد الإحسان الصغير', 'district': 'مشرفة', 'latitude': 21.5633, 'longitude': 39.1812, 'has_iftar': 0, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد الأنوار', 'district': 'الصحافة', 'latitude': 21.5827, 'longitude': 39.1514, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد اليقظة', 'district': 'السلامة', 'latitude': 21.5546, 'longitude': 39.1726, 'has_iftar': 0, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 0},
    {'name': 'مسجد البدرين', 'district': 'السامر', 'latitude': 21.6089, 'longitude': 39.2482, 'has_iftar': 1, 'has_parking': 0, 'has_wudu': 1, 'has_wheelchair': 0, 'has_quran': 1},
    {'name': 'مسجد الهداية', 'district': 'الصفا', 'latitude': 21.5448, 'longitude': 39.1981, 'has_iftar': 1, 'has_parking': 1, 'has_wudu': 1, 'has_wheelchair': 1, 'has_quran': 0},
  ];

  static Future<void> seedAdditionalMosques(Database db) async {
    for (final m in _additionalMosques) {
      await db.insert('mosques', m);
    }
  }
}

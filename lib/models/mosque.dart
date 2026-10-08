import 'dart:math' as math;

class Mosque {
  final int id;
  final String name;
  final String district;
  final double latitude;
  final double longitude;
  final bool hasIftar;
  final bool hasParking;
  final bool hasWudu;
  final bool hasWheelchair;
  final bool hasQuran;
  final String? womenSection;
  final String? womenCourses;
  final String? quranCircles;
  final String? eidPrayer;
  final String? qiyamPrayer;
  final String? tahajjudPrayer;
  final String? childrenReception;
  final String? contactInfo;

  Mosque({
    required this.id,
    required this.name,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.hasIftar,
    required this.hasParking,
    required this.hasWudu,
    required this.hasWheelchair,
    required this.hasQuran,
    this.womenSection,
    this.womenCourses,
    this.quranCircles,
    this.eidPrayer,
    this.qiyamPrayer,
    this.tahajjudPrayer,
    this.childrenReception,
    this.contactInfo,
  });

  factory Mosque.fromMap(Map<String, dynamic> map) {
    return Mosque(
      id: map['id'] as int,
      name: map['name'] as String,
      district: map['district'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      hasIftar: ((map['has_iftar'] ?? 0) as int) == 1,
      hasParking: ((map['has_parking'] ?? 0) as int) == 1,
      hasWudu: ((map['has_wudu'] ?? 0) as int) == 1,
      hasWheelchair: ((map['has_wheelchair'] ?? 0) as int) == 1,
      hasQuran: ((map['has_quran'] ?? 0) as int) == 1,
      womenSection: map['women_section'] as String?,
      womenCourses: map['women_courses'] as String?,
      quranCircles: map['quran_circles'] as String?,
      eidPrayer: map['eid_prayer'] as String?,
      qiyamPrayer: map['qiyam_prayer'] as String?,
      tahajjudPrayer: map['tahajjud_prayer'] as String?,
      childrenReception: map['children_reception'] as String?,
      contactInfo: map['contact_info'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      'has_iftar': hasIftar ? 1 : 0,
      'has_parking': hasParking ? 1 : 0,
      'has_wudu': hasWudu ? 1 : 0,
      'has_wheelchair': hasWheelchair ? 1 : 0,
      'has_quran': hasQuran ? 1 : 0,
      'women_section': womenSection,
      'women_courses': womenCourses,
      'quran_circles': quranCircles,
      'eid_prayer': eidPrayer,
      'qiyam_prayer': qiyamPrayer,
      'tahajjud_prayer': tahajjudPrayer,
      'children_reception': childrenReception,
      'contact_info': contactInfo,
    };
  }

  String get mapsUrl =>
      'https://www.google.com/maps?q=${latitude.toStringAsFixed(6)},${longitude.toStringAsFixed(6)}';

  double distanceFrom(double lat, double lng) {
    const double earthRadius = 6371;
    final dLat = math.pi / 180 * (latitude - lat);
    final dLng = math.pi / 180 * (longitude - lng);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(math.pi / 180 * lat) *
            math.cos(math.pi / 180 * latitude) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }
}

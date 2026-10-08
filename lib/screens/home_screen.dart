import 'package:flutter/material.dart';
import '../data/mosque_repository.dart';
import '../models/mosque.dart';
import '../theme/app_theme.dart';
import '../widgets/mosque_card.dart';
import 'mosque_details_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _repo = mosqueRepository;
  List<Mosque> _mosques = [];
  List<String> _districts = [];
  bool _loading = true;
  String? _selectedDistrict;
  final TextEditingController _searchController = TextEditingController();
  static const double _userLat = 21.57;
  static const double _userLng = 39.19;

  @override
  void initState() {
    super.initState();
    _loadDistricts();
    _loadMosques();
  }

  Future<void> _loadDistricts() async {
    final list = await _repo.getDistricts();
    setState(() => _districts = list);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMosques() async {
    setState(() => _loading = true);
    final list = await _repo.getMosquesFiltered(
      searchQuery: _searchController.text.isEmpty ? null : _searchController.text,
      district: _selectedDistrict,
    );
    list.sort((a, b) {
      final da = a.distanceFrom(_userLat, _userLng);
      final db = b.distanceFrom(_userLat, _userLng);
      return da.compareTo(db);
    });
    setState(() {
      _mosques = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.darkGreen,
            leading: IconButton(
              icon: const Icon(Icons.info_outline, color: AppTheme.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutScreen(),
                  ),
                );
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppTheme.darkGreen,
                    AppTheme.lightGreen,
                  ],
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Logo.jpg',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.mosque,
                      color: AppTheme.white,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'بوابة المساجد',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkGreen.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'ابحث بالاسم أو الحي',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppTheme.surface,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (_) => _loadMosques(),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedDistrict,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.surface,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('جميع الأحياء'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('جميع الأحياء')),
                      ..._districts.map((d) => DropdownMenuItem(value: d, child: Text(d))),
                    ],
                    onChanged: (v) {
                      setState(() {
                        _selectedDistrict = v;
                        _loadMosques();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 16)),
          _loading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: AppTheme.darkGreen),
                  ),
                )
              : _mosques.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'لا توجد مساجد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final m = _mosques[i];
                          final dist = m.distanceFrom(_userLat, _userLng);
                          return MosqueCard(
                            mosque: m,
                            distanceKm: dist,
                            index: i,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      MosqueDetailsScreen(mosqueId: m.id),
                                  transitionsBuilder:
                                      (_, animation, __, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.3, 0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutCubic,
                                      )),
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              ).then((_) {
                                if (!_repo.isWeb) _loadMosques();
                              });
                            },
                          );
                        },
                        childCount: _mosques.length,
                      ),
                    ),
        ],
      ),
    );
  }
}

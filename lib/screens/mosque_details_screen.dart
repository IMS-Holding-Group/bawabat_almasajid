import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/mosque_repository.dart';
import '../models/mosque.dart';
import '../theme/app_theme.dart';
import 'donation_screen.dart';

class MosqueDetailsScreen extends StatefulWidget {
  final int mosqueId;

  const MosqueDetailsScreen({super.key, required this.mosqueId});

  @override
  State<MosqueDetailsScreen> createState() => _MosqueDetailsScreenState();
}

class _MosqueDetailsScreenState extends State<MosqueDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInfoSection(String title, String? value) {
    final hasData = value != null && value.isNotEmpty;
    final displayText = hasData ? value : 'لا توجد معلومات';
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              displayText,
              style: TextStyle(
                fontSize: 15,
                color: hasData ? Colors.grey.shade800 : Colors.grey.shade500,
                fontFamily: AppTheme.fontFamily,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المسجد'),
      ),
      body: FutureBuilder<Mosque?>(
        future: mosqueRepository.getMosque(widget.mosqueId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.darkGreen),
            );
          }
          final mosque = snapshot.data!;
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'mosque_${mosque.id}',
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                AppTheme.darkGreen,
                                AppTheme.lightGreen,
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightGreen.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.mosque,
                            size: 48,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      mosque.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mosque.district,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontFamily: AppTheme.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(20),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'وصف الموقع',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'يقع المسجد في حي ${mosque.district} بمدينة جدة. ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                              fontFamily: AppTheme.fontFamily,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => launchUrl(Uri.parse(mosque.mapsUrl), mode: LaunchMode.externalApplication),
                            child: Row(
                              children: [
                                Icon(Icons.map, color: AppTheme.darkGreen, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  '${mosque.latitude.toStringAsFixed(4)}، ${mosque.longitude.toStringAsFixed(4)} - انقر لفتح الخريطة',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppTheme.darkGreen,
                                    fontFamily: AppTheme.fontFamily,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildInfoSection('قسم النساء', mosque.womenSection),
                    _buildInfoSection('الدورات النسائية', mosque.womenCourses),
                    _buildInfoSection('حلقات القرآن', mosque.quranCircles),
                    _buildInfoSection('صلاة العيد', mosque.eidPrayer),
                    _buildInfoSection('صلاة القيام', mosque.qiyamPrayer),
                    _buildInfoSection('صلاة التهجد', mosque.tahajjudPrayer),
                    _buildInfoSection('استقبال الأطفال', mosque.childrenReception),
                    _buildInfoSection('التواصل والاستفسارات', mosque.contactInfo),
                    const SizedBox(height: 24),
                    if (!mosqueRepository.isWeb)
                      ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                DonationScreen(mosqueId: widget.mosqueId),
                            transitionsBuilder: (_, animation, __, child) {
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
                        );
                      },
                      icon: const Icon(Icons.volunteer_activism),
                      label: const Text('تبرع رمزي'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

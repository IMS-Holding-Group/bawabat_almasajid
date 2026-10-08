import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'about_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/Logo.jpg',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppTheme.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.mosque, size: 72, color: AppTheme.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'بوابة المساجد',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'تطبيق جوال لخدمة المساجد وتسهيل الوصول إليها',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.white.withOpacity(0.9),
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                    icon: const Icon(Icons.mosque),
                    label: const Text('عرض المساجد'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      foregroundColor: AppTheme.darkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  );
                },
                icon: const Icon(Icons.info_outline, color: AppTheme.white, size: 20),
                label: const Text(
                  'عن التطبيق',
                  style: TextStyle(color: AppTheme.white, fontFamily: AppTheme.fontFamily),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

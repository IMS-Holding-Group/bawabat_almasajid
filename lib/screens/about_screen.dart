import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن التطبيق'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/Logo.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'بوابة المساجد',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'تطبيق جوال لخدمة المساجد وتسهيل الوصول إليها ومعرفة مرافقها والتبرع لها بشكل محلي ورمزي.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                fontFamily: AppTheme.fontFamily,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'طالبات المشروع:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildNameTile('لمار ناصر الباهلي'),
            _buildNameTile('سلاف عبدالله فتيحي'),
            _buildNameTile('لانا فهد العتيبي'),
            const SizedBox(height: 24),
            Text(
              'منسقة المشروع:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildNameTile('هند هوساوي'),
            const SizedBox(height: 40),
            Text(
              '© 2026 جميع الحقوق محفوظة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontFamily: AppTheme.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTile(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
      ),
    );
  }
}

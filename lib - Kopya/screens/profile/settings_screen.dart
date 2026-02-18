import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../config/app_config.dart';
import '../../widgets/index.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool _isDarkMode;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _isDarkMode = AppConfig.isDarkMode;
    _selectedLanguage = AppConfig.lastLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SettingsSection(
            title: 'Display',
            children: [
              _SettingsItem(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                trailing: Switch(
                  value: _isDarkMode,
                  onChanged: (value) async {
                    await AppConfig.setDarkMode(value);
                    setState(() => _isDarkMode = value);
                  },
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Language',
            children: [
              _SettingsItem(
                icon: Icons.language,
                title: 'App Language',
                subtitle: _getLanguageName(_selectedLanguage),
                onTap: () => _showLanguageDialog(),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Notifications',
            children: [
              _SettingsItem(
                icon: Icons.notifications,
                title: 'Push Notifications',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              _SettingsItem(
                icon: Icons.email,
                title: 'Email Notifications',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
            ],
          ),
          _SettingsSection(
            title: 'App',
            children: [
              _SettingsItem(
                icon: Icons.info,
                title: 'About',
                onTap: () => _showAboutDialog(),
              ),
              _SettingsItem(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.description,
                title: 'Terms of Service',
                onTap: () {},
              ),
            ],
          ),
          _SettingsSection(
            title: 'Account',
            children: [
              _SettingsItem(
                icon: Icons.logout,
                title: 'Logout',
                titleColor: AppColors.error,
                onTap: () => _showLogoutDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageOption(
              name: 'English',
              code: 'en',
              selected: _selectedLanguage == 'en',
              onTap: () {
                setState(() => _selectedLanguage = 'en');
                AppConfig.setLastLanguage('en');
                Navigator.pop(context);
              },
            ),
            _LanguageOption(
              name: 'Türkçe',
              code: 'tr',
              selected: _selectedLanguage == 'tr',
              onTap: () {
                setState(() => _selectedLanguage = 'tr');
                AppConfig.setLastLanguage('tr');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About CubiCasa'),
        content: const Text('Version 1.0.0\n\nProfessional floor plan creation app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    AppConfig.clearAllPreferences();
    Navigator.of(context).pushReplacementNamed('/auth/login');
  }

  String _getLanguageName(String code) {
    return {
      'en': 'English',
      'tr': 'Türkçe',
      'de': 'Deutsch',
      'es': 'Español',
      'fr': 'Français',
    }[code] ?? 'Unknown';
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: TextStyle(color: titleColor)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String name;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.name,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: selected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';

class FastingCircleScreen extends StatefulWidget {
  const FastingCircleScreen({super.key});

  @override
  State<FastingCircleScreen> createState() => _FastingCircleScreenState();
}

class _FastingCircleScreenState extends State<FastingCircleScreen> {
  int _supportCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() => _supportCount = prefs.getInt('circle_support_count') ?? 0);
    }
  }

  Future<void> _support() async {
    HapticFeedback.lightImpact();
    final prefs = await SharedPreferences.getInstance();
    setState(() => _supportCount++);
    await prefs.setInt('circle_support_count', _supportCount);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final members = [
      (l10n.circle_you, .68, true),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.circle_title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.circle_tagline, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            l10n.circle_privacy,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .62),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                for (final member in members)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              member.$3
                                  ? AppColors.primary
                                  : theme.dividerColor,
                          child: Text(
                            member.$1.substring(0, 1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.$1,
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(
                                value: member.$2,
                                borderRadius: BorderRadius.circular(6),
                                minHeight: 7,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${(member.$2 * 100).round()}%'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _support,
            icon: const Icon(Icons.favorite_outline),
            label: Text(l10n.circle_sendSupport(_supportCount)),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () async {
              await Clipboard.setData(
                const ClipboardData(text: 'FAST-LIFE-CIRCLE'),
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.circle_inviteCopied)),
                );
              }
            },
            icon: const Icon(Icons.person_add_alt_1_outlined),
            label: Text(l10n.circle_createInvite),
          ),
        ],
      ),
    );
  }
}

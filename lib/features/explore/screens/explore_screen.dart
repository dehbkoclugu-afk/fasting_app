import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tab_explore)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Text(
              l10n.explore_guide,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.explore_guideDesc,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 20),

            // Tip kartları
            _buildEducationNotice(context),
            const SizedBox(height: 20),
            ..._tips(l10n).map((tip) => _buildTipCard(context, tip)),

            const SizedBox(height: 20),

            // Sık Sorulan Sorular
            Text(
              l10n.explore_faq,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            ..._faqs(l10n).map((faq) => _buildFaqTile(context, faq)),

            const SizedBox(height: 20),

            // Oruç kuralları
            _buildRulesCard(context),

            const SizedBox(height: 20),
            _buildSafetyCard(context),

            const SizedBox(height: 20),
            _buildSources(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<_Tip> _tips(AppLocalizations l10n) => [
    _Tip(
      icon: PhosphorIcons.drop(PhosphorIconsStyle.fill),
      title: l10n.tip_water,
      description: l10n.tip_waterDesc,
      color: AppColors.tertiary,
    ),
    _Tip(
      icon: PhosphorIcons.bowlFood(),
      title: l10n.tip_food,
      description: l10n.tip_foodDesc,
      color: AppColors.success,
    ),
    _Tip(
      icon: PhosphorIcons.moonStars(),
      title: l10n.tip_sleep,
      description: l10n.tip_sleepDesc,
      color: AppColors.primary,
    ),
    _Tip(
      icon: PhosphorIcons.personSimpleRun(),
      title: l10n.tip_exercise,
      description: l10n.tip_exerciseDesc,
      color: AppColors.warning,
    ),
    _Tip(
      icon: PhosphorIcons.coffee(),
      title: l10n.tip_drinks,
      description: l10n.tip_drinksDesc,
      color: const Color(0xFF8B6914),
    ),
  ];

  List<_Faq> _faqs(AppLocalizations l10n) => [
    _Faq(question: l10n.faq_drinks, answer: l10n.faq_drinksAnswer),
    _Faq(question: l10n.faq_plan, answer: l10n.faq_planAnswer),
    _Faq(question: l10n.faq_exercise, answer: l10n.faq_exerciseAnswer),
    _Faq(question: l10n.faq_weight, answer: l10n.faq_weightAnswer),
  ];

  Widget _buildEducationNotice(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIcons.info(),
            color: theme.colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.explore_education,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.health_and_safety_outlined,
                color: AppColors.warning,
              ),
              const SizedBox(width: 10),
              Text(l10n.explore_safety, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.explore_safetyDesc,
            style: theme.textTheme.bodySmall?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSources(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final sources = [
      const _Source(
        title: 'National Institute on Aging — Fasting diets',
        url:
            'https://www.nia.nih.gov/news/calorie-restriction-and-fasting-diets-what-do-we-know',
      ),
      const _Source(
        title: 'NIDDK — Eating and physical activity',
        url:
            'https://www.niddk.nih.gov/health-information/weight-management/adult-overweight-obesity/eating-physical-activity',
      ),
      const _Source(
        title: 'MedlinePlus — Water in diet',
        url: 'https://medlineplus.gov/ency/article/002471.htm',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.explore_sources,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(l10n.explore_sourcesDesc, style: theme.textTheme.bodySmall),
        const SizedBox(height: 8),
        for (final source in sources)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(PhosphorIcons.arrowSquareOut(), size: 20),
            title: Text(source.title, style: theme.textTheme.bodyMedium),
            onTap: () => _openSource(context, source.url),
          ),
      ],
    );
  }

  Future<void> _openSource(BuildContext context, String source) async {
    final l10n = AppLocalizations.of(context)!;
    final opened = await launchUrl(
      Uri.parse(source),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.explore_sourceError)));
    }
  }

  Widget _buildTipCard(BuildContext context, _Tip tip) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: .065),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tip.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tip.icon, color: tip.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, _Faq faq) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: .065),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(bottom: 14),
        shape: const Border(),
        title: Text(
          faq.question,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Text(
            faq.answer,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesCard(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final rules = [
      l10n.explore_rule1,
      l10n.explore_rule2,
      l10n.explore_rule3,
      l10n.explore_rule4,
      l10n.explore_rule5,
      l10n.explore_rule6,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.explore_rules,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rule,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.4,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tip {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _Tip({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _Source {
  const _Source({required this.title, required this.url});

  final String title;
  final String url;
}

class _Faq {
  final String question;
  final String answer;

  const _Faq({required this.question, required this.answer});
}

import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/fasting_plans.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/fasting_session_provider.dart';

class FastingHistoryScreen extends ConsumerStatefulWidget {
  const FastingHistoryScreen({super.key});

  @override
  ConsumerState<FastingHistoryScreen> createState() =>
      _FastingHistoryScreenState();
}

class _FastingHistoryScreenState extends ConsumerState<FastingHistoryScreen> {
  bool _deleting = false;

  Future<void> _delete(FastingSession session) async {
    if (_deleting) return;
    setState(() => _deleting = true);
    try {
      final l10n = AppLocalizations.of(context)!;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.record_deleteConfirm),
          content: Text(l10n.fastingHistory_deleteWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.common_cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.common_delete),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true) return;
      final notifier = ref.read(fastingSessionProvider.notifier);
      if (!await notifier.deleteSession(session.id)) {
        await notifier.loadSessions();
      }
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.fastingHistory_deleteError),
          action: SnackBarAction(
            label: l10n.common_retry,
            onPressed: () {
              if (mounted) _delete(session);
            },
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sessions = ref.watch(fastingSessionProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.fastingHistory_title)),
      body: SafeArea(
        child: sessions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(
            child: TextButton(
              onPressed: () =>
                  ref.read(fastingSessionProvider.notifier).loadSessions(),
              child: Text(l10n.common_retry),
            ),
          ),
          data: (sessions) {
            final ended = sessions.where((s) => s.endTime != null).toList()
              ..sort((a, b) {
                final byStart = b.startTime.compareTo(a.startTime);
                return byStart == 0 ? b.id.compareTo(a.id) : byStart;
              });
            if (ended.isEmpty) {
              return Center(child: Text(l10n.bodyMetrics_noData));
            }
            return ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: ended.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _record(context, ended[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _record(BuildContext context, FastingSession session) {
    final l10n = AppLocalizations.of(context)!;
    final material = MaterialLocalizations.of(context);
    final media = MediaQuery.of(context);
    final end = session.endTime!;
    final minutes =
        session.actualMinutes ?? end.difference(session.startTime).inMinutes;
    final name =
        FastingPlans.all
            .where((plan) => plan.id == session.planType)
            .firstOrNull
            ?.name ??
        session.planType;

    String dateTime(DateTime time) {
      final local = time.toLocal();
      final date = material.formatShortDate(local);
      final clock = material.formatTimeOfDay(
        TimeOfDay.fromDateTime(local),
        alwaysUse24HourFormat: media.alwaysUse24HourFormat,
      );
      return '$date · $clock';
    }

    return GlassCard(
      key: ValueKey(session.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                Text(dateTime(session.startTime)),
                Text(dateTime(end)),
                const SizedBox(height: 4),
                Text(
                  Formatters.formatShortDuration(
                    minutes < 0 ? 0 : minutes,
                    locale: l10n.localeName,
                    hoursLabel: l10n.common_hours,
                    minutesLabel: l10n.common_minutes,
                  ),
                ),
                Text(
                  session.completed
                      ? l10n.awards_completed
                      : l10n.completion_earlyTitle,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.common_delete,
            onPressed: _deleting ? null : () => _delete(session),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}

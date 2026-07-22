import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../constants/metabolic_phases.dart';

String metabolicPhaseName(AppLocalizations l10n, MetabolicPhase phase) =>
    switch (phase.id) {
      'anabolic' => l10n.phase_anabolic,
      'catabolic' => l10n.phase_catabolic,
      'fatBurning' => l10n.phase_fatBurning,
      'ketosis' => l10n.phase_ketosis,
      _ => l10n.phase_autophagy,
    };

String metabolicPhaseDescription(AppLocalizations l10n, MetabolicPhase phase) =>
    switch (phase.id) {
      'anabolic' => l10n.phase_anabolicDesc,
      'catabolic' => l10n.phase_catabolicDesc,
      'fatBurning' => l10n.phase_fatBurningDesc,
      'ketosis' => l10n.phase_ketosisDesc,
      _ => l10n.phase_autophagyDesc,
    };

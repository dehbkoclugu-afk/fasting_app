import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../services/food_vision_service.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../paywall/providers/subscription_provider.dart';
import '../providers/food_scan_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/food_item_edit_sheet.dart';

/// Premium: photograph a plate, get calories and macros back, adjust them,
/// save them as a meal.
class FoodScanScreen extends ConsumerStatefulWidget {
  const FoodScanScreen({
    super.key,
    this.initialImageBytes,
    this.initialImageMimeType,
    this.onInitialImageConsumed,
  });

  final Uint8List? initialImageBytes;
  final String? initialImageMimeType;
  final VoidCallback? onInitialImageConsumed;

  @override
  ConsumerState<FoodScanScreen> createState() => _FoodScanScreenState();
}

class _FoodScanScreenState extends ConsumerState<FoodScanScreen> {
  final _nameController = TextEditingController();
  String _mealType = 'lunch';
  bool _saving = false;
  Uint8List? _pendingRecoveredImage;
  String? _pendingRecoveredMimeType;

  @override
  void initState() {
    super.initState();
    _pendingRecoveredImage = widget.initialImageBytes;
    _pendingRecoveredMimeType = widget.initialImageMimeType;
    widget.onInitialImageConsumed?.call();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _resumeRecoveredPhoto(),
    );
  }

  void _resumeRecoveredPhoto() {
    if (!mounted || !ref.read(isPremiumProvider)) return;
    final bytes = _pendingRecoveredImage;
    if (bytes == null) return;
    _pendingRecoveredImage = null;
    ref
        .read(foodScanProvider.notifier)
        .analyzeBytes(
          bytes,
          languageCode: _languageCode(context),
          mimeType: _pendingRecoveredMimeType,
        );
    _pendingRecoveredMimeType = null;
  }

  void _close() {
    if (!mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/timer');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPremium = ref.watch(isPremiumProvider);
    final state = ref.watch(foodScanProvider);
    ref.listen<bool>(isPremiumProvider, (_, premium) {
      if (premium) _resumeRecoveredPhoto();
    });

    // Seeding the field from a listener rather than inline in build: writing
    // to a TextEditingController during build marks the TextField dirty
    // mid-frame. Only the transition into `ready` seeds it, so later edits to
    // the item list never overwrite a name the user has retyped.
    ref.listen<FoodScanState>(foodScanProvider, (previous, next) {
      if (next.status == FoodScanStatus.ready &&
          previous?.status != FoodScanStatus.ready) {
        _nameController.text = next.analysis?.dishName ?? '';
      }
    });

    return PopScope(
      canPop: !_saving,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.foodScan_title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _saving ? null : _close,
          ),
        ),
        body: SafeArea(
          child: isPremium
              ? _buildBody(context, l10n, state)
              : _buildLocked(context, l10n),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    FoodScanState state,
  ) {
    return switch (state.status) {
      FoodScanStatus.idle => _buildIntro(context, l10n, state),
      FoodScanStatus.analyzing => _buildAnalyzing(context, l10n, state),
      FoodScanStatus.failed => _buildError(context, l10n, state),
      FoodScanStatus.ready => _buildResult(context, l10n, state),
    };
  }

  // --- Premium gate -------------------------------------------------------

  Widget _buildLocked(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EditorialScreenHero(
              assetPath: 'assets/images/editorial/v6/premium-orbit.webp',
              title: l10n.foodScan_premiumTitle,
              subtitle: l10n.foodScan_premiumDesc,
              icon: Icons.lock_outline,
              height: 164,
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: l10n.foodScan_upgrade,
              width: double.infinity,
              onPressed: () => context.push('/paywall'),
            ),
          ],
        ),
      ),
    );
  }

  // --- Idle ---------------------------------------------------------------

  Widget _buildIntro(
    BuildContext context,
    AppLocalizations l10n,
    FoodScanState state,
  ) {
    final theme = Theme.of(context);
    final quotaReached = !state.hasQuotaLeft;

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditorialScreenHero(
            assetPath: 'assets/images/editorial/v6/meal-analysis.webp',
            title: l10n.foodScan_introTitle,
            subtitle: l10n.foodScan_introDesc,
            icon: Icons.document_scanner_outlined,
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tip(context, PhosphorIcons.sun(), l10n.foodScan_tipLight),
                const SizedBox(height: 10),
                _tip(context, PhosphorIcons.crop(), l10n.foodScan_tipFrame),
                const SizedBox(height: 10),
                _tip(context, PhosphorIcons.ruler(), l10n.foodScan_tipScale),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (quotaReached) ...[
            _notice(context, l10n.foodScan_quotaReached, AppColors.secondary),
            TextButton(
              onPressed: () =>
                  ref.read(foodScanProvider.notifier).refreshQuota(),
              child: Text(l10n.common_retry),
            ),
          ] else ...[
            GradientButton(
              text: l10n.foodScan_takePhoto,
              width: double.infinity,
              onPressed: () => _pick(PhotoSource.camera),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _pick(PhotoSource.gallery),
              icon: Icon(PhosphorIcons.images(), size: 20),
              label: Text(l10n.foodScan_chooseFromGallery),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
          const SizedBox(height: 16),
          if (state.scansLeftToday != null && !quotaReached)
            Text(
              l10n.foodScan_scansLeft(state.scansLeftToday!),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .45),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            l10n.foodScan_privacyNote,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .4),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _tip(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .7),
            ),
          ),
        ),
      ],
    );
  }

  // --- Analyzing ----------------------------------------------------------

  Widget _buildAnalyzing(
    BuildContext context,
    AppLocalizations l10n,
    FoodScanState state,
  ) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.imageBytes != null)
              ClipRRect(
                borderRadius: AppSpacing.borderRadiusLg,
                child: Image.memory(
                  state.imageBytes!,
                  cacheWidth: 1024,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    height: 180,
                    child: Center(child: Icon(Icons.broken_image_outlined)),
                  ),
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(l10n.foodScan_analyzing, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              l10n.foodScan_analyzingHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Error --------------------------------------------------------------

  Widget _buildError(
    BuildContext context,
    AppLocalizations l10n,
    FoodScanState state,
  ) {
    final theme = Theme.of(context);
    final canRetrySamePhoto =
        state.imageBytes != null &&
        state.error != FoodVisionError.noFoodFound &&
        state.error != FoodVisionError.notConfigured;

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.warningCircle(),
              size: 44,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage(l10n, state.error),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            if (canRetrySamePhoto)
              GradientButton(
                text: l10n.foodScan_retry,
                width: double.infinity,
                onPressed: () => ref
                    .read(foodScanProvider.notifier)
                    .retry(languageCode: _languageCode(context)),
              ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => ref.read(foodScanProvider.notifier).reset(),
              child: Text(l10n.foodScan_retake),
            ),
          ],
        ),
      ),
    );
  }

  String _errorMessage(AppLocalizations l10n, FoodVisionError? error) {
    return switch (error) {
      FoodVisionError.network => l10n.foodScan_errorNetwork,
      FoodVisionError.rateLimited => l10n.foodScan_errorRateLimited,
      FoodVisionError.auth ||
      FoodVisionError.notConfigured => l10n.foodScan_errorUnavailable,
      FoodVisionError.server => l10n.foodScan_errorServer,
      FoodVisionError.noFoodFound => l10n.foodScan_errorNoFood,
      _ => l10n.foodScan_errorUnreadable,
    };
  }

  // --- Result -------------------------------------------------------------

  Widget _buildResult(
    BuildContext context,
    AppLocalizations l10n,
    FoodScanState state,
  ) {
    final theme = Theme.of(context);
    final analysis = state.analysis!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (state.imageBytes != null)
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusLg,
                    child: Image.memory(
                      state.imageBytes!,
                      cacheWidth: 1024,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        height: 180,
                        child: Center(child: Icon(Icons.broken_image_outlined)),
                      ),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),

                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.meals_mealName,
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Totals
                GlassCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${analysis.totalCalories}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('kcal', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _macro(
                            context,
                            l10n.meals_protein,
                            analysis.totalProtein,
                            Colors.blue,
                          ),
                          _macro(
                            context,
                            l10n.meals_carbs,
                            analysis.totalCarbs,
                            Colors.orange,
                          ),
                          _macro(
                            context,
                            l10n.meals_fat,
                            analysis.totalFat,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                if (analysis.isLowConfidence)
                  _notice(
                    context,
                    l10n.foodScan_lowConfidence,
                    AppColors.secondary,
                  )
                else
                  Text(
                    l10n.foodScan_disclaimer,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .45),
                    ),
                  ),
                if (analysis.note.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    analysis.note,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .55),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 20),

                Text(
                  l10n.foodScan_detectedItems,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                for (final (index, item) in analysis.items.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _itemTile(context, l10n, index, item),
                  ),
                const SizedBox(height: 16),

                Text(l10n.meals_mealType, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _mealTypeChip('breakfast', l10n.meals_breakfast),
                    _mealTypeChip('lunch', l10n.meals_lunch),
                    _mealTypeChip('dinner', l10n.meals_dinner),
                    _mealTypeChip('snack', l10n.meals_snack),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _saving
                      ? null
                      : () => ref.read(foodScanProvider.notifier).reset(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: Text(l10n.foodScan_retake),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GradientButton(
                  text: l10n.foodScan_save,
                  height: 52,
                  onPressed: _saving || analysis.items.isEmpty ? null : _save,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _macro(BuildContext context, String label, double grams, Color color) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            '${grams.toStringAsFixed(0)}g',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .5),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemTile(
    BuildContext context,
    AppLocalizations l10n,
    int index,
    FoodItem item,
  ) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey('scan_item_${index}_${item.name}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: .1),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      onDismissed: (_) => ref.read(foodScanProvider.notifier).removeItem(index),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        onTap: () => _editItem(index, item),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textTheme.titleSmall),
                  if (item.portion.isNotEmpty)
                    Text(
                      item.portion,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .5,
                        ),
                      ),
                    ),
                  Text(
                    'P:${item.protein.toStringAsFixed(0)}g '
                    'K:${item.carbs.toStringAsFixed(0)}g '
                    'Y:${item.fat.toStringAsFixed(0)}g',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .4),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${item.calories} kcal',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              PhosphorIcons.pencilSimple(),
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: .35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealTypeChip(String value, String label) {
    return ChoiceChip(
      selected: _mealType == value,
      label: Text(label),
      onSelected: (_) {
        HapticFeedback.selectionClick();
        setState(() => _mealType = value);
      },
    );
  }

  Widget _notice(BuildContext context, String text, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Icon(PhosphorIcons.info(), size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  // --- Actions ------------------------------------------------------------

  static String _languageCode(BuildContext context) =>
      Localizations.localeOf(context).languageCode;

  Future<void> _pick(PhotoSource source) async {
    final languageCode = _languageCode(context);
    HapticFeedback.lightImpact();
    await ref
        .read(foodScanProvider.notifier)
        .scan(source, languageCode: languageCode);
  }

  Future<void> _editItem(int index, FoodItem item) async {
    final edited = await showModalBottomSheet<FoodItem>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => FoodItemEditSheet(item: item),
    );
    if (mounted && edited != null) {
      ref.read(foodScanProvider.notifier).updateItem(index, edited);
    }
  }

  Future<void> _save() async {
    if (_saving || !ref.read(isPremiumProvider)) return;
    final l10n = AppLocalizations.of(context)!;
    final analysis = ref.read(foodScanProvider).analysis;
    if (analysis == null || analysis.items.isEmpty) return;
    final name = _nameController.text.trim().isEmpty
        ? analysis.dishName
        : _nameController.text.trim();
    setState(() => _saving = true);
    try {
      await ref
          .read(mealProvider.notifier)
          .addMeal(
            name: name,
            calories: analysis.totalCalories,
            protein: analysis.totalProtein,
            carbs: analysis.totalCarbs,
            fat: analysis.totalFat,
            mealType: _mealType,
          );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      HapticFeedback.mediumImpact();
      // Keep the button locked until this route is removed.
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/timer');
      }
      messenger.showSnackBar(SnackBar(content: Text(l10n.meals_added(name))));
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.common_retry)));
    }
  }
}

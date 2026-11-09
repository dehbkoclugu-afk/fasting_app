# Quick-add meal names

The twelve quick-add meals in AddMealSheet now use AppLocalizations rather
than fixed Turkish titles. The same localized title is displayed on the card,
passed to MealNotifier and used in the confirmation message. The list is
rebuilt from the current locale, including when the language changes while
the sheet remains open.

Twelve messages were added to all 32 ARB files, with Brazilian Portuguese
variants and corresponding generated getters. Existing Turkish titles,
nutrient values, images and meal types are preserved. Saved meal names remain
user data: this change does not rewrite historical records when the app
language changes.

Widget regressions cover English display and database persistence of name and
nutrients, changing an open sheet to German before saving, unchanged Turkish
titles and Arabic text in a narrow RTL sheet. Existing localization checks
also verify message completeness and placeholder consistency.

Native-speaker review of the new translations remains pending. Device visual
acceptance is assigned to the user and its results remain unrecorded.

The local C: drive remains full. This patch is authored through GitHub from
the reviewed source snapshot and must be validated by CI before completion.
The local worktree is not advanced or overwritten.

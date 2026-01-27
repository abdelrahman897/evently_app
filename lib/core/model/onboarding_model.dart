import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';

class OnboardingModel {
  String imagePath;
  String Function(AppLocalizations) titleText;
  String Function(AppLocalizations) bodyText;
  bool isFirstPage;

  OnboardingModel({
    required this.imagePath,
    required this.titleText,
    required this.bodyText,
    this.isFirstPage = false,
  });

static  List<OnboardingModel> onboardingList = [
  OnboardingModel(
    imagePath: Assets.images.onboardingFirstBackgroundImg.path,
    titleText: (l10n) => l10n.onboardingFirstTitle,
    bodyText: (l10n) => l10n.onboardingFirstBody,
  ),
  OnboardingModel(
    imagePath: Assets.images.onboardingSecondBackgroundImg.path,
    titleText: (l10n) => l10n.onboardingSecondTitle,
    bodyText: (l10n) => l10n.onboardingSecondBody,
  ),
  OnboardingModel(
    imagePath: Assets.images.onboardingThirdBackgroundImg.path,
    titleText: (l10n) => l10n.onboardingThirdTitle,
    bodyText: (l10n) => l10n.onboardingThirdBody,
  ),
  OnboardingModel(
    imagePath: Assets.images.onboardingFourthBackgroundImg.path,
    titleText: (l10n) => l10n.onboardingFourthTitle,
    bodyText: (l10n) => l10n.onboardingFourthBody,
  ),
  ];
}

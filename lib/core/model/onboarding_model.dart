import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';

class OnboardingModel {
  String imageLightPath;
  String imageDarkPath;
  String Function(AppLocalizations) titleText;
  String Function(AppLocalizations) bodyText;
  bool isFirstPage;

  OnboardingModel({
    required this.imageLightPath,
    required this.imageDarkPath,
    required this.titleText,
    required this.bodyText,
    this.isFirstPage = false,
  });

  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      imageLightPath: Assets.images.onboardingFirstLightBackgroundImg.path,
      imageDarkPath: Assets.images.onboardingFirstDarkBackgroundImg.path,
      titleText: (l10n) => l10n.onboardingFirstTitle,
      bodyText: (l10n) => l10n.onboardingFirstBody,
    ),
    OnboardingModel(
      imageLightPath: Assets.images.onboardingSecondLightBackgroundImg.path,
      imageDarkPath: Assets.images.onboardingSecondDarkBackgroundImg.path,
      titleText: (l10n) => l10n.onboardingSecondTitle,
      bodyText: (l10n) => l10n.onboardingSecondBody,
    ),
    OnboardingModel(
      imageLightPath: Assets.images.onboardingThirdLightBackgroundImg.path,
      imageDarkPath: Assets.images.onboardingThirdDarkBackgroundImg.path,
      titleText: (l10n) => l10n.onboardingThirdTitle,
      bodyText: (l10n) => l10n.onboardingThirdBody,
    ),
    OnboardingModel(
      imageLightPath: Assets.images.onboardingFourthLightBackgroundImg.path,
      imageDarkPath: Assets.images.onboardingFourthDarkBackgroundImg.path,
      titleText: (l10n) => l10n.onboardingFourthTitle,
      bodyText: (l10n) => l10n.onboardingFourthBody,
    ),
  ];
}

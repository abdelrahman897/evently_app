import 'package:evently_app/core/constant/app_strings.dart';
import 'package:evently_app/core/gen/assets.gen.dart';

class OnboardingModel {
  String imagePath;
  String titleText;
  String bodyText;
  bool isFirstPage;

  OnboardingModel({
    required this.imagePath,
    required this.titleText,
    required this.bodyText,
    this.isFirstPage = false,
  });

  List<OnboardingModel> onboardingList = [
    OnboardingModel(
      imagePath: Assets.images.onboardingFirstBackgroundImg.path,
      titleText: AppStrings.onboardingFirstTitleText,
      bodyText: AppStrings.onboardingFirstBodyText,
      isFirstPage: true,
    ),
    OnboardingModel(
      imagePath: Assets.images.onboardingSecondBackgroundImg.path,
      titleText: AppStrings.onboardingSecondTitleText,
      bodyText: AppStrings.onboardingSecondBodyText,
    ),
    OnboardingModel(
      imagePath: Assets.images.onboardingThirdBackgroundImg.path,
      titleText: AppStrings.onboardingThirdTitleText,
      bodyText: AppStrings.onboardingThirdBodyText,
    ),
    OnboardingModel(
      imagePath: Assets.images.onboardingFourthBackgroundImg.path,
      titleText: AppStrings.onboardingFourthTitleText,
      bodyText: AppStrings.onboardingFourthBodyText,
    ),
  ];
}

import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/services/toast_message.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/utils/authentication/firebase_auth/firebase_auth_utils.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:evently_app/core/widget/custom_text_form_field_widget.dart';
import 'package:evently_app/modules/provider/app_provider/app_settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegExp regexEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  final RegExp regexPassword = RegExp(
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$",
  );
  final RegExp userNameRegex = RegExp(r"^[a-zA-Z0-9_]{3,20}$");
  bool isActivePassword = true;
  bool isActiveConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool  isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
    return Scaffold(
      appBar: CustomAppBarWidget(
        customTitleWidget: Assets.images.headerLogoBackgroundImg.image(
          width: 142,
          height: 27,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                appLocalizations.headerCreateAccount,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 24),
              CustomTextFormFieldWidget(
                isDark: isDark,
                controller: userNameController,
                text: appLocalizations.enterName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "User Name is required , Check User Name.";
                  }
                  if (!userNameRegex.hasMatch(value)) {
                    return "Invalid User Name , Check User Name.";
                  }
                  return null;
                },
                customPrefixWidget: Assets.icons.userIcn.svg(
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormFieldWidget(
                isDark: isDark,
                controller: emailController,
                text: appLocalizations.enterEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required , Check Email.";
                  }
                  if (!regexEmail.hasMatch(value)) {
                    return "Invalid Email , Check Email.";
                  }
                  return null;
                },
                customPrefixWidget: Assets.icons.smsIcn.svg(
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormFieldWidget(
                isDark: isDark,
                controller: passwordController,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required , Check Password.";
                  }
                  if (!regexPassword.hasMatch(value)) {
                    return "Password must be at least 8 characters, including uppercase, lowercase, numbers and special characters.";
                  }
                  return null;
                },
                text: appLocalizations.enterPassword,
                isPassword: isActivePassword,
                customPrefixWidget: Assets.icons.lockIcn.svg(
                  width: 24,
                  height: 24,
                ),
                customSuffixWidget: InkWell(
                  onTap: () {
                    setState(() {
                      isActivePassword = !isActivePassword;
                    });
                  },
                  child:
                      isActivePassword
                          ? Assets.icons.eyeSlashIcn.svg(width: 15, height: 15)
                          : Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColor.hintTextColor,
                          ),
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormFieldWidget(
                isDark: isDark,
                controller: confirmPasswordController,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm Password is required , Check Confirm Password.";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match.";
                  }
                  return null;
                },
                text: appLocalizations.confirmPassword,
                isPassword: isActiveConfirmPassword,
                customPrefixWidget: Assets.icons.lockIcn.svg(
                  width: 24,
                  height: 24,
                ),
                customSuffixWidget: InkWell(
                  onTap: () {
                    isActiveConfirmPassword = !isActiveConfirmPassword;
                    setState(() {});
                  },
                  child:
                      isActiveConfirmPassword
                          ? Assets.icons.eyeSlashIcn.svg(width: 24, height: 24)
                          : Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColor.hintTextColor,
                          ),
                ),
              ),
              SizedBox(height: 52),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show();

                          bool success = await FirebaseAuthUtils.singUpWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          );

                          if (success) {
                            EasyLoading.dismiss();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PagesRouteName.signInScreen,
                                  (route) => false,
                            );
                          } else {
                            EasyLoading.dismiss();
                          }
                        }
                      },
                      backgroundColor: isDark ? AppColor.lightBlueColor: AppColor.primaryColor,
                      customChildWidget: Text(
                        appLocalizations.signUp,
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: appLocalizations.alreadyHaveAccount,
                        style: theme.textTheme.bodyMedium,
                      ),
                      WidgetSpan(
                        child: Bounceable(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PagesRouteName.signInScreen,
                            );
                          },
                          child: Text(
                            appLocalizations.login,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor:isDark ? AppColor.lightBlueColor: AppColor.primaryColor,
                              decorationThickness: 1.5,
                              color: isDark ? AppColor.lightBlueColor: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color:isDark ? AppColor.blueColor: AppColor.strokeColor,
                      thickness: 1,
                      endIndent: 15,
                      indent: 15,
                    ),
                  ),
                  Text(appLocalizations.or, style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ? AppColor.lightBlueColor: AppColor.strokeColor,
                  ),),
                  Expanded(
                    child: Divider(
                      color: isDark ? AppColor.blueColor: AppColor.strokeColor,
                      thickness: 1,
                      endIndent: 15,
                      indent: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButtonWidget(
                      onPressed: () {
                        EasyLoading.show();
                        FirebaseAuthUtils.signInWithGoogle().then((userCredential) {
                          EasyLoading.dismiss();
                          if (userCredential != null) {
                            ToastMessage.showSuccessMessage("Login with Google successful!");
                            Navigator.pushNamedAndRemoveUntil(context, PagesRouteName.homeLayoutScreen, (route) => false);
                          }
                        });
                      },
                      customChildWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.googleIcn.svg(width: 24, height: 24),
                          SizedBox(width: 4),
                          Text(
                            appLocalizations.signUpWithGoogle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isDark ? AppColor.lightBlueColor : AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: isDark ? AppColor.blueColor : AppColor.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ).setHorizontalAndVerticalPadding(
            context,
            16,
            48,
            enableMediaQuery: false,
          ),
        ),
      ),
    );
  }
}

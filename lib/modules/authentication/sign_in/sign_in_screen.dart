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

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp regexPassword = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

  bool isActive = true ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations =AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
     bool isDark = appSettingsProvider.currentThemeMode == ThemeMode.dark;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.headerLogin,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 24),
              CustomTextFormFieldWidget(
                controller: emailController,
                text: appLocalizations.enterEmail,
                isDark: isDark,
                validator: (value){
                  if ( value == null || value.isEmpty) {
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
                controller: passwordController,
                maxLines: 1,
                isDark: isDark,
                validator: (value){
                  if ( value == null || value.isEmpty) {
                    return "Password is required , Check Password.";
                  }
                  if (!regexPassword.hasMatch(value)) {
                    return "Password must be at least 8 characters, including uppercase, lowercase, numbers and special characters.";
                  }
                  return null;
                },
                text: appLocalizations.enterPassword,
                isPassword: isActive,
                customPrefixWidget: Assets.icons.lockIcn.svg(
                  width: 24,
                  height: 24,
                ),
                customSuffixWidget: InkWell(
                  onTap: (){
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                  child: isActive ? Assets.icons.eyeSlashIcn.svg(
                    width: 15,
                    height: 15,
                  ):Icon(Icons.remove_red_eye_outlined,color:AppColor.hintTextColor,),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, PagesRouteName.forgetPasswordScreen);
                    },
                    child: Text(
                      appLocalizations.forgetPassword,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark? AppColor.lightBlueColor:AppColor.primaryColor,
                        decorationThickness: 1.5,
                        decorationColor: isDark? AppColor.lightBlueColor :AppColor.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButtonWidget(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()) {
                          EasyLoading.show();
                          bool success = await FirebaseAuthUtils
                              .singInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text
                          );
                          if (success) {
                            var user = FirebaseAuth.instance.currentUser;

                            await user
                        ?.reload();
                        user = FirebaseAuth.instance.currentUser;

                        if (user != null && user.emailVerified) {
                        EasyLoading.dismiss();
                        Navigator.pushNamedAndRemoveUntil(
                        context,
                        PagesRouteName.homeLayoutScreen,
                        (route) => false,
                        );
                        } else {
                        await FirebaseAuthUtils.singOut();
                        EasyLoading.dismiss();
                        ToastMessage.showErrorMessage("Please verify your email first. Check your inbox.");
                        }
                        } else {
                        EasyLoading.dismiss();
                        }
                      }
                      },
                      backgroundColor: isDark ? AppColor.lightBlueColor: AppColor.primaryColor,
                      customChildWidget: Text(appLocalizations.login,style: theme.textTheme.titleLarge,textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: appLocalizations.doNotHaveAccount,
                        style: theme.textTheme.bodyMedium,
                      ),
                      WidgetSpan(
                        child: Bounceable(
                          onTap: () {
                            Navigator.pushNamed(context, PagesRouteName.signUpScreen);
                          },
                          child: Text(
                            appLocalizations.signUp,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColor.lightBlueColor : AppColor.primaryColor,
                              decoration:TextDecoration.underline,
                              decorationColor: isDark ? AppColor.lightBlueColor : AppColor.primaryColor,
                              decorationThickness: 1.5,
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
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark ? AppColor.blueColor:AppColor.strokeColor,
                      thickness: 1,
                      endIndent: 15,
                      indent: 15,
                    ),
                  ),
                  Text(appLocalizations.or, style: theme.textTheme.bodyLarge),
                  Expanded(
                    child: Divider(
                      color: isDark ? AppColor.blueColor:AppColor.strokeColor,
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
                      onPressed: (){
                        {
                          EasyLoading.show();
                          FirebaseAuthUtils.signInWithGoogle().then((userCredential) {
                            EasyLoading.dismiss();
                            if (userCredential != null) {
                              ToastMessage.showSuccessMessage("Login with Google successful!");
                              Navigator.pushNamedAndRemoveUntil(context, PagesRouteName.homeLayoutScreen, (route) => false);
                            }
                          });
                        }
                      },
                      backgroundColor:isDark ? AppColor.secondDarkBlueColor : AppColor.whiteColor,
                      customChildWidget:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.googleIcn.svg(
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 4,),
                          Text(appLocalizations.loginWithGoogle,style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? AppColor.lightBlueColor: AppColor.primaryColor,
                          ),)
                        ],
                      ),
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

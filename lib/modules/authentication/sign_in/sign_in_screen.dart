import 'package:evently_app/core/extension/padding_extension.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/routes/pages_route_name.dart';
import 'package:evently_app/core/theme/app_color.dart';
import 'package:evently_app/core/widget/custom_app_bar_widget.dart';
import 'package:evently_app/core/widget/custom_elevated_button_widget.dart';
import 'package:evently_app/core/widget/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

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
                        color: AppColor.primaryColor,
                        decorationThickness: 1.5,
                        decorationColor: AppColor.primaryColor,
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
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          Navigator.pushNamedAndRemoveUntil(context, PagesRouteName.homeLayoutScreen,(route) => false,);
                        }
                      },
                      customChildWidget: Text(appLocalizations.login,style: theme.textTheme.titleLarge,textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              RichText(
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
                            color: AppColor.primaryColor,
                            decoration:TextDecoration.underline,
                            decorationColor: AppColor.primaryColor,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColor.strokeColor,
                      thickness: 1,
                      endIndent: 15,
                      indent: 15,
                    ),
                  ),
                  Text(appLocalizations.or, style: theme.textTheme.bodyLarge),
                  Expanded(
                    child: Divider(
                      color: AppColor.strokeColor,
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
                      onPressed: (){},
                      backgroundColor: AppColor.whiteColor,
                      customChildWidget:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.googleIcn.svg(
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 4,),
                          Text(appLocalizations.loginWithGoogle,style: theme.textTheme.titleMedium,)
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

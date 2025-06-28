import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/res/constants/assets/const_images.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var layout = Layout(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (layout.isDesktop || layout.isTablet) {
          return Scaffold(
            backgroundColor: appColors.appBackground,
            body: Center(
              child: SizedBox(
                height: h * 0.7,
                width: layout.isMobile
                    ? MediaQuery.of(context).size.width * 0.95
                    : MediaQuery.of(context).size.width * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: appColors.appBackground,
                    boxShadow: [
                      BoxShadow(
                        color: appColors.borderColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 0.5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ConstantImage.logoWithName,
                                  scale: 2.4,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: h * 0.0015),

                              Text(
                                texts.welcome,
                                style: context.textTheme.titleLarge,
                              ),

                              SizedBox(height: h * 0.025),
                              AppTextField(
                                controller: email,
                                hintText: texts.emailAddressHint,
                                labelText: texts.emailAddress,

                              ),
                              const SizedBox(height: 20),
                              AppTextField(
                                obscureText: !isPasswordVisible,
                                controller: password,
                                hintText: texts.passwordHint,
                                labelText: texts.password,

                                iconData: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: isPasswordVisible
                                      ? Icon(
                                          Icons.visibility,
                                          color: appColors.editTextColor,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: appColors.editTextColor,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              AppButton(
                                radius: 12,
                                onPressed: () {
                                  context.goNamed('Dashboard');
                                },
                                title: texts.login,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: appColors.appBackground,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: h * 0.8,
                width: layout.isMobile
                    ? MediaQuery.of(context).size.width * 0.9
                    : MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: appColors.appBackground,
                  boxShadow: [
                    BoxShadow(
                      color: appColors.borderColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 0.5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      ConstantImage.logoWithName,
                      fit: BoxFit.contain,
                      scale: 4,
                      // Ensures proper scaling
                    ),
                    SizedBox(width: w * 0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: h * 0.015),
                        Text(
                          texts.welcome,
                          style: context.textTheme.titleLarge,
                        ),

                        SizedBox(height: h * 0.07),
                        AppTextField(
                          controller: email,
                          hintText: texts.emailAddressHint,
                          labelText: texts.emailAddress,

                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          obscureText: !isPasswordVisible,
                          controller: password,
                          hintText: texts.passwordHint,
                          labelText: texts.password,

                          iconData: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isPasswordVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: appColors.editTextColor,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: appColors.editTextColor,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          radius: 12,
                          onPressed: ()  {
                            context.goNamed('Dashboard');
                          },
                          title: texts.login,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }


}

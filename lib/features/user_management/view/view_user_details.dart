import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:policy_vault_admin/features/user_management/view/family_member.dart';
import 'package:policy_vault_admin/features/user_management/view/my_policies.dart';
import 'package:policy_vault_admin/features/user_management/view/personal_documents.dart';
import 'package:policy_vault_admin/features/user_management/view/profile_data.dart';
import 'package:policy_vault_admin/features/user_management/view/shared_policies.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/res/widgets/custom_image.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/responsive/responsive_wrapper.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class ViewUserDetails extends StatefulWidget {
  const ViewUserDetails({super.key});

  @override
  State<ViewUserDetails> createState() => _ViewUserDetailsState();
}

class _ViewUserDetailsState extends State<ViewUserDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var layout = LayoutHelper(context);
    return Scaffold(
      backgroundColor: appColors.screenBg,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(width: 2, color: appColors.borderColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: ImageLock(
                      radius: 80,
                      imageUrl: "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User Name",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontSize: 22,
                        ),
                      ),
                      ResponsiveWrapper(
                        rowMainAxisAlignment: MainAxisAlignment.start,
                        isColumn: layout.isTablet || layout.isMobile,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: context.textTheme.labelMedium,
                              children: <TextSpan>[
                                TextSpan(text: "${texts.customerId} : "),

                                TextSpan(
                                  text: "32",
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: appColors.primary,
                            height: 16,
                            width: 1,
                            margin: EdgeInsets.symmetric(horizontal: 12),
                          ),

                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: context.textTheme.labelMedium,
                              children: <TextSpan>[
                                TextSpan(text: "${texts.phone} : "),

                                TextSpan(
                                  text: "9795541234",
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: appColors.primary,
                            height: 16,
                            width: 1,
                            margin: EdgeInsets.symmetric(horizontal: 12),
                          ),

                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: context.textTheme.labelMedium,
                              children: <TextSpan>[
                                TextSpan(text: "${texts.dob} : "),

                                TextSpan(
                                  text: "07/08/1999",
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            color: appColors.primary,
                            height: 16,
                            width: 1,
                            margin: EdgeInsets.symmetric(horizontal: 12),
                          ),

                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: context.textTheme.labelMedium,
                              children: <TextSpan>[
                                TextSpan(text: "${texts.email} : "),

                                TextSpan(
                                  text: "admin@gmail.com",
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColors.appBackground,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: appColors.borderColor.withValues(alpha: 0.2),
                    blurRadius: 4,
                    spreadRadius: 0.3,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2.0,
                    type: MaterialType.transparency,
                    shadowColor: appColors.borderColor,
                    animationDuration: Duration(milliseconds: 100),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: appColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      labelPadding: EdgeInsets.symmetric(vertical: 0),
                      labelColor: appColors.appWhite,
                      unselectedLabelColor: appColors.titleColor,
                      controller: _tabController,
                      indicatorAnimation: TabIndicatorAnimation.linear,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.fill,
                      isScrollable: false,
                      labelStyle: context.textTheme.labelMedium,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: appColors.primary,
                      tabs: [
                        Tab(text: texts.profileData),
                        Tab(text: texts.familyMembers),
                        Tab(text: texts.personalDocuments),
                        Tab(text: texts.myPolicy),
                        Tab(text: texts.sharedPolicy),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Flexible(
                    child: TabBarView(
                      dragStartBehavior: DragStartBehavior.start,
                      controller: _tabController,
                      children: [
                        ProfileData(),
                        FamilyMember(),
                        PersonalDocuments(),
                        MyPolicies(),
                        SharedPolicies(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

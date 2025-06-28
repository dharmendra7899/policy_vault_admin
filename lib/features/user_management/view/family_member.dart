import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';
import 'package:policy_vault_admin/utils.dart';

class FamilyMember extends StatefulWidget {
  const FamilyMember({super.key});

  @override
  State<FamilyMember> createState() => _FamilyMemberState();
}

class _FamilyMemberState extends State<FamilyMember> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: appColors.borderColor,
            ),
            color: appColors.appWhite,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appColors.gradient2,
                      appColors.gradient3,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.decal,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    Utils.getInitials("Dharmendra"),
                    style: context.textTheme.titleLarge
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: appColors.appWhite,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(softWrap: true,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Mr. Nano",
                            style: context.textTheme.labelMedium,
                          ),

                          TextSpan(
                            text:  " (Brother)",
                            style:  context.textTheme.labelSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ],
                      ),
                    ),

                    Text(
                      "+91 9876543209",
                      style: context.textTheme.labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),


                  ],
                ),
              ),

            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 2);
      },
    );
  }
}

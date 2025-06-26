import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/constants/assets/const_images.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AdminAvatarMenu extends StatefulWidget {
  const AdminAvatarMenu({super.key});

  @override
  State<AdminAvatarMenu> createState() => _AdminAvatarMenuState();
}

class _AdminAvatarMenuState extends State<AdminAvatarMenu> {
  final GlobalKey _avatarKey = GlobalKey();
  bool isHovered = false;
  bool isMenuOpen = false;

  void _showFixedMenu(BuildContext context) {
    if (isMenuOpen) return;
    final RenderBox renderBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset avatarPosition = renderBox.localToGlobal(Offset.zero);
    final Size avatarSize = renderBox.size;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset menuOffset = Offset(
      avatarPosition.dx + avatarSize.width,
      avatarPosition.dy + 40,
    );

    isMenuOpen = true;

    showMenu(
      context: context,
      color: appColors.appWhite,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(menuOffset.dx, menuOffset.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          height: 30,
          child: Text(texts.welcomeAdmin, style: context.textTheme.labelSmall),
        ),
        PopupMenuItem(
          height: 40,
          onTap: () => _logOutDialog(),
          child: Row(
            children: [
              Icon(Icons.logout, color: appColors.error, size: 20),
              SizedBox(width: 10),
              Text(texts.logout, style: context.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    ).then((_) {
      setState(() {
        isMenuOpen = false;
        isHovered = false;
      });
    });
  }

  Future<void> _logOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appColors.appWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(texts.logout, style: context.textTheme.bodyLarge),
          content: Text(
            texts.logoutHeading,
            style: context.textTheme.bodyLarge,
          ),
          actions: <Widget>[
            AppButton(
              radius: 16,
              width: MediaQuery.of(context).size.width * 0.06,
              onPressed: () {
                // _logout();
              },
              title: texts.yes,
            ),
            AppButton(
              radius: 16,
              width: MediaQuery.of(context).size.width * 0.06,
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: texts.no,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, top: 0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() => isHovered = true);
          _showFixedMenu(context);
        },
        onExit: (_) {
          setState(() => isHovered = false);
        },
        child: GestureDetector(
          onTap: () {
            _showFixedMenu(context);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            key: _avatarKey,
            decoration: BoxDecoration(
              color: isHovered ? appColors.appWhite : Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: appColors.appWhite,
              backgroundImage: AssetImage(ConstantImage.admin),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/features/side_menu/provider/side_menu_provider.dart';
import 'package:policy_vault_admin/features/side_menu/view/admin_avatar_menu.dart';
import 'package:policy_vault_admin/res/constants/assets/const_images.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/theme/colors.dart';
import 'package:provider/provider.dart';

class AdminWrapper extends StatefulWidget {
  final Widget child;

  const AdminWrapper({super.key, required this.child});

  @override
  State<AdminWrapper> createState() => _AdminWrapperState();
}

class _AdminWrapperState extends State<AdminWrapper> {
  String? expandedMenuTitle;
  int? hoverIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SideMenuProvider>(context, listen: false);
      final currentPath = Uri.base.path;
      provider.getActiveIndex(currentPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return isMobile ? _drawer() : _scaffoldLayout();
  }

  Widget _scaffoldLayout() {
    return Scaffold(
      body: Row(
        children: [
          _sideMenu(),
          Expanded(
            child: Column(
              children: [
                _topBar(),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: appColors.appBackground,
        boxShadow: [
          BoxShadow(
            color: appColors.borderColor.withValues(alpha: 0.2),
            blurRadius: 4,
            spreadRadius: 0.3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Consumer<SideMenuProvider>(
          builder: (context, provider, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (provider.previousRoute.isNotEmpty)
                  Row(
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => context.go(provider.previousRoute),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                Expanded(
                  child: SelectableText(
                    provider.activeTitle,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: appColors.titleColor,
                    ),
                  ),
                ),
                const AdminAvatarMenu(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _drawer() {
    return Consumer<SideMenuProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appColors.appBackground,
            title: Row(
              children: [
                if (provider.previousRoute.isNotEmpty)
                  Row(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 20),
                          onPressed: () => context.go(provider.previousRoute),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                SelectableText(
                  provider.activeTitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: appColors.titleColor,
                  ),
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: AdminAvatarMenu(),
              ),
            ],
          ),
          drawer: _sideMenu(),
          body: widget.child,
        );
      },
    );
  }

  Widget _sideMenu() {
    final layout = LayoutHelper(context);
    double widthFactor;
    if (layout.isMobileS) {
      widthFactor = 0.95;
    } else if (layout.isMobileM) {
      widthFactor = 0.90;
    } else if (layout.isMobileL) {
      widthFactor = 0.85;
    } else if (layout.isTablet) {
      widthFactor = 0.30;
    } else if (layout.isLaptop) {
      widthFactor = 0.24;
    } else if (layout.isDesktop) {
      widthFactor = 0.18;
    } else {
      widthFactor = 0.14;
    }

    return Consumer<SideMenuProvider>(
      builder: (context, provider, _) {
        final menuItems = <Map<String, dynamic>>[];

        for (var item in provider.sideMenu) {
          menuItems.add(item);
          if (item['title'] == expandedMenuTitle && item['children'] is List) {
            final children = item['children'] as List;
            for (var child in children) {
              menuItems.add({
                ...child as Map<String, dynamic>,
                'isChild': true,
              });
            }
          }
        }

        return Container(
          width: layout.screenWidth * widthFactor,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appColors.policyGradient1, appColors.policyGradient2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.decal,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(ConstantImage.logoWithName, scale: 5),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: menuItems.length,
                  separatorBuilder: (_, __) => SizedBox(),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final isChild = item['isChild'] == true;
                    final isActive = provider.activeIndex == item['index'];
                    final isParent = item['children'] is List;
                    final isHovered = hoverIndex == index;

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoverIndex = index),
                      onExit: (_) => setState(() => hoverIndex = null),
                      child: Container(
                        color: isActive
                            ? appColors.appBackground
                            : isHovered
                            ? appColors.appBackground.withValues(alpha: 0.1)
                            : null,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: isChild ? 40 : 16,
                            right: 16,
                          ),
                          visualDensity: const VisualDensity(horizontal: -4),
                          onTap: () {
                            final isMobile =
                                MediaQuery.of(context).size.width < 600;

                            if (isParent) {
                              setState(() {
                                expandedMenuTitle =
                                    expandedMenuTitle == item['title']
                                    ? null
                                    : item['title'];
                              });
                              provider.setActiveIndex(
                                item['index'],
                                item['title'],
                              );
                              return;
                            }

                            provider.setActiveIndex(
                              item['index'],
                              item['title'],
                            );
                            if (isMobile) Navigator.of(context).pop();

                            context.go(item['route']);
                          },
                          leading: Icon(
                            item['icon'],
                            size: 20,
                            color: isActive
                                ? appColors.titleColor
                                : isChild
                                ? appColors.editTextColor
                                : isHovered
                                ? appColors.appWhite
                                : appColors.titleColor1,
                          ),
                          trailing: isParent
                              ? Icon(
                                  expandedMenuTitle == item['title']
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: appColors.titleColor1,
                                )
                              : null,
                          title: Text(
                            item['title'] ?? '',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontSize: isChild ? 14 : 16,
                              color: isActive
                                  ? appColors.titleColor
                                  : isHovered
                                  ? appColors.appWhite
                                  : appColors.titleColor1,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

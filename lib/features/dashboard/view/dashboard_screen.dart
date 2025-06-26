import 'package:flutter/material.dart';
import 'package:policy_vault_admin/features/dashboard/view/expired_policies.dart';
import 'package:policy_vault_admin/features/dashboard/view/hover_card.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> dashboardItems = [
    {'icon': Icons.person, 'label': 'Total Customers', 'value': 52},
    {'icon': Icons.directions_car, 'label': 'Car Insurance', 'value': 32},
    {'icon': Icons.pedal_bike, 'label': '2 Wheeler Insurance', 'value': 10},
    {'icon': Icons.local_hospital, 'label': 'Health Insurance', 'value': 8},
    {'icon': Icons.check_box, 'label': 'Term Insurance', 'value': 26},
    {
      'icon': Icons.local_shipping,
      'label': 'Commercial Vehicle In',
      'value': 6,
    },
    {'icon': Icons.show_chart, 'label': 'Investment Plan', 'value': 10},
  ];

  final List<String> filters = ['All', 'Weekly', 'Monthly', 'Yearly'];
  int selectedFilterIndex = 0;
  final Set<int> _hoveredIndexes = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 900
        ? 3
        : screenWidth > 800
        ? 2
        : 2;

    const double gridSpacing = 16;
    const double horizontalPadding = 24;

    double totalSpacing = gridSpacing * (crossAxisCount - 1);
    double usableWidth = screenWidth - totalSpacing - horizontalPadding;
    double itemWidth = usableWidth / crossAxisCount;
    const double itemHeight = 100;

    double childAspectRatio = itemWidth / itemHeight;

    return Scaffold(
      backgroundColor: appColors.screenBg,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appColors.appBackground,
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
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 4,
                        children: List.generate(filters.length, (index) {
                          final selected = index == selectedFilterIndex;
                          final hovered = _hoveredIndexes.contains(index);
                          return MouseRegion(
                            onEnter: (_) =>
                                setState(() => _hoveredIndexes.add(index)),
                            onExit: (_) =>
                                setState(() => _hoveredIndexes.remove(index)),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => selectedFilterIndex = index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 35,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected
                                      ? appColors.policyGradient1
                                      : hovered
                                      ? Colors.grey.shade200
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  filters[index],
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: selected
                                        ? appColors.appBackground
                                        : appColors.titleColor1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Divider(thickness: 1),
                    const SizedBox(height: 6),
          
                    GridView.builder(
                      itemCount: dashboardItems.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final item = dashboardItems[index];
                        return HoverCard(item: item);
                      },
                    ),
                  ],
                ),
              ),

          
              ExpiredPolicies(),


            ],
          ),
        ),
      ),
    );
  }
}

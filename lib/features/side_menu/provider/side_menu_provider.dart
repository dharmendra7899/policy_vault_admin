import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  String _activeTitle = 'Dashboard';

  String get activeTitle => _activeTitle;

  String _previousRoute = '';

  String get previousRoute => _previousRoute;

  List<Map<String, dynamic>> sideMenu = [
    {
      'title': 'Dashboard',
      'route': '/dashboard',
      'index': 0,
      'icon': Icons.dashboard,
    },
    {
      'title': 'Users Management',
      'route': '/users-management',
      'index': 1,
      'icon': Icons.supervised_user_circle_sharp,
    },
    {
      'title': 'CMS',
      'route': '/cms',
      'index': 2,
      'icon': Icons.edit,
      'children': [
        {
          'route': '/about-us',
          'title': 'About Us',
          'index': 5,
          'icon': Icons.remove,
        },
        {'route': '/faqs', 'title': 'FAQs', 'index': 6, 'icon': Icons.remove},
        {
          'route': '/claim-information',
          'title': 'Claim Information',
          'index': 7,
          'icon': Icons.remove,
        },
        {
          'route': '/insurance-company',
          'title': 'Insurance Company',
          'index': 8,
          'icon': Icons.remove,
        },
      ],
    },
    {
      'title': 'Support Management',
      'route': '/support-management',
      'index': 3,
      'icon': Icons.support_agent,
    },
    {
      'title': 'Manage Admin User',
      'route': '/manage-admin',
      'index': 4,
      'icon': Icons.person_pin_outlined,
    },
  ];

  setActiveIndex(int index, String title) {
    _activeIndex = index;
    _activeTitle = title;
    notifyListeners();
  }

  getActiveIndex(String route) async {
    for (var item in sideMenu) {
      if (item['route'] == route) {
        _activeIndex = item['index'];
        _activeTitle = item['title'];
        _previousRoute = '';
        notifyListeners();
        return;
      } else {
        if (item['children'].isNotEmpty) {
          for (var child in item['children']) {
            if (child['children'] != null && child['route'] != route) {
              try {
                for (var subChild in child['children']) {
                  if (subChild['route'] == route) {
                    _activeIndex = item['index'];
                    _activeTitle = subChild['title'];
                    _previousRoute = child['route'];
                    notifyListeners();
                    return;
                  }
                }
              } catch (e) {
                debugPrint("Exception error ::: $e");
              }
            } else if (child['route'] == route) {
              _activeIndex = item['index'];
              _activeTitle = child['title'];
              _previousRoute = item['route'];
              notifyListeners();
              return;
            }
          }
        }
      }
    }
    return 0;
  }
}

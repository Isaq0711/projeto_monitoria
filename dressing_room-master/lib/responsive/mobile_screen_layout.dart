import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dressing_room/utils/colors.dart';
import 'package:dressing_room/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  late double _panelHeightOpen;
  late double _panelHeightClosed;
  late bool _isPanelVisible;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _isPanelVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigateToFeedPage() {
    pageController.jumpToPage(0);
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  Widget _buildPanel(ScrollController sc) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.vinho,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? AppTheme.nearlyWhite : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: (_page == 1) ? AppTheme.nearlyWhite : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: (_page == 2) ? AppTheme.nearlyWhite : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_add,
              color: (_page == 3) ? AppTheme.nearlyWhite : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? AppTheme.nearlyWhite : Colors.grey,
            ),
            label: '',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppTheme.nearlyWhite,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.1;
    _panelHeightClosed = MediaQuery.of(context).size.height * 0.03;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
          children: homeScreenItems, // Replace this with your list of pages
            controller: pageController,
            onPageChanged: onPageChanged,
          ),
          SlidingUpPanel(
            color: AppTheme.vinho,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            body: Container(),
            panelBuilder: (scrollController) => _buildPanel(scrollController),
            collapsed: GestureDetector(
              onTap: () {
                setState(() {
                  _isPanelVisible = !_isPanelVisible;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.vinho,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.remove),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

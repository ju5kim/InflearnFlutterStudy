import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/common/layout/default_layout.dart';
import 'package:flutter_study_feat_infrun/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int defaultindex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    // 컨트롤러 수행시 자동 실
    tabController.addListener(tabcontrollerlistenr);
  }

  void tabcontrollerlistenr() {
    setState(() {
      defaultindex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.removeListener(tabcontrollerlistenr);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "코펙딜리버",
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        selectedFontSize: 15.0,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 10.0,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        currentIndex: defaultindex,
        onTap: (int index) {
          // 기존 셋스테이트를 상위에서 컨트롤러셋업할때 컨트롤러리스너에 셋업한다.
          // setState(() {
          //   defaultindex = index;
          // });
          tabController.index = index;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: "음식"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: "주문"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "프로필"),
        ],
      ),
      child: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(child: RestaurantScreen()),
          Center(
            child: Container(
              child: Text("음식"),
            ),
          ),
          Center(
            child: Container(
              child: Text("주문"),
            ),
          ),
          Center(
            child: Container(
              child: Text("프로필"),
            ),
          ),
        ],
      ),
    );
  }
}

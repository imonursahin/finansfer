import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/ui/rate/gold_tracking/gold_favorites_page.dart';
import 'package:finansfer/ui/rate/gold_tracking/gold_list_page.dart';
import 'package:flutter/material.dart';

class GoldTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors.brightMainColor,
            title: Text('Altın Takip'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list_alt), text: "Altın Listesi"),
                Tab(icon: Icon(Icons.favorite), text: "Favorilerim")
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: AppColors.mainColor),
            child: TabBarView(
              children: [
                GoldListPage(),
                GoldFavoritesPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'currency_favorites_page.dart';
import 'currency_list_page.dart';

class CurrencyTrackingPage extends StatelessWidget {
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
            title: Text('Döviz Takip'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list_alt), text: "Döviz Listesi"),
                Tab(icon: Icon(Icons.favorite), text: "Favorilerim")
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: AppColors.mainColor),
            child: TabBarView(
              children: [
                CurrencyListPage(),
                CurrencyFavoritesPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

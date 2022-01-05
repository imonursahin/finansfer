import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/ui/finance/debit%20record/debit_record_home_page.dart';
import 'package:finansfer/ui/finance/finance_home_page.dart';
import 'package:finansfer/ui/finance/income_expense/income_expense_page.dart';
import 'package:finansfer/ui/finance/payment_planner/payment_planner_home_page.dart';
import 'package:finansfer/ui/finance/todo/todo_home_page.dart';
import 'package:finansfer/ui/iban/iban_page.dart';
import 'package:finansfer/ui/kurumsal/invoice/invoice_home_page.dart';
import 'package:finansfer/ui/kurumsal/kurumsal_home_page.dart';
import 'package:finansfer/ui/kurumsal/stock/stock_home_page.dart';
import 'package:finansfer/ui/news/news_page.dart';
import 'package:finansfer/ui/rate/crypto_tracking/crypto_tracking_page.dart';
import 'package:finansfer/ui/rate/currency_tracking/currency_tracking_page.dart';
import 'package:finansfer/ui/rate/gold_tracking/gold_tracking_page.dart';
import 'package:finansfer/ui/rate/rate_home_page.dart';
import 'package:finansfer/ui/rate/unit_converter/unit_rates.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? pageController;
  int currentTabIndex = 0;
  String? userEmail = "";

  @override
  void initState() {
    super.initState();
    getUserEmail();
    pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  onTapped(int index) {
    if (index != 1 && index != 2 && index != 4) {
      pageController?.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      IbanPage(),
      Container(),
      Container(),
      NewsHomePage(),
      Container(),
    ];

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: tabs,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: AppColors.btnOrange,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTabIndex,
          onTap: onTapped,
          items: createBottomBarItems()),
    );
  }

  createBottomBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.credit_card),
        label: "İban",
      ),
      BottomNavigationBarItem(
          icon: InkWell(
            child: Icon(Icons.wallet_membership),
            onTap: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) => openFinansBottomDrawer());
            },
          ),
          label: "Finans"),
      BottomNavigationBarItem(
          icon: InkWell(
            child: Icon(Icons.price_check),
            onTap: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) => openKurlarBottomDrawer());
            },
          ),
          label: "Kurlar"),
      BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: "Haberler"),
      BottomNavigationBarItem(
          icon: InkWell(
            child: Icon(Icons.menu_open),
            onTap: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) =>
                      openKurumsalBottomDrawer());
            },
          ),
          label: "Kurumsal"),
    ];
  }

  Widget openFinansBottomDrawer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Gelir-Gider Takibi'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return IncomeExpensePage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Ödeme Planlayıcısı'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return PaymentPlannerHomePage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.today_outlined),
                title: const Text('Bugün Yapılacaklar'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ToDoDaily(userEmail ?? "");
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.today_outlined),
                title: const Text('Borç Kaydı'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DebitRecordHomePage(userEmail ?? "");
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget openKurlarBottomDrawer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.graphic_eq_outlined),
                title: const Text('Altın Takip'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return GoldTrackingPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.graphic_eq_outlined),
                title: const Text('Döviz Takip'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CurrencyTrackingPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.graphic_eq_outlined),
                title: const Text('Kripto Para Takip'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CryptoTrackingPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.graphic_eq_outlined),
                title: const Text('Kur Dönüştürücü'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return UnitRates();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget openKurumsalBottomDrawer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.inventory),
                title: const Text('Stok Yönetimi'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return StockHomePage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory_sharp),
                title: const Text('Fatura Oluştur'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return InvoiceHomePage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString("userEmail");
  }
}

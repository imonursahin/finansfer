import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finansfer/core/network/models/request/debit_record.dart';
import 'package:finansfer/core/network/models/request/iban_req.dart';
import 'package:finansfer/core/network/models/request/income_expense.dart';
import 'package:finansfer/core/network/models/request/payment_planner.dart';
import 'package:finansfer/core/network/models/request/stock.dart';
import 'package:finansfer/core/network/models/request/suppliper.dart';
import 'package:finansfer/core/network/models/request/user_req.dart';
import 'package:finansfer/core/network/models/response/exchange_crypto_data.dart';
import 'package:finansfer/core/network/models/response/exchange_gold_data.dart';
import 'package:finansfer/core/network/models/response/exchange_currency_data.dart';
import 'package:finansfer/core/network/models/response/exchange_gold_resp.dart';
import 'package:finansfer/core/network/models/request/todo.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  static Future<void> addUser(UserReq data) async {
    DocumentReference documentReferencer = _mainCollection.doc(data.email);

    await _mainCollection.doc(data.email).collection("iban").add({});
    await _mainCollection.doc(data.email).collection("favoriteGold").add({});
    await _mainCollection
        .doc(data.email)
        .collection("favoriteCurrency")
        .add({});
    await _mainCollection.doc(data.email).collection("favoriteCoin").add({});
    await _mainCollection.doc(data.email).collection("incomeExpense").add({});
    await _mainCollection.doc(data.email).collection("paymentPlanner").add({});
    await _mainCollection.doc(data.email).collection("sale").add({});

    await documentReferencer.set(data.toJson());
  }

  static Future<bool> isUserExist(UserReq data) async {
    List<IbanReq> ibanResp = [];
    bool isExist = false;
    DocumentReference userDoc = _mainCollection.doc(data.email);

    var userObj = await userDoc.get();

    if (!userObj.exists) {
      return false;
    }

    return true;
  }

  static Future<void> addIban(IbanReq data, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("iban").doc();

    await documentReferencer.set(data.toJson());

    return;
  }

  static Future<void> deleteIban(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('iban').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  static Future<List<IbanReq>> getIbansByEmail(String email) async {
    List<IbanReq> ibanResp = [];
    CollectionReference ibanCollect =
        _mainCollection.doc(email).collection('iban');

    var ibanDocs = await ibanCollect.get();

    for (var item in ibanDocs.docs) {
      DocumentReference ibanRef =
          _mainCollection.doc(email).collection('iban').doc(item.id);
      var ibanDoc = await ibanRef.get();
      var ibanData = ibanDoc.data() as Map<String, dynamic>;
      if (ibanData.isNotEmpty) {
        IbanReq temp = IbanReq.fromJson(ibanData);
        temp.docId = ibanDoc.id;
        ibanResp.add(temp);
      }
    }
    return ibanResp;
  }

  // Favorite Golds
  static Future<void> addGoldFavorite(String goldName, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("favoriteGold").doc();

    await documentReferencer.set({'name': goldName});

    return;
  }

  static Future<List<ExchangeGoldData>> getGoldFavorite(String email) async {
    List<ExchangeGoldData> goldResp = [];
    CollectionReference goldCollect =
        _mainCollection.doc(email).collection('favoriteGold');

    var goldDocs = await goldCollect.get();

    for (var item in goldDocs.docs) {
      DocumentReference goldRef =
          _mainCollection.doc(email).collection('favoriteGold').doc(item.id);
      var goldDoc = await goldRef.get();
      var goldData = goldDoc.data() as Map<String, dynamic>;
      if (goldData.isNotEmpty) {
        goldResp
            .add(ExchangeGoldData(type: goldData['name'], docId: goldDoc.id));
      }
    }
    return goldResp;
  }

  static Future<void> deleteGoldFavorite(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('favoriteGold').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // Favorite Currency-----------------------------------------------------------------
  static Future<void> addCurrencyFavorite(
      String currencyName, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("favoriteCurrency").doc();

    await documentReferencer.set({'name': currencyName});

    return;
  }

  static Future<List<ExchangeCurrencyData>> getCurrencyFavorite(
      String email) async {
    List<ExchangeCurrencyData> currencyResp = [];
    CollectionReference currencyCollect =
        _mainCollection.doc(email).collection('favoriteCurrency');

    var currencyDocs = await currencyCollect.get();

    for (var item in currencyDocs.docs) {
      DocumentReference currencyRef = _mainCollection
          .doc(email)
          .collection('favoriteCurrency')
          .doc(item.id);
      var currencyDoc = await currencyRef.get();
      var currencyData = currencyDoc.data() as Map<String, dynamic>;
      if (currencyData.isNotEmpty) {
        currencyResp.add(ExchangeCurrencyData(
            type: currencyData['name'], docId: currencyDoc.id));
      }
    }
    return currencyResp;
  }

  static Future<void> deleteCurrencyFavorite(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('favoriteCurrency').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // Favorite Coins--------------------------------------------------------
  static Future<void> addCoinFavorite(String coinName, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("favoriteCoin").doc();

    await documentReferencer.set({'name': coinName});

    return;
  }

  static Future<List<ExchangeCryptoData>> getCoinFavorite(String email) async {
    List<ExchangeCryptoData> coinResp = [];
    CollectionReference coinCollect =
        _mainCollection.doc(email).collection('favoriteCoin');

    var coinDocs = await coinCollect.get();

    for (var item in coinDocs.docs) {
      DocumentReference coinRef =
          _mainCollection.doc(email).collection('favoriteCoin').doc(item.id);
      var coinDoc = await coinRef.get();
      var coinData = coinDoc.data() as Map<String, dynamic>;
      if (coinData.isNotEmpty) {
        coinResp
            .add(ExchangeCryptoData(type: coinData['name'], docId: coinDoc.id));
      }
    }
    return coinResp;
  }

  static Future<void> deleteCoinFavorite(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('favoriteCoin').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // income expense tracking
  static Future<void> addIncomeExpense(
      IncomeExpense model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("incomeExpense").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<IncomeExpense>> getIncomeExpenseList(String email) async {
    List<IncomeExpense> incomeExpenseResp = [];
    CollectionReference incomeExpenseCollect =
        _mainCollection.doc(email).collection('incomeExpense');

    var incomeExpenseDocs = await incomeExpenseCollect.get();

    for (var item in incomeExpenseDocs.docs) {
      DocumentReference incomeExpenseRef =
          _mainCollection.doc(email).collection('incomeExpense').doc(item.id);
      var incomeExpenseDoc = await incomeExpenseRef.get();
      var incomeExpenseData = incomeExpenseDoc.data() as Map<String, dynamic>;
      if (incomeExpenseData.isNotEmpty) {
        IncomeExpense temp = IncomeExpense.fromJson(incomeExpenseData);
        temp.docId = incomeExpenseDoc.id;
        incomeExpenseResp.add(temp);
      }
    }
    return incomeExpenseResp;
  }

  static Future<void> deleteIncomeExpense(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('incomeExpense').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

// debit record-------------------------------------------------------------
  static Future<void> addDebitRecord(DebitRecord model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("debitRecord").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<DebitRecord>> debitList(String email) async {
    List<DebitRecord> debitRecordResp = [];
    CollectionReference debitRecordCollect =
        _mainCollection.doc(email).collection('debitRecord');

    var debitRecordDocs = await debitRecordCollect.get();

    for (var item in debitRecordDocs.docs) {
      DocumentReference debitRecordRef =
          _mainCollection.doc(email).collection('debitRecord').doc(item.id);
      var debitRecordDoc = await debitRecordRef.get();
      var debitRecordData = debitRecordDoc.data() as Map<String, dynamic>;
      if (debitRecordData.isNotEmpty) {
        DebitRecord temp = new DebitRecord();
        temp = DebitRecord.fromJson(debitRecordData);
        temp.docId = debitRecordDoc.id;
        debitRecordResp.add(temp);
      }
    }
    return debitRecordResp;
  }

  static Future<void> deleteDebitRecord(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('debitRecord').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // Others----------------------------------------------------------------
  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc().collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc().collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc().collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  // ToDo-------------------------------------------------------------
  static Future<void> addToDo(ToDo model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("toDo").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<ToDo>> todoList(String email) async {
    List<ToDo> toDoResp = [];
    CollectionReference toDoCollect =
        _mainCollection.doc(email).collection('toDo');

    var toDoDocs = await toDoCollect.get();

    for (var item in toDoDocs.docs) {
      DocumentReference toDoRef =
          _mainCollection.doc(email).collection('toDo').doc(item.id);
      var toDoDoc = await toDoRef.get();
      var toDoData = toDoDoc.data() as Map<String, dynamic>;
      if (toDoData.isNotEmpty) {
        ToDo temp = new ToDo();
        temp = ToDo.fromJson(toDoData);
        temp.docId = toDoDoc.id;
        toDoResp.add(temp);
      }
    }
    return toDoResp;
  }

  static Future<void> deleteToDo(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('toDo').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // STOCK------------------------------------------------------------------------
  static Future<void> addStock(Stock model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("stock").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<Stock>> getStockList(String email) async {
    List<Stock> stockResp = [];
    CollectionReference stockCollect =
        _mainCollection.doc(email).collection('stock');

    var stockDocs = await stockCollect.get();

    for (var item in stockDocs.docs) {
      DocumentReference stockRef =
          _mainCollection.doc(email).collection('stock').doc(item.id);
      var stockDoc = await stockRef.get();
      var stockData = stockDoc.data() as Map<String, dynamic>;
      if (stockData.isNotEmpty) {
        Stock temp = Stock.fromJson(stockData);
        temp.docId = stockDoc.id;
        stockResp.add(temp);
      }
    }
    return stockResp;
  }

  static Future<void> deleteStock(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('stock').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  static Future<void> updateStock(Stock model, String email, {
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('stock').doc(docId);

    await documentReferencer
        .update(model.toJson())
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

 // Sale
  static Future<void> addSale(Stock model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("sale").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<Stock>> getSaleList(String email) async {
    List<Stock> stockResp = [];
    CollectionReference stockCollect =
        _mainCollection.doc(email).collection('sale');

    var stockDocs = await stockCollect.get();

    for (var item in stockDocs.docs) {
      DocumentReference stockRef =
          _mainCollection.doc(email).collection('sale').doc(item.id);
      var stockDoc = await stockRef.get();
      var stockData = stockDoc.data() as Map<String, dynamic>;
      if (stockData.isNotEmpty) {
        Stock temp = Stock.fromJson(stockData);
        temp.docId = stockDoc.id;
        stockResp.add(temp);
      }
    }
    return stockResp;
  }

  static Future<void> deleteSale(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('sale').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }


  // Payment Planner
  static Future<void> addPaymentPlanner(
      PaymentPlanner model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("paymentPlanner").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<PaymentPlanner>> getPaymentPlanner(String email) async {
    List<PaymentPlanner> paymentPlannerResp = [];
    CollectionReference paymentPlannerCollect =
        _mainCollection.doc(email).collection('paymentPlanner');

    var paymentPlannerDocs = await paymentPlannerCollect.get();

    for (var item in paymentPlannerDocs.docs) {
      DocumentReference paymentPlannerRef =
          _mainCollection.doc(email).collection('paymentPlanner').doc(item.id);
      var paymentPlannerDoc = await paymentPlannerRef.get();
      var paymentPlannerData = paymentPlannerDoc.data() as Map<String, dynamic>;
      if (paymentPlannerData.isNotEmpty) {
        PaymentPlanner temp = PaymentPlanner.fromJson(paymentPlannerData);
        temp.docId = paymentPlannerDoc.id;
        paymentPlannerResp.add(temp);
      }
    }
    return paymentPlannerResp;
  }

  static Future<void> deletePaymentPlanner(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('paymentPlanner').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deleted'))
        .catchError((e) => print(e));
  }

  // Suppliper-------------------------------------------------------------
  static Future<void> addSuppliper(Suppliper model, String email) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection("suppliper").doc();

    await documentReferencer.set(model.toJson());

    return;
  }

  static Future<List<Suppliper>> suppliperList(String email) async {
    List<Suppliper> suppliperResp = [];
    CollectionReference suppliperCollect =
        _mainCollection.doc(email).collection('suppliper');

    var suppliperDocs = await suppliperCollect.get();

    for (var item in suppliperDocs.docs) {
      DocumentReference suppliperRef =
          _mainCollection.doc(email).collection('suppliper').doc(item.id);
      var suppliperDoc = await suppliperRef.get();
      var suppliperData = suppliperDoc.data() as Map<String, dynamic>;
      if (suppliperData.isNotEmpty) {
        Suppliper temp = new Suppliper();
        temp = Suppliper.fromJson(suppliperData);
        temp.docId = suppliperDoc.id;
        suppliperResp.add(temp);
      }
    }
    return suppliperResp;
  }

  static Future<void> deleteSuppliper(
    String docId,
    String email,
  ) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('suppliper').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Deletedd'))
        .catchError((e) => print(e));
  }
}

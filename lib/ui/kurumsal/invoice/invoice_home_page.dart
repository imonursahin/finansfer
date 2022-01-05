import 'package:finansfer/core/network/models/request/invoice_req.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/ui/kurumsal/invoice/file_handle_api.dart';
import 'package:finansfer/ui/kurumsal/invoice/pdf_invoice_api.dart';
import 'package:flutter/material.dart';

class InvoiceHomePage extends StatefulWidget {
  const InvoiceHomePage({Key? key}) : super(key: key);

  @override
  _InvoiceHomePageState createState() => _InvoiceHomePageState();
}

class _InvoiceHomePageState extends State<InvoiceHomePage> {
  List<InvoiceReq> invoiceList = [];

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController companyTitleController = TextEditingController();
  TextEditingController companyOwnerController = TextEditingController();
  TextEditingController companyContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: const Text('Fatura Oluştur'),
        backgroundColor: AppColors.brightMainColor,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: productTitleController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: 'Ürün İsmi',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.clear, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: productAmountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: 'Miktarı',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.clear, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: productPriceController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: 'Birim Fiyatı',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.clear, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                  child: Text(
                    'Ürünü Ekle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (productTitleController.text != "" &&
                      productAmountController.text != "" &&
                      productPriceController.text != "") {
                    invoiceList.add(InvoiceReq(
                        productTitle: productTitleController.text,
                        productAmount: productAmountController.text,
                        productPrice: productPriceController.text));
                  }
                  productTitleController.clear();
                  productAmountController.clear();
                  productPriceController.clear();
                }),
            const SizedBox(height: 15.0),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                child: Text(
                  'Fatura Oluştur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onPressed: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color(0xFF29313c),
                      elevation: 25,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      title: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          new Text("Şirket Bilgisi Ekle"),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                            ),
                            iconSize: 25,
                            color: Colors.red,
                            onPressed: () {
                              companyTitleController.clear();
                              companyOwnerController.clear();
                              companyContactController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      titleTextStyle:
                          TextStyle(fontSize: 18.0, color: Colors.white),
                      content: Container(
                        height: 220.0,
                        child: Column(
                          children: [
                            TextField(
                              controller: companyTitleController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                                border: OutlineInputBorder(),
                                labelText: 'Şirket İsmi',
                                labelStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.clear,
                                      size: 10, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: companyOwnerController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                                border: OutlineInputBorder(),
                                labelText: 'Şirket Yetkilisi',
                                labelStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.clear,
                                      size: 10, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: companyContactController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                                border: OutlineInputBorder(),
                                labelText: 'Şirket İletişim Bilgisi',
                                labelStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.clear,
                                      size: 10, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        // ignore: deprecated_member_use
                        new RaisedButton(
                          child: Text('İptal',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {
                            companyTitleController.clear();
                            companyOwnerController.clear();
                            companyContactController.clear();
                            Navigator.pop(context);
                          },
                        ),
                        // ignore: deprecated_member_use
                        new RaisedButton(
                          child: Text('Oluştur',
                              style: TextStyle(color: Colors.white)),
                          color: Color(0xFFf17c03),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () async {
                            List<List<String>> temp = [[]];
                            int netToplam = 0;

                            for (var item in invoiceList) {
                              int sum = int.parse(item.productAmount ?? '0') * int.parse(item.productPrice ?? '0');
                              netToplam += sum;

                              temp.add([item.productTitle.toString(), item.productAmount.toString(), item.productPrice.toString(), sum.toString()]);
                            }

                            // generate pdf file
                            final pdfFile = await PdfInvoiceApi.generate(temp, companyTitleController.text, companyOwnerController.text, companyContactController.text, netToplam);

                            // opening the pdf file
                            FileHandleApi.openFile(pdfFile);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.btnOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

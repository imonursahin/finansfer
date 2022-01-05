import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'flutter_iban_scanner_screen.dart';

GlobalKey scaffold = GlobalKey();

class IbanScannerPage extends StatefulWidget {
  @override
  _IbanScannerPageState createState() => _IbanScannerPageState();
}

class _IbanScannerPageState extends State<IbanScannerPage> {
  TextEditingController? _ibanController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initCameras();
    _ibanController = TextEditingController();
  }

  @override
  void dispose() {
    _ibanController?.dispose();
    super.dispose();
  }

  void _initCameras() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.brightMainColor,
        title: Text('İban Tarama'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  //  autofocus: true,
                  style: TextStyle(color: Colors.white),

                  cursorColor: Colors.white,
                  controller: _ibanController,
                  onChanged: (iban) => _ibanController?.value.copyWith(
                    text: iban,
                    selection: TextSelection(
                      baseOffset: iban.length,
                      extentOffset: iban.length,
                    ),
                  ),
                  // inputFormatters: [
                  //   MaskTextInputFormatter(
                  //     mask: '## #### #### #### #### #### #### ####',
                  //   ),
                  // ],
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: "IBAN Tarama",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () => {
                        focusNode.unfocus(),
                        focusNode.canRequestFocus = false,
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IBANScannerView(
                              cameras: cameras!,
                              onScannerResult: (iban) {
                                _ibanController?.text = iban;
                                Navigator.pop(context);
                              },
                              allowImagePicker: false,
                              allowCameraSwitch: false,
                            ),
                          ),
                        ),
                        Future.delayed(
                          Duration(milliseconds: 100),
                          () {
                            focusNode.canRequestFocus = true;
                          },
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(iban) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('IBAN Bilgisi Bulundu'),
          content: Text(iban),
          actions: <Widget>[
            TextButton(
              child: const Text('Tekrar Tara'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IBANScannerView(
                      cameras: cameras!,
                      onScannerResult: (iban) => {
                        Navigator.of(context).pop(),
                        _showMyDialog(iban),
                      },
                      allowImagePicker: false,
                      allowCameraSwitch: false,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Kopyala'),
              onPressed: () {
                Navigator.of(context).pop();
                _ibanController?.text = iban;
              },
            ),
          ],
        );
      },
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  DismissKeyboard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}

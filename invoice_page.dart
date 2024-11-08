import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? scannedResult;
  QRViewController? controller;
  bool isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (isScanning) {
      controller?.resumeCamera();
    } else {
      controller?.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // Method to handle scanning
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedResult = scanData;
        isScanning = false;
      });
      controller.pauseCamera();
    });
  }

  // Method for manual input
  void _showManualInputDialog() {
    TextEditingController productIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Product ID"),
          content: TextField(
            controller: productIdController,
            decoration: const InputDecoration(
              hintText: "Enter Product ID",
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (productIdController.text.isNotEmpty) {
                  _fetchProductDetails(productIdController.text);
                }
              },
              child: const Text("Enter"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Dummy function to fetch product details (replace with actual logic)
  void _fetchProductDetails(String productId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product ID Entered: $productId")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              setState(() {
                isScanning = true;
              });
              controller?.resumeCamera();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // QR Code Scanner Widget
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: scannedResult != null
                  ? Column(
                children: [
                  Text("Scanned Result: ${scannedResult!.code}"),
                  ElevatedButton(
                    onPressed: () {
                      _fetchProductDetails(scannedResult!.code!);
                    },
                    child: const Text("Fetch Product Details"),
                  ),
                ],
              )
                  : const Text("Scan a product QR/Barcode"),
            ),
          ),
          // Button to Enter Product ID Manually
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showManualInputDialog,
              icon: const Icon(Icons.edit),
              label: const Text("Enter Product ID Manually"),
            ),
          ),
        ],
      ),
    );
  }
}

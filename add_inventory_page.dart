import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddToInventoryPage extends StatefulWidget {
  const AddToInventoryPage({Key? key}) : super(key: key);

  @override
  State<AddToInventoryPage> createState() => _AddToInventoryPageState();
}

class _AddToInventoryPageState extends State<AddToInventoryPage> {
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
                  _addProductToInventory(productIdController.text);
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

  // Dummy function to add product to inventory (replace with actual logic)
  void _addProductToInventory(String productId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product ID Added to Inventory: $productId")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Inventory"),
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
                      _addProductToInventory(scannedResult!.code!);
                    },
                    child: const Text("Add Product to Inventory"),
                  ),
                ],
              )
                  : const Text("Scan a product QR/Barcode to add"),
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

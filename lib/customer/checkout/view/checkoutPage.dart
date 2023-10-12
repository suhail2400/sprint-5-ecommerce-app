import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/customer/home/view/customerHome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({
    required this.productsToBuy,
    required this.grandTotal,
    required this.orderId,
    required this.fullCartItems,
    super.key,
  });

  List<Map<String, dynamic>> productsToBuy = [];
  List<String> cartIDs = [];
  double grandTotal;
  String orderId;
  List<Map<String, dynamic>> fullCartItems = [];

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late Razorpay _razorpay;

  final cartRef = FirebaseFirestore.instance.collection('cartItems');
  final orderRef = FirebaseFirestore.instance.collection('orderItems');

  Future<void> updateProductQuantitiesAndSubtotal(
    String orderId,
    List<Map<String, dynamic>> cartItems,
  ) async {
    print(cartItems);
    try {
      for (final cartItem in cartItems) {
        print('>>>>>>>>>>>>>>>>>>>$orderId');
        //print('>>>>>>>>${cartItem['quantity']}<<<<<<<<<<<');

        final productId = cartItem['productId'] as String;
        print('$productId >>>>>>>>>>>>>>>>>>>');
        final quantity = cartItem['quantity'];
        final subtotal = cartItem['subtotal'];

        //print(subtotal);

        await orderRef.doc(orderId).update({
          'quantity.$productId': quantity,
          'subtotal.$productId': subtotal,
          'productIds.$productId': productId,
          'status': 'confirmed',
        });

        final snapshot = await orderRef.doc(orderId).get();

        //? Clearing cart
        if (snapshot.exists) {
          final user = snapshot['userId'] as String;
          final cartDoc = await cartRef.where('userId', isEqualTo: user).get();
          for (final doc in cartDoc.docs) {
            await doc.reference.delete();
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to update product quantities and subtotal');
    }
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    updateProductQuantitiesAndSubtotal(widget.orderId, widget.fullCartItems);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerHomePage()),
    );
    Fluttertoast.showToast(
      msg: 'Success: ${response.paymentId}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'Failure: ${response.error}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'External wallet: ${response.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  Future<void> openRazorPay() async {
    final options = {
      'key': 'rzp_test_KmAYyzVRyxHRqI',
      'key_secret': 'z4o425S42Mh3k4I4G2n0rijC',
      'amount': 100 * widget.grandTotal,
      'name': 'E-Commerce',
      'description': 'E commerce payments',
      'retry': {
        'enabled': true,
        'max_count': 1,
      },
      'send_sms_hash': true,
      'prefil': {
        'contact': '230230',
        'email': 'company@gmail.com',
        'external': {
          'wallets': ['Paytm', 'Gpay'],
        },
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('error:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Checkout')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Make Payment',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('COD')),
          ElevatedButton(
            onPressed: openRazorPay,
            child: const Text('RazorPay'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Grand Total:'),
              Text(
                widget.grandTotal.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.productsToBuy.length,
            itemBuilder: (context, index) {
              final listItem = widget.productsToBuy[index];
              final subtotal = double.parse(listItem['price'].toString()) *
                  double.parse(listItem['quantity'].toString());
              return ListTile(
                leading: const CircleAvatar(),
                title: Text(listItem['name'].toString()),
                subtitle: Text(subtotal.toString()),
                trailing: Text(listItem['quantity'].toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}

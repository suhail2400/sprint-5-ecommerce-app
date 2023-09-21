import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/customer/Register/view/customerRegister.dart';
import 'package:ecomm/customer/home/view/customerHome.dart';
import 'package:ecomm/seller/login/view/sellerLoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerLogin extends StatelessWidget {
  const CustomerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference userDetails =
        FirebaseFirestore.instance.collection('userDetails');
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SellerLoginPage(),
                        ),
                      );
                    },
                    child: const Text('Become a seller'),
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // final query =
                    //     userDetails.where("userType", isEqualTo: "customer");
                    // await query.get().then((value) => null);
                    final auth = FirebaseAuth.instance;
                    final user = await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerHomePage(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Invalid username and Password')));
                  }
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerRegisterPage(),
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

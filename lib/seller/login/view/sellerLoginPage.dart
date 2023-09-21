import 'package:ecomm/customer/login/customerLogin.dart';
import 'package:ecomm/seller/home/view/sellerHomePage.dart';
import 'package:ecomm/seller/register/view/sellerRegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerLoginPage extends StatelessWidget {
  const SellerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerLogin(),
                        ),
                      );
                    },
                    child: const Text('Become a customer'),
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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SellerHomePage(),
                      ),
                    );
                  } on FirebaseAuthException {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Invalid username and Password')),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellerRegisterPage(),
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

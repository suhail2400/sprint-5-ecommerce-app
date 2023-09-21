import 'package:ecomm/seller/login/view/sellerLoginPage.dart';
import 'package:ecomm/seller/register/repo/sellerSignUpRepo.dart';
import 'package:flutter/material.dart';

class SellerRegisterPage extends StatelessWidget {
  const SellerRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Full name',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Phone Number',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Address',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await SellerSignUpRepo().createUser(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            addressController.text,
                            passwordController.text,
                            context,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SellerLoginPage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

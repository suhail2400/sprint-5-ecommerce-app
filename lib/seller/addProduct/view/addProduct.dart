import 'package:ecomm/models/product.dart';
import 'package:ecomm/seller/addProduct/addProductRepo/addProductRepo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    List<XFile>? images;
    Future<dynamic> getImage() async {
      final imagePicker = ImagePicker();
      images = await imagePicker.pickMultiImage();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
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
                        hintText: 'Enter  name',
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
                      controller: categoryController,
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
                        hintText: 'Enter Category',
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
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This is mandatory';
                        }
                        return null;
                      },
                      maxLines: 10,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        hintText: 'Enter Description',
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
                      controller: priceController,
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
                        hintText: 'Enter Price',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text('Upload Image')),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: stockController,
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
                        hintText: 'Enter Stock',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ProductRepo().createProduct(
                            nameController.text,
                            categoryController.text,
                            images!,
                            descriptionController.text,
                            double.parse(priceController.text),
                            int.parse(stockController.text),
                            context,
                          );
                          nameController.clear();
                          categoryController.clear();
                          descriptionController.clear();
                          images?.clear();
                          descriptionController.clear();
                          priceController.clear();
                          stockController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Add Product'),
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

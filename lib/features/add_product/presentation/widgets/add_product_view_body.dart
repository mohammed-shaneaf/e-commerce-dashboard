import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_button.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();

  File? _pickedImage;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _isLoading,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Product',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: _nameController,
                  textInputType: TextInputType.name,
                  hintText: 'Enter Product Name',
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _priceController,
                  textInputType: TextInputType.number,
                  hintText: 'Enter Product Price',
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _codeController,
                  textInputType: TextInputType.text,
                  hintText: 'Enter Product Code',
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _descriptionController,
                  textInputType: TextInputType.multiline,
                  hintText: 'Enter Product Description',
                  maxlines: 3,
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        _pickedImage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _pickedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Tap to upload product photo',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 40),

                CustomButton(
                  onPressed: () {
                    setState(() => _isLoading = true);
                    // simulate submission
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() => _isLoading = false);
                      // show success snackbar
                    });
                  },
                  text: 'Submit To Add Product',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

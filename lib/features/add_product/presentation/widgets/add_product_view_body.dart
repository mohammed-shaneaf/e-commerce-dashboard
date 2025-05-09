import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_button.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_text_form_field.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/featured_cheack_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();

  File? _pickedImage;
  bool _isLoading = true;
  bool _isFeatured = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> pickImage() async {
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _priceController,
                  textInputType: TextInputType.number,
                  hintText: 'Enter Product Price',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _codeController,
                  textInputType: TextInputType.text,
                  hintText: 'Enter Product Code',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product code is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextFormField(
                  controller: _descriptionController,
                  textInputType: TextInputType.multiline,
                  hintText: 'Enter Product Description',
                  maxlines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                FeaturedCheckbox(
                  value: _isFeatured,
                  onChanged: (val) {
                    setState(() {
                      _isFeatured = val ?? false;
                    });
                  },
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: pickImage,
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            _pickedImage != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
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
                                        size: 50,
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
                      if (_pickedImage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _pickedImage = null;
                              });
                            },
                            icon: const Icon(Icons.close, size: 32),
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                CustomButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });

                    if (!isValid || _pickedImage == null) {
                      if (_pickedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a product image'),
                          ),
                        );
                      }
                      return;
                    }

                    setState(() => _isLoading = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() => _isLoading = false);
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

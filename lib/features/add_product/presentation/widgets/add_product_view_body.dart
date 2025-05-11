import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_button.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/custom_text_form_field.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/featured_cheack_box.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/cubit/add_product_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  File? _pickedImage;
  bool _isFeatured = false;

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
    return BlocProvider(
      create: (_) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddProductLoading;

          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        hintText: 'Product Name',
                        controller: _nameController,
                        label: 'Product Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      CustomTextFormField(
                        hintText: 'Price',
                        controller: _priceController,
                        label: 'Price',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      CustomTextFormField(
                        hintText: 'Description',
                        controller: _descriptionController,
                        label: 'Description',
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),

                      CustomTextFormField(
                        hintText: 'Product Code',
                        controller: _codeController,
                        label: 'Product Code',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product code';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 24),

                      FeaturedCheckbox(
                        value: _isFeatured,
                        onChanged:
                            (val) => setState(() => _isFeatured = val ?? false),
                      ),
                      const SizedBox(height: 24),

                      GestureDetector(
                        onTap: pickImage,
                        child: _buildImagePicker(),
                      ),
                      const SizedBox(height: 40),

                      CustomButton(
                        onPressed: () {
                          final isValid =
                              _formKey.currentState?.validate() ?? false;
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });

                          if (!isValid || _pickedImage == null) {
                            if (_pickedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select a product image',
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          final product = AddProductEntity(
                            name: _nameController.text.trim(),
                            price:
                                double.tryParse(_priceController.text.trim())
                                    as double,
                            description: _descriptionController.text.trim(),
                            code: _codeController.text.trim(),
                            isFeatured: _isFeatured,
                            image: _pickedImage!.path,
                            imageUrl: '',
                          );

                          context.read<AddProductCubit>().addProduct(
                            product,
                            _pickedImage,
                          );
                        },
                        text:
                            isLoading
                                ? 'Submitting...'
                                : 'Submit To Add Product',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Stack(
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
                  : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
              onPressed: () => setState(() => _pickedImage = null),
              icon: const Icon(Icons.close, size: 32),
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}

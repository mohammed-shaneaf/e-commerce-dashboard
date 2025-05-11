import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/cubit/add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  Future<void> addProduct(AddProductEntity entity, File? imageFile) async {
    if (imageFile == null) {
      emit(AddProductFailure('Please select a product image.'));
      return;
    }

    emit(AddProductLoading());

    // Simulate delay or call use case/repository here
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success/failure
    emit(AddProductSuccess());
  }
}

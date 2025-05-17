import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/errors/faliure.dart';
import 'package:fruits_hub_dashboard/core/repos/images_repo/images_repo.dart';
import 'package:fruits_hub_dashboard/core/services/stoarage_service.dart';
import 'package:fruits_hub_dashboard/core/utils/widgets/back_end_endpoint.dart';

class ImagesRepoImpl implements ImagesRepo {
  final StoarageService stoarageService;

  ImagesRepoImpl(this.stoarageService);
  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      String url = await stoarageService.uploadFile(image, BackEndEndpoint.images);
      return Right(url);
    } on Exception catch (e) {
      return Left(ServerFailure('Failed To Upload Image {"${e.toString()}"}}'));
    }
  }
}

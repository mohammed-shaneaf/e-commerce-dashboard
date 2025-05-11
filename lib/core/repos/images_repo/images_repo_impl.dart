import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/errors/faliure.dart';
import 'package:fruits_hub_dashboard/core/repos/images_repo/images_repo.dart';

class ImagesRepoImpl implements ImagesRepo {
  @override
  Future<Either<Failure, String>> uploadImage(File image) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}

import 'dart:convert';

import 'package:dogs_breed/domain/problems.dart';
import 'package:dogs_breed/domain/register_dog.dart';
import 'package:fpdart/fpdart.dart';
import '../domain/format_breed.dart';

abstract class VerificationRepo {
  Either<Problems, DogRegister> getDogRegister(FormatBreed breed);
}

class RepoTestVerification extends VerificationRepo {
  final String retriever =
      """ {"message":["chesapeake","curly","flatcoated","golden"], "status": "success"}""";

  final String pitbull = """ {"message":[], "status": "success"} """;

  final String breedNotExist =
      """ {"status": "error","message":"Breed not found (master breed does not exist)"} """;

  Either<Problems, DogRegister> getBreedRegisterFromJson(
      String documentJson, String usedBreed) {
    Map<String, dynamic> document = jsonDecode(documentJson);

    Either<Problems, String> subBreed = getValueSubBreed(document);
    Either<Problems, String> breed = getValueSubBreed(document);

    String porposeSubBreeds;
    if ([subBreed].any((element) => element.isLeft())) {
      return Left(WithoutSubBreed());
    } else {
      porposeSubBreeds = document["message"].toString();
    }
    if ([breed].any((element) => element.isLeft())) {
      return Left(NotRegisteredDog());
    }
    return Right(DogRegister.constructor(
        porposeBreed: usedBreed, porposeSubBreed: porposeSubBreeds));
  }

  Either<Problems, String> getValueSubBreed(Map<String, dynamic> documentJson) {
    if (documentJson["message"].isEmpty) {
      return Left(WithoutSubBreed());
    }
    return Right(documentJson["message"].toString());
  }

  Either<Problems, String> getValuebreed(Map<String, dynamic> documentJson) {
    if (documentJson["status"] == "error") {
      return Left(NotRegisteredDog());
    }
    return Right(documentJson["status"]);
  }

  @override
  Either<Problems, DogRegister> getDogRegister(FormatBreed breed) {
    if (breed.valor == 'retriever') {
      return getBreedRegisterFromJson(retriever, breed.valor);
    }
    if (breed.valor == 'pitbull') {
      return getBreedRegisterFromJson(pitbull, breed.valor);
    }
    if (breed.valor == 'breedNotExist') {
      return getBreedRegisterFromJson(breedNotExist, breed.valor);
    }
    return Left(NotRegisteredDog());
  }
}

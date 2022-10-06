const String errorMessageRegisterDog = 'Dog register incorrect';
const String emptyFieldMessage = '';

class DogRegister {
  late final String breed;
  late final String subBreed;

  DogRegister._(this.breed, this.subBreed);

  factory DogRegister.constructor(
      {required String porposeBreed, required String porposeSubBreed}) {
    if (porposeBreed.trim().isEmpty) {
      throw errorMessageRegisterDog;
    }
    DogRegister._(porposeBreed, porposeSubBreed);
    final result = DogRegister._(porposeBreed, porposeSubBreed);
    return result;
  }
}

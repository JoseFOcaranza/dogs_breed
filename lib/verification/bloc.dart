import 'package:bloc/bloc.dart';
import 'package:dogs_breed/domain/register_dog.dart';
import 'package:dogs_breed/verification/verification_repo.dart';

import '../domain/format_breed.dart';
import '../domain/problems.dart';

class VerificationEvent {}

class Created extends VerificationEvent {}

class ReciviedName extends VerificationEvent {
  final FormatBreed breed;
  ReciviedName(this.breed);
}

class ConfirmedName extends VerificationEvent {}

class VerificationState {}

class Creating extends VerificationState {}

class RequestingName extends VerificationState {}

class WaitingConfirmationName extends VerificationState {}

class ShowingRequestUpdate extends VerificationState {}

class ShowingNotConfirmedName extends VerificationState {}

class ShowingConfirmedName extends VerificationState {
  final DogRegister dogRegister;
  ShowingConfirmedName(this.dogRegister);
}

class ShowingBreedWithoutSubBreed extends VerificationState {
  final FormatBreed breed;
  ShowingBreedWithoutSubBreed(this.breed);
}

class ShowName extends VerificationState {}

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationRepo _verificationRepo;
  VerificationBloc(this._verificationRepo) : super(Creating()) {
    on<Created>((event, emit) {
      emit(RequestingName());
    });
    on<ReciviedName>(
      (event, emit) {
        emit(WaitingConfirmationName());
        final resultado = _verificationRepo.getDogRegister(event.breed);
        resultado.match((l) {
          if (l is IncorrectVersionJson) {
            emit(ShowingRequestUpdate());
          }
          if (l is NotRegisteredDog) {
            emit(ShowingNotConfirmedName());
          }
          if (l is WithoutSubBreed) {
            emit(ShowingBreedWithoutSubBreed(event.breed));
          }
        }, (r) {
          emit(ShowingConfirmedName(r));
        });
      },
    );
  }
}

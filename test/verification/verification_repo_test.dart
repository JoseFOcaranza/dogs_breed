import 'package:dogs_breed/domain/format_breed.dart';
import 'package:dogs_breed/verification/verification_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Con retriever me regresa raza y subraza', () {
    RepoTestVerification repo = RepoTestVerification();

    var result = repo.getDogRegister(FormatBreed.constructor('retriever'));

    result.match((l) {}, (r) {
      expect(r.breed, equals("retriever"));
      expect(r.subBreed, equals('[chesapeake, curly, flatcoated, golden]'));
    });
  });
}

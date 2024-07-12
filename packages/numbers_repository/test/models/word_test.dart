import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';
import 'package:numbers_repository/src/models/word.dart';

void main() {
  group('Word', () {
    const word = Word(
      id: '1',
      value: 'example',
      isMain: true,
    );

    test('should create a Word instance', () {
      expect(word, isA<Word>());
    });

    test('should have correct properties', () {
      expect(word.id, '1');
      expect(word.value, 'example');
      expect(word.isMain, true);
    });

    test('should return correct string representation', () {
      expect(word.toString(), 'example');
    });

    test('should create a copy with updated properties', () {
      final updatedWord = word.copyWith(
        id: () =>  '2',
        value: () =>  'updated example',
        isMain: () =>  false,
      );

      expect(
        updatedWord,
        const Word(
          id: '2',
          value: 'updated example',
        ),
      );
    });

    test('should create a copy with existing properties', () {
      final copiedWord = word.copyWith();

      expect(copiedWord, word);
    });

    test('should convert to WordEntity', () {
      final entity = word.toEntity();

      expect(
        entity,
        const WordEntity(
          id: '1',
          value: 'example',
          isMain: true,
        ),
      );
    });

    test('should create a Word instance from WordEntity', () {
      const entity = WordEntity(
        id: '1',
        value: 'example',
        isMain: true,
      );

      final wordFromEntity = Word.fromEntity(entity);

      expect(wordFromEntity, word);
    });
  });
}

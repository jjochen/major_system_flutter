import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('WordEntity', () {
    const id = 'test_id';
    const value = 'test_value';
    const isMain = true;
    const wordEntity = WordEntity(
      id: id,
      value: value,
      isMain: isMain,
    );
    const snapshotData = {
      'value': value,
      'is_main': isMain,
    };

    test('should create a WordEntity instance', () {
      expect(wordEntity.id, id);
      expect(wordEntity.value, value);
      expect(wordEntity.isMain, isMain);
    });

    test('should create a WordEntity instance from snapshot', () {
      final fromSnapshot = WordEntity.fromSnapshot(
        id: id,
        data: snapshotData,
      );

      expect(fromSnapshot, wordEntity);
    });

    test('should return document data', () {
      final documentData = wordEntity.getDocumentData();

      expect(documentData, snapshotData);
    });

    test('should return update data', () {
      final updateData = WordEntity.getUpdateData(
        value: () => 'new_value',
        isMain: () => false,
      );

      expect(updateData, {
        'value': 'new_value',
        'is_main': false,
      });
    });

    test('should return partial update data', () {
      expect(
        WordEntity.getUpdateData(
          value: () => value,
        ),
        {'value': value},
      );

      expect(
        WordEntity.getUpdateData(
          isMain: () => isMain,
        ),
        {'is_main': isMain},
      );
    });
  });
}

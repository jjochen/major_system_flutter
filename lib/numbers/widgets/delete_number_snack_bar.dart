import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class DeleteNumberSnackBar extends SnackBar {
  DeleteNumberSnackBar({
    required Number number,
    required VoidCallback onUndo,
    super.key,
  }) : super(
          content: Text(
            'Deleted ${number.value}', // TODO(jjochen): use .displayText
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}

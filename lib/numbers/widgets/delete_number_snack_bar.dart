import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class DeleteNumberSnackBar extends SnackBar {
  DeleteNumberSnackBar({
    Key? key,
    required Number number,
    required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${number.value}', // TODO: use .displayText
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

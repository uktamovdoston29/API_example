import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

class SnackbarService {
  SnackbarService._();
  static final SnackbarService instance = SnackbarService._();

  void showSuccess(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) =>
      _show(context, message,
          type: SnackbarType.success,
          actionLabel: actionLabel,
          onAction: onAction,
          duration: duration);

  void showError(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _show(context, message,
          type: SnackbarType.error,
          actionLabel: actionLabel,
          onAction: onAction,
          duration: duration);

  void showWarning(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) =>
      _show(context, message,
          type: SnackbarType.warning,
          actionLabel: actionLabel,
          onAction: onAction,
          duration: duration);

  void showInfo(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) =>
      _show(context, message,
          type: SnackbarType.info,
          actionLabel: actionLabel,
          onAction: onAction,
          duration: duration);

  void dismiss(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // ─── Internal ──────────────────────────────────────────────────────────────

  void _show(
    BuildContext context,
    String message, {
    required SnackbarType type,
    String? actionLabel,
    VoidCallback? onAction,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(_iconFor(type), color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: _colorFor(type),
          duration: duration,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(12),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }

  Color _colorFor(SnackbarType type) => switch (type) {
        SnackbarType.success => const Color(0xFF2E7D32),
        SnackbarType.error   => const Color(0xFFC62828),
        SnackbarType.warning => const Color(0xFFE65100),
        SnackbarType.info    => const Color(0xFF0277BD),
      };

  IconData _iconFor(SnackbarType type) => switch (type) {
        SnackbarType.success => Icons.check_circle_outline,
        SnackbarType.error   => Icons.error_outline,
        SnackbarType.warning => Icons.warning_amber_outlined,
        SnackbarType.info    => Icons.info_outline,
      };
}
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double elevation;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.centerTitle = false,
    this.actions,
    this.bottom,
    this.onBackPressed,
    this.backgroundColor,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      onWillPop: onBackPressed != null
          ? () async {
              onBackPressed?.call();
              return false;
            }
          : null,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.lg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
      margin: margin,
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String positiveButtonLabel;
  final String? negativeButtonLabel;
  final VoidCallback onPositivePressed;
  final VoidCallback? onNegativePressed;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.positiveButtonLabel,
    this.negativeButtonLabel,
    required this.onPositivePressed,
    this.onNegativePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (negativeButtonLabel != null)
          TextButton(
            onPressed: onNegativePressed ?? () => Navigator.pop(context),
            child: Text(negativeButtonLabel!),
          ),
        TextButton(
          onPressed: onPositivePressed,
          child: Text(positiveButtonLabel),
        ),
      ],
    );
  }
}

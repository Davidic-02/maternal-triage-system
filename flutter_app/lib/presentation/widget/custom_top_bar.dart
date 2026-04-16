import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/extension/build_context.dart';

class CustomTopBar extends HookWidget {
  final String title;
  final Widget? leading;
  final String? ending;
  final VoidCallback? onTap;

  const CustomTopBar({
    super.key,
    required this.title,
    this.leading,
    this.ending,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ??
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black38,
                      size: 22,
                    ),
                  ),
                ),
            Text(
              title,
              // style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black38,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

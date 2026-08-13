// lib/features/Auth/ui/widget/login_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool isLoading;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onLoginPressed;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.rememberMe,
    required this.isLoading,
    required this.onRememberMeChanged,
    required this.onLoginPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  final double _cardPadding = 24.w;
  final double _gapSmall = 8.h;
  final double _gapMedium = 16.h;
  final double _gapLarge = 32.h;
  final double _buttonHeight = 24.w;
  final double _buttonWidth = 50.w;
  final double _borderRadius = 16.r;
  // final double _iconSize = 64.w;
  final double _loginFontSize = 18.sp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(_cardPadding),
        child: Column(
          children: [
            Text(
              S.of(context).welcome_back,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: _gapSmall),
            Text(
              S.of(context).sign_in_continue,
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: _gapLarge),
            Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: widget.usernameController,
                    enabled: !widget.isLoading,
                    decoration: InputDecoration(
                      labelText: S.of(context).username,
                      labelStyle: TextStyle(fontSize: 14.sp),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: theme.colorScheme.primary,
                        size: 22.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? S.of(context).Username
                        : null,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: _gapMedium),
                  TextFormField(
                    controller: widget.passwordController,
                    obscureText: _obscureText,
                    enabled: !widget.isLoading,
                    decoration: InputDecoration(
                      labelText: S.of(context).password,
                      labelStyle: TextStyle(fontSize: 14.sp),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: theme.colorScheme.primary,
                        size: 22.w,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: theme.colorScheme.primary,
                          size: 22.w,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        tooltip: _obscureText
                            ? 'إظهار كلمة المرور'
                            : 'إخفاء كلمة المرور',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: 36.w,
                          minHeight: 36.h,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).Password;
                      }
                      if (value.length < 6) {
                        return S.of(context).password_min_length;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: _gapSmall),
            Row(
              children: [
                Checkbox(
                  value: widget.rememberMe,
                  activeColor: theme.colorScheme.primary,
                  onChanged: (value) =>
                      widget.onRememberMeChanged(value ?? false),
                  splashRadius: 20.r,
                ),
                Text(
                  S.of(context).remember_me,
                  style: TextStyle(fontSize: 14.sp),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onLoginPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 13.h,
                  horizontal: _buttonWidth,
                ),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                elevation: 3,
                minimumSize: Size(double.infinity, 52.h),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: _buttonHeight,
                      height: _buttonHeight,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onPrimary,
                        strokeWidth: 2.5.w,
                      ),
                    )
                  : Text(
                      S.of(context).login,
                      style: TextStyle(
                        fontSize: _loginFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

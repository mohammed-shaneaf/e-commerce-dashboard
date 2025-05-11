import 'dart:developer';

class CustomAuthException implements Exception {
  final String message;

  CustomAuthException(this.message);

  @override
  String toString() => message;

  /// إنشاء استثناء مخصص بناءً على رمز الخطأ الوارد من Firebase
  static CustomAuthException fromFirebaseAuthException(String errorCode) {
    log('FirebaseAuthException: $errorCode'); // ✅ تسجيل الخطأ للوصول إليه أثناء التصحيح

    switch (errorCode) {
      // أخطاء البريد وكلمة المرور
      case 'email-already-in-use':
        return CustomAuthException("البريد الإلكتروني مستخدم بالفعل.");
      case 'invalid-email':
        return CustomAuthException("تنسيق البريد الإلكتروني غير صالح.");
      case 'weak-password':
        return CustomAuthException("كلمة المرور ضعيفة جدًا.");
      case 'operation-not-allowed':
        return CustomAuthException("تسجيل الدخول بالبريد الإلكتروني/كلمة المرور معطل.");
      case 'user-disabled':
        return CustomAuthException("تم تعطيل هذا الحساب.");
      case 'user-not-found':
        return CustomAuthException("لم يتم العثور على حساب بهذا البريد الإلكتروني.");
      case 'wrong-password':
        return CustomAuthException("كلمة المرور غير صحيحة، يرجى المحاولة مرة أخرى.");
      case 'requires-recent-login':
        return CustomAuthException("يجب إعادة تسجيل الدخول لمتابعة هذه العملية.");

      // أخطاء متعلقة بـ Google Sign-In
      case 'account-exists-with-different-credential':
        return CustomAuthException("هذا الحساب مسجل بطريقة مختلفة. يرجى تسجيل الدخول بتلك الطريقة.");
      case 'invalid-credential':
        return CustomAuthException("بيانات الاعتماد غير صحيحة أو منتهية الصلاحية.");
      case 'user-mismatch':
        return CustomAuthException("بيانات المستخدم لا تتطابق مع المصادقة المطلوبة.");
      case 'popup-closed-by-user':
        return CustomAuthException("تم إغلاق نافذة تسجيل الدخول قبل إكمال العملية.");

      // أخطاء الشبكة والاتصال
      case 'network-request-failed':
        return CustomAuthException("تأكد من اتصالك بالإنترنت وحاول مرة أخرى.");

      // أي خطأ غير معروف
      default:
        return CustomAuthException("حدث خطأ غير معروف، يرجى المحاولة لاحقًا.");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:school/generated/l10n.dart';

String formatDate(DateTime? date) {
  if (date == null) return 'غير محدد';
  try {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  } catch (_) {
    return 'غير محدد';
  }
}

String getTranslatedStatus(BuildContext context, String status) {
  switch (status) {
    case 'Pending':
      return S.of(context).statusPending;
    case 'Approved':
      return S.of(context).statusApproved;
    case 'Rejected':
      return S.of(context).statusRejected;
    case 'Cancelled':
      return S.of(context).statusCancelled;
    case 'Fulfilled':
      return S.of(context).statusFulfilled;
    default:
      return status;
  }
}

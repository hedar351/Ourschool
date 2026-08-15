import 'package:flutter/material.dart';

Color getStatusColor(String? status) {
  switch (status) {
    case 'Pending':
      return Colors.amber.shade800;
    case 'Approved':
      return Colors.green.shade600;
    case 'Rejected':
      return Colors.red.shade600;
    case 'Cancelled':
      return Colors.grey.shade600;
    case 'Fulfilled':
      return Colors.blue.shade600;
    default:
      return Colors.grey.shade600;
  }
}

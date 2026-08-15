String getStatusLabel(String status) {
  switch (status) {
    case 'Pending':
      return 'قيد الانتظار';
    case 'Approved':
      return 'موافق عليه';
    case 'Rejected':
      return 'مرفوض';
    case 'Cancelled':
      return 'ملغي';
    case 'Fulfilled':
      return 'مكتمل';
    // case 'All':
    //   return 'الكل';
    default:
      return status;
  }
}

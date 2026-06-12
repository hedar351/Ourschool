import 'package:flutter/material.dart';

// ---------- بيانات مالية افتراضية ----------
const Map<String, dynamic> defaultFinancialData = {
  "student_name": "علي أحمد",
  "total_due": 1500.0,
  "total_paid": 750.0,
  "currency": "ل.س",
  "invoices": [
    {
      "invoice_id": "INV-001",
      "title": "القسط الأول - الفصل الأول",
      "due_date": "2025-02-15",
      "total_amount": 500.0,
      "paid_amount": 500.0,
      "status": "paid",
    },
    {
      "invoice_id": "INV-002",
      "title": "القسط الثاني - الفصل الأول",
      "due_date": "2025-03-30",
      "total_amount": 500.0,
      "paid_amount": 250.0,
      "status": "partial",
    },
    {
      "invoice_id": "INV-003",
      "title": "القسط الثالث - الفصل الثاني",
      "due_date": "2025-05-10",
      "total_amount": 500.0,
      "paid_amount": 0.0,
      "status": "unpaid",
    },
    {
      "invoice_id": "INV-004",
      "title": "رسوم الأنشطة المدرسية",
      "due_date": "2025-04-20",
      "total_amount": 250.0,
      "paid_amount": 0.0,
      "status": "unpaid",
    },
  ],
};

// ========== شاشة المدفوعات (بدون أنيميشن) ==========
class StudentPaymentsScreen extends StatefulWidget {
  final Map<String, dynamic>? financialData;
  final String studentName;
  const StudentPaymentsScreen({
    super.key,
    this.financialData,
    this.studentName = '',
  });

  @override
  State<StudentPaymentsScreen> createState() => _StudentPaymentsScreenState();
}

class _StudentPaymentsScreenState extends State<StudentPaymentsScreen> {
  late Map<String, dynamic> data;
  late List<Map<String, dynamic>> invoices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String currency = data['currency'] as String;
    final double totalDue = (data['total_due'] as num).toDouble();
    final double totalPaid = (data['total_paid'] as num).toDouble();
    final double remaining = totalDue - totalPaid;
    final double progressPercent = totalDue > 0 ? totalPaid / totalDue : 0.0;
    final String name = widget.studentName.isNotEmpty
        ? widget.studentName
        : data['student_name'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('مستحقات $name'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primaryContainer,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الملخص
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _SummaryItem(
                          icon: Icons.receipt_long,
                          label: 'المستحق',
                          value: '$totalDue $currency',
                          color: Colors.blue,
                        ),
                        _SummaryItem(
                          icon: Icons.check_circle,
                          label: 'المدفوع',
                          value: '$totalPaid $currency',
                          color: Colors.green,
                        ),
                        _SummaryItem(
                          icon: Icons.pending,
                          label: 'المتبقي',
                          value: '$remaining $currency',
                          color: remaining > 0 ? Colors.red : Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: Colors.grey.shade200,
                      color: progressPercent >= 1.0
                          ? Colors.green
                          : theme.colorScheme.primary,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${(progressPercent * 100).toStringAsFixed(0)}% مكتمل',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'الفواتير',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(invoices.length, (index) {
              final inv = invoices[index];
              final status = inv['status'] as String;
              final Color statusColor = status == 'paid'
                  ? Colors.green
                  : status == 'partial'
                  ? Colors.orange
                  : Colors.red;
              final String statusText = status == 'paid'
                  ? 'مدفوع'
                  : status == 'partial'
                  ? 'جزئي'
                  : 'غير مدفوع';
              final double invTotal = (inv['total_amount'] as num).toDouble();
              final double invPaid = (inv['paid_amount'] as num).toDouble();
              final double invRemaining = invTotal - invPaid;
              final double progress = invTotal > 0 ? invPaid / invTotal : 0.0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              inv['title'] as String,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاريخ الاستحقاق: ${inv['due_date']}',
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            '${invPaid.toStringAsFixed(0)} / ${invTotal.toStringAsFixed(0)} $currency',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        color: statusColor,
                        minHeight: 6,
                      ),
                      if (status != 'paid') ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () => _showPaymentDialog(index),
                            icon: const Icon(Icons.payment),
                            label: Text(
                              'دفع ${invRemaining > 0 ? "$invRemaining $currency" : ""}',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final source = widget.financialData ?? defaultFinancialData;
    data = Map<String, dynamic>.from(source);
    invoices = List<Map<String, dynamic>>.from(
      (data['invoices'] as List).map((e) => Map<String, dynamic>.from(e)),
    );
    _updateTotals();
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _showPaymentDialog(int index) async {
    final invoice = invoices[index];
    final remaining =
        (invoice['total_amount'] as num).toDouble() -
        (invoice['paid_amount'] as num).toDouble();
    final amountController = TextEditingController(text: remaining.toString());
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('دفع: ${invoice['title']}'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoRow(
                'المبلغ الكلي',
                '${invoice['total_amount']} ${data['currency']}',
              ),
              _infoRow(
                'المدفوع',
                '${invoice['paid_amount']} ${data['currency']}',
              ),
              const Divider(),
              _infoRow('المتبقي', '$remaining ${data['currency']}'),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'المبلغ المراد دفعه',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  final a = double.tryParse(val ?? '');
                  if (a == null || a <= 0) return 'أدخل مبلغاً صحيحاً';
                  if (a > remaining)
                    return 'المبلغ أكبر من المتبقي ($remaining)';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, {
                  'amount': double.parse(amountController.text),
                });
              }
            },
            child: const Text('تأكيد الدفع'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      final paid = result['amount'] as double;
      setState(() {
        invoice['paid_amount'] =
            (invoice['paid_amount'] as num).toDouble() + paid;
        if (invoice['paid_amount'] >= invoice['total_amount']) {
          invoice['status'] = 'paid';
        } else {
          invoice['status'] = 'partial';
        }
      });
      _updateTotals();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم دفع $paid ${data['currency']} بنجاح'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _updateTotals() {
    double due = 0, paid = 0;
    for (var inv in invoices) {
      due += (inv['total_amount'] as num).toDouble();
      paid += (inv['paid_amount'] as num).toDouble();
    }
    setState(() {
      data['total_due'] = due;
      data['total_paid'] = paid;
    });
  }
}

// ويدجت عنصر ملخص
class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const TeacherClassesScreen(),
    );
  }
}

// ========== صفحة تفاصيل الطالب (مع أزرار التعديل/الحذف) ==========
class StudentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> studentData;
  const StudentDetailScreen({super.key, required this.studentData});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

// ========== الشاشة الرئيسية (قائمة الطلاب المبسطة) ==========
class TeacherClassesScreen extends StatefulWidget {
  const TeacherClassesScreen({super.key});

  @override
  State<TeacherClassesScreen> createState() => _TeacherClassesScreenState();
}

class _AnimatedCountWidget extends StatefulWidget {
  final double targetValue;
  final TextStyle? style;
  final String suffix;
  final int duration;
  const _AnimatedCountWidget({
    required this.targetValue,
    this.style,
    this.suffix = '',
    this.duration = 1500,
  });

  @override
  State<_AnimatedCountWidget> createState() => _AnimatedCountWidgetState();
}

class _AnimatedCountWidgetState extends State<_AnimatedCountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return Text(
          '${_anim.value.toStringAsFixed(0)}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _anim = Tween<double>(
      begin: 0,
      end: widget.targetValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }
}

// ---------- الويدجتات المساعدة ----------
class _GradeRow extends StatelessWidget {
  final String label;
  final int value;
  final double percent;
  final Color color;
  const _GradeRow({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.textTheme.bodyLarge),
              _AnimatedCountWidget(
                targetValue: value.toDouble(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                suffix: '/100',
                duration: 1000,
              ),
            ],
          ),
          const SizedBox(height: 6),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: percent),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (context, val, child) {
              return LinearProgressIndicator(
                value: val,
                backgroundColor: Colors.grey.shade200,
                color: color,
                minHeight: 8,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------- أيقونة المكافأة النابضة (تصحيح: كـ Widget منفصل) ----------
class _RewardPulseAnim extends StatefulWidget {
  @override
  State<_RewardPulseAnim> createState() => _RewardPulseAnimState();
}

class _RewardPulseAnimState extends State<_RewardPulseAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: const Icon(Icons.emoji_events, color: Colors.amber, size: 26),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.95, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }
}

class _StudentDetailScreenState extends State<StudentDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  bool _isExpanded = false;
  late Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String name = student['student_name'];
    final Map<String, dynamic> grades = student['grades'];
    final List extraMarks = student['extra_marks'] ?? [];
    final List rewards = student['rewards'] ?? [];
    final Map<String, dynamic>? studyPlan = student['study_plan'];

    final double midtermPercent = (grades['midterm'] as int).toDouble() / 100;
    final double finalPercent = (grades['final'] as int).toDouble() / 100;
    final double averagePercent =
        ((grades['midterm'] as int) + (grades['final'] as int)) / 2 / 100;
    final int average =
        ((grades['midterm'] as int) + (grades['final'] as int)) ~/ 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
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
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // بطاقة المعدل العام
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school,
                                color: theme.colorScheme.primary,
                                size: 32,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'المعدل العام',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _AnimatedCountWidget(
                            targetValue: average.toDouble(),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: average >= 90
                                  ? Colors.green
                                  : average >= 75
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                            suffix: '%',
                            duration: 1500,
                          ),
                          const SizedBox(height: 12),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: averagePercent),
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor: Colors.grey.shade200,
                                color: average >= 90
                                    ? Colors.green
                                    : average >= 75
                                    ? Colors.orange
                                    : Colors.red,
                                minHeight: 10,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // الدرجات الأساسية
                  Text(
                    '📊 الدرجات',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _GradeRow(
                    label: 'امتحان نصفي',
                    value: grades['midterm'],
                    percent: midtermPercent,
                    color: Colors.blue,
                  ),
                  _GradeRow(
                    label: 'امتحان نهائي',
                    value: grades['final'],
                    percent: finalPercent,
                    color: Colors.green,
                  ),

                  // علامات إضافية
                  if (extraMarks.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'علامات أخرى',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    ...List.generate(extraMarks.length, (index) {
                      final m = extraMarks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                            Icons.assignment,
                            size: 20,
                            color: theme.colorScheme.secondary,
                          ),
                          title: Text(
                            '${m['type']} - ${m['mark']}/100',
                            style: theme.textTheme.bodyMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: theme.colorScheme.primary,
                                ),
                                onPressed: () => _editMarkDialog(index),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteMark(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _showAddMarkDialog,
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      label: const Text('إضافة علامة'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // المكافآت
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🏆 المكافآت',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: _showAddRewardDialog,
                      ),
                    ],
                  ),
                  if (rewards.isNotEmpty)
                    ...List.generate(rewards.length, (index) {
                      final reward = rewards[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            // تم التصحيح هنا: استخدام _RewardPulseAnim مباشرة
                            _RewardPulseAnim(),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reward['reason'],
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '📅 ${reward['date']}  •  +${reward['points']} نقطة',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () => _editRewardDialog(index),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.red,
                              ),
                              onPressed: () => _deleteReward(index),
                            ),
                          ],
                        ),
                      );
                    })
                  else
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'لا توجد مكافآت بعد',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  const SizedBox(height: 24),

                  // الخطة الدراسية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📅 الخطة الدراسية',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      if (studyPlan == null)
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: _showAddStudyPlanDialog,
                        ),
                    ],
                  ),
                  if (studyPlan != null) ...[
                    InkWell(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                studyPlan['description'],
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${studyPlan['start_date']} - ${studyPlan['end_date']}',
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 12),
                            _StudyPlanProgress(tasks: studyPlan['tasks']),
                            const SizedBox(height: 12),
                            ...List.generate(
                              (studyPlan['tasks'] as List).length,
                              (index) {
                                final task =
                                    (studyPlan['tasks'] as List)[index];
                                return _TaskTile(
                                  task: task,
                                  onEdit: () => _editTaskDialog(index),
                                  onDelete: () => _deleteTask(index),
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: _showAddTaskDialog,
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('إضافة مهمة'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 400),
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'لا توجد خطة دراسية',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    student = Map<String, dynamic>.from(widget.studentData);
    student['extra_marks'] ??= [];
    student['rewards'] ??= [];

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _scaleAnim = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animController.forward(),
    );
  }

  void _deleteMark(int index) {
    setState(() {
      (student['extra_marks'] as List).removeAt(index);
    });
  }

  void _deleteReward(int index) {
    setState(() {
      (student['rewards'] as List).removeAt(index);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      (student['study_plan']['tasks'] as List).removeAt(index);
    });
  }

  // ---------- دوال التعديل والحذف ----------
  void _editMarkDialog(int index) {
    final mark = (student['extra_marks'] as List)[index];
    String selectedType = mark['type'];
    final markController = TextEditingController(text: mark['mark'].toString());
    final types = ['نصفي', 'اختبار أول', 'اختبار ثاني', 'نهائي'];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('تعديل العلامة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: 'نوع الامتحان'),
                items: types
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setDialogState(() => selectedType = val!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: markController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () {
                final newMark = int.tryParse(markController.text);
                if (selectedType.isNotEmpty &&
                    newMark != null &&
                    newMark >= 0 &&
                    newMark <= 100) {
                  setState(() {
                    (student['extra_marks'] as List)[index] = {
                      'type': selectedType,
                      'mark': newMark,
                      'date': mark['date'],
                    };
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }

  void _editRewardDialog(int index) {
    final reward = (student['rewards'] as List)[index];
    final reasonController = TextEditingController(text: reward['reason']);
    final pointsController = TextEditingController(
      text: reward['points'].toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل المكافأة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب المكافأة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'النقاط'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              final points = int.tryParse(pointsController.text);
              if (reason.isNotEmpty && points != null) {
                setState(() {
                  (student['rewards'] as List)[index] = {
                    'reward_id': reward['reward_id'],
                    'reason': reason,
                    'date': reward['date'],
                    'points': points,
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _editTaskDialog(int index) {
    final task = (student['study_plan']['tasks'] as List)[index];
    final titleController = TextEditingController(text: task['title']);
    final deadlineController = TextEditingController(text: task['deadline']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل المهمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(
                labelText: 'تاريخ التسليم (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final title = titleController.text.trim();
              final deadline = deadlineController.text.trim();
              if (title.isNotEmpty && deadline.isNotEmpty) {
                setState(() {
                  (student['study_plan']['tasks'] as List)[index] = {
                    'task_id': task['task_id'],
                    'title': title,
                    'deadline': deadline,
                    'completed': task['completed'],
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  // ---------- دوال الإضافة ----------
  void _showAddMarkDialog() {
    String? selectedType;
    final markController = TextEditingController();
    final types = ['نصفي', 'اختبار أول', 'اختبار ثاني', 'نهائي'];
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('إضافة علامة جديدة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: 'نوع الامتحان'),
                items: types
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setDialogState(() => selectedType = val),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: markController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () {
                final mark = int.tryParse(markController.text);
                if (selectedType != null &&
                    mark != null &&
                    mark >= 0 &&
                    mark <= 100) {
                  setState(() {
                    (student['extra_marks'] as List).add({
                      'type': selectedType,
                      'mark': mark,
                      'date': DateTime.now().toString().substring(0, 10),
                    });
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddRewardDialog() {
    final reasonController = TextEditingController();
    final pointsController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مكافأة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب المكافأة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'النقاط'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              final points = int.tryParse(pointsController.text);
              if (reason.isNotEmpty && points != null) {
                setState(() {
                  (student['rewards'] as List).add({
                    'reward_id': DateTime.now().millisecondsSinceEpoch,
                    'reason': reason,
                    'date': DateTime.now().toString().substring(0, 10),
                    'points': points,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddStudyPlanDialog() {
    final descController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة خطة دراسية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'وصف الخطة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: startController,
              decoration: const InputDecoration(
                labelText: 'تاريخ البداية (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: endController,
              decoration: const InputDecoration(
                labelText: 'تاريخ النهاية (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final desc = descController.text.trim();
              final start = startController.text.trim();
              final end = endController.text.trim();
              if (desc.isNotEmpty && start.isNotEmpty && end.isNotEmpty) {
                setState(() {
                  student['study_plan'] = {
                    'plan_id': DateTime.now().millisecondsSinceEpoch,
                    'start_date': start,
                    'end_date': end,
                    'description': desc,
                    'tasks': [],
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final deadlineController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مهمة للخطة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(
                labelText: 'تاريخ التسليم (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final title = titleController.text.trim();
              final deadline = deadlineController.text.trim();
              if (title.isNotEmpty && deadline.isNotEmpty) {
                setState(() {
                  (student['study_plan']['tasks'] as List).add({
                    'task_id': DateTime.now().millisecondsSinceEpoch,
                    'title': title,
                    'deadline': deadline,
                    'completed': false,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}

class _StudyPlanProgress extends StatelessWidget {
  final List tasks;
  const _StudyPlanProgress({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((t) => t['completed'] == true).length;
    final total = tasks.length;
    final percent = total > 0 ? completed / total : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('تقدم المهام', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '$completed / $total',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: percent),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade200,
              color: percent == 1.0 ? Colors.green : Colors.orange,
              minHeight: 8,
            );
          },
        ),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const _TaskTile({required this.task, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final bool completed = task['completed'] ?? false;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              task['title'],
              style: theme.textTheme.bodyMedium?.copyWith(
                decoration: completed ? TextDecoration.lineThrough : null,
                color: completed ? theme.hintColor : null,
              ),
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.delete, size: 16, color: Colors.red),
              onPressed: onDelete,
            ),
          const SizedBox(width: 4),
          Text(
            task['deadline'],
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}

class _TeacherClassesScreenState extends State<TeacherClassesScreen> {
  Map<String, dynamic> responseData = {
    "success": true,
    "message": "تم جلب فصول وطلاب المعلم...",
    "data": {
      "teacher_id": 101,
      "teacher_name": "أحمد محمد",
      "classes": [
        {
          "class_id": 1,
          "class_name": "الصف الأول - أ",
          "students": [
            {
              "student_id": 1001,
              "student_name": "علي أحمد",
              "grades": {"midterm": 85, "final": 90},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 88, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 92, "date": "2025-03-10"},
                {"type": "مشاركة", "mark": 80, "date": "2025-01-20"},
                {"type": "مشروع", "mark": 95, "date": "2025-03-25"},
              ],
              "rewards": [
                {
                  "reward_id": 1,
                  "reason": "تفوق في الرياضيات",
                  "date": "2025-03-15",
                  "points": 10,
                },
                {
                  "reward_id": 2,
                  "reason": "مساعدة الزملاء في الفصل",
                  "date": "2025-02-20",
                  "points": 5,
                },
              ],
              "study_plan": {
                "plan_id": 101,
                "start_date": "2025-04-01",
                "end_date": "2025-04-30",
                "description": "مراجعة قواعد الرياضيات وحل تمارين يومية",
                "tasks": [
                  {
                    "task_id": 1,
                    "title": "حل صفحة 15 من التمارين",
                    "deadline": "2025-04-05",
                    "completed": false,
                  },
                  {
                    "task_id": 2,
                    "title": "مراجعة الكسور",
                    "deadline": "2025-04-10",
                    "completed": true,
                  },
                  {
                    "task_id": 3,
                    "title": "حل اختبار تجريبي",
                    "deadline": "2025-04-20",
                    "completed": false,
                  },
                ],
              },
            },
            {
              "student_id": 1002,
              "student_name": "فاطمة الزهراء",
              "grades": {"midterm": 78, "final": 82},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 75, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 80, "date": "2025-03-10"},
                {"type": "مشاركة", "mark": 90, "date": "2025-01-20"},
              ],
              "rewards": [
                {
                  "reward_id": 3,
                  "reason": "تحسن ملحوظ في القراءة",
                  "date": "2025-03-01",
                  "points": 8,
                },
              ],
              "study_plan": {
                "plan_id": 102,
                "start_date": "2025-04-01",
                "end_date": "2025-04-25",
                "description": "تحسين مهارات الكتابة والتعبير",
                "tasks": [
                  {
                    "task_id": 4,
                    "title": "كتابة فقرة يومية",
                    "deadline": "2025-04-05",
                    "completed": false,
                  },
                  {
                    "task_id": 5,
                    "title": "قراءة قصة قصيرة",
                    "deadline": "2025-04-12",
                    "completed": false,
                  },
                ],
              },
            },
            {
              "student_id": 1003,
              "student_name": "محمد سعيد",
              "grades": {"midterm": 70, "final": 75},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 68, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 72, "date": "2025-03-10"},
                {"type": "مشروع", "mark": 65, "date": "2025-03-25"},
              ],
              "rewards": [],
              "study_plan": null,
            },
            {
              "student_id": 1004,
              "student_name": "يوسف عمر",
              "grades": {"midterm": 92, "final": 88},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 95, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
                {"type": "مشاركة", "mark": 85, "date": "2025-01-20"},
                {"type": "مشروع", "mark": 98, "date": "2025-03-25"},
              ],
              "rewards": [
                {
                  "reward_id": 4,
                  "reason": "المركز الأول في مسابقة الرياضيات",
                  "date": "2025-03-20",
                  "points": 20,
                },
                {
                  "reward_id": 5,
                  "reason": "مساعدة المعلم في تنظيم الفصل",
                  "date": "2025-02-10",
                  "points": 5,
                },
              ],
              "study_plan": {
                "plan_id": 103,
                "start_date": "2025-04-01",
                "end_date": "2025-04-30",
                "description": "التحضير لمسابقة الرياضيات الوطنية",
                "tasks": [
                  {
                    "task_id": 6,
                    "title": "حل 20 مسألة إضافية",
                    "deadline": "2025-04-05",
                    "completed": true,
                  },
                  {
                    "task_id": 7,
                    "title": "مراجعة قوانين الهندسة",
                    "deadline": "2025-04-15",
                    "completed": false,
                  },
                ],
              },
            },
          ],
        },
        {
          "class_id": 2,
          "class_name": "الصف الأول - ب",
          "students": [
            {
              "student_id": 1011,
              "student_name": "ليلى علي",
              "grades": {"midterm": 95, "final": 97},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 93, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 96, "date": "2025-03-10"},
                {"type": "مشروع", "mark": 100, "date": "2025-03-25"},
              ],
              "rewards": [
                {
                  "reward_id": 6,
                  "reason": "الامتياز في العلوم",
                  "date": "2025-03-25",
                  "points": 15,
                },
                {
                  "reward_id": 7,
                  "reason": "مشاركة فعالة في الحصة",
                  "date": "2025-03-10",
                  "points": 5,
                },
              ],
              "study_plan": {
                "plan_id": 104,
                "start_date": "2025-04-01",
                "end_date": "2025-04-25",
                "description": "تحضير مشروع العلوم: بحث عن النباتات",
                "tasks": [
                  {
                    "task_id": 8,
                    "title": "اختيار موضوع البحث",
                    "deadline": "2025-04-02",
                    "completed": true,
                  },
                  {
                    "task_id": 9,
                    "title": "جمع المعلومات",
                    "deadline": "2025-04-10",
                    "completed": false,
                  },
                  {
                    "task_id": 10,
                    "title": "كتابة التقرير النهائي",
                    "deadline": "2025-04-20",
                    "completed": false,
                  },
                ],
              },
            },
            {
              "student_id": 1012,
              "student_name": "سلمى حسن",
              "grades": {"midterm": 65, "final": 70},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 60, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 68, "date": "2025-03-10"},
                {"type": "مشاركة", "mark": 75, "date": "2025-01-20"},
              ],
              "rewards": [],
              "study_plan": {
                "plan_id": 105,
                "start_date": "2025-04-01",
                "end_date": "2025-04-20",
                "description": "تقوية أساسيات اللغة الإنجليزية",
                "tasks": [
                  {
                    "task_id": 11,
                    "title": "حفظ 10 كلمات يومياً",
                    "deadline": "2025-04-05",
                    "completed": false,
                  },
                ],
              },
            },
            {
              "student_id": 1013,
              "student_name": "كريم أحمد",
              "grades": {"midterm": 80, "final": 84},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 82, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 79, "date": "2025-03-10"},
                {"type": "مشروع", "mark": 88, "date": "2025-03-25"},
                {"type": "مشاركة", "mark": 90, "date": "2025-01-20"},
              ],
              "rewards": [
                {
                  "reward_id": 8,
                  "reason": "الاجتهاد في حل الواجبات",
                  "date": "2025-03-05",
                  "points": 7,
                },
              ],
              "study_plan": {
                "plan_id": 106,
                "start_date": "2025-04-01",
                "end_date": "2025-04-25",
                "description": "تحسين الخط والكتابة",
                "tasks": [
                  {
                    "task_id": 12,
                    "title": "كتابة فقرة بخط جميل",
                    "deadline": "2025-04-05",
                    "completed": true,
                  },
                  {
                    "task_id": 13,
                    "title": "نسخ نص قرآني",
                    "deadline": "2025-04-12",
                    "completed": false,
                  },
                ],
              },
            },
            {
              "student_id": 1014,
              "student_name": "نورا إبراهيم",
              "grades": {"midterm": 88, "final": 91},
              "extra_marks": [
                {"type": "اختبار أول", "mark": 86, "date": "2025-02-15"},
                {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
                {"type": "مشروع", "mark": 95, "date": "2025-03-25"},
              ],
              "rewards": [
                {
                  "reward_id": 9,
                  "reason": "المركز الثاني في الإلقاء",
                  "date": "2025-03-28",
                  "points": 12,
                },
              ],
              "study_plan": null,
            },
          ],
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = responseData['data'];
    final String teacherName = data['teacher_name'];
    final List classes = data['classes'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        '📚 أ. $teacherName',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${classes.length} فصول',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, classIndex) {
                final classData = classes[classIndex];
                final String className = classData['class_name'];
                final List students = classData['students'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            className,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${students.length} طلاب',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...students.map((student) {
                      final String name = student['student_name'];
                      final Map<String, dynamic> grades = student['grades'];
                      final int average =
                          ((grades['midterm'] as int) +
                              (grades['final'] as int)) ~/
                          2;
                      final Color avgColor = average >= 90
                          ? Colors.green
                          : average >= 75
                          ? Colors.orange
                          : Colors.red;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    StudentDetailScreen(studentData: student),
                              ),
                            );
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.colorScheme.primary,
                                  child: Text(
                                    name[0],
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'المعدل: $average/100',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: avgColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$average%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: avgColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.chevron_left,
                                  color: theme.hintColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 60),
                  ],
                );
              }, childCount: classes.length),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AcademicRecordScreen extends StatefulWidget {
  const AcademicRecordScreen({super.key});

  @override
  State<AcademicRecordScreen> createState() => _AcademicRecordScreenState();
}

class _AcademicRecordScreenState extends State<AcademicRecordScreen>
    with TickerProviderStateMixin {
  final Map<String, dynamic> studentData = const {
    "success": true,
    "message": "تم جلب سجل الطالب بنجاح",
    "data": {
      "student_info": {
        "id": "2024001",
        "name": "أحمد محمد",
        "class": "الصف العاشر - أ",
        "academic_year": "2024/2025",
        "semester": "الفصل الدراسي الأول",
      },
      "academic_summary": {
        "semester_average": 88.5,
        "semester_grade": "جيد جداً",
        "rank_in_class": 5,
        "total_students": 30,
      },
      "attendance": {
        "total_absences": 6,
        "justified_absences": 2,
        "unjustified_absences": 4,
        "absence_details": [
          {
            "date": "2024-10-15",
            "day": "الأحد",
            "reason": "مرض",
            "is_justified": true,
          },
          {
            "date": "2024-10-22",
            "day": "الأحد",
            "reason": "تأخر بدون عذر",
            "is_justified": false,
          },
          {
            "date": "2024-11-05",
            "day": "الثلاثاء",
            "reason": "ظروف عائلية",
            "is_justified": true,
          },
        ],
      },
      "warnings": {
        "count": 2,
        "list": [
          {
            "id": 1,
            "date": "2024-10-05",
            "type": "سلوكي",
            "reason": "التحدث مع الطلاب أثناء الحصة بشكل مزعج",
            "action_taken": "تم إشعار ولي الأمر",
          },
          {
            "id": 2,
            "date": "2024-10-28",
            "type": "أكاديمي",
            "reason": "تأخر في تسليم الواجب الأول لمدة 3 أيام",
            "action_taken": "إنذار كتابي",
          },
        ],
      },
      "rewards": {
        "count": 3,
        "list": [
          {
            "id": 1,
            "date": "2024-09-20",
            "type": "تفوق أكاديمي",
            "reason": "الحصول على الدرجة الكاملة في اختبار المفاجأة",
            "teacher": "أ. محمد",
            "reward": "شهادة تقدير + 5 درجات تحفيزية",
          },
          {
            "id": 2,
            "date": "2024-10-20",
            "type": "سلوك ممتاز",
            "reason": "تميز الطالب في المشاركة الصفية ومساعدة زملائه",
            "teacher": "أ. خالد",
            "reward": "تطويق إيجابي + ذكر في الإذاعة المدرسية",
          },
          {
            "id": 3,
            "date": "2024-11-10",
            "type": "تحسن ملحوظ",
            "reason": "تحسن المستوى الدراسي في مادة الرياضيات بنسبة 15%",
            "teacher": "أ. سارة",
            "reward": "بطاقة تحفيز + خصم غياب",
          },
        ],
      },
      "exam_marks": [
        {
          "subject": "الرياضيات",
          "midterm": {"mark": 42, "max_mark": 50, "percentage": 84},
          "first_test": {"mark": 28, "max_mark": 30, "percentage": 93.3},
          "second_test": {"mark": 18, "max_mark": 20, "percentage": 90},
        },
        {
          "subject": "الدراسات الاجتماعية",
          "midterm": {"mark": 4, "max_mark": 50, "percentage": 8},
          "first_test": {"mark": 27, "max_mark": 30, "percentage": 90},
          "second_test": {"mark": 2, "max_mark": 20, "percentage": 35},
        },
      ],
    },
  };

  late AnimationController _mainAnimController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;

  final int _totalSections = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final data = studentData['data'];
    final studentInfo = data['student_info'];
    final academicSummary = data['academic_summary'];
    final attendance = data['attendance'];
    final warnings = data['warnings'];
    final rewards = data['rewards'];
    final examMarks = data['exam_marks'] as List;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        studentInfo['name'],
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        studentInfo['class'],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'رقم الطالب: ${studentInfo['id']}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.8),
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
              delegate: SliverChildListDelegate([
                _AnimatedSection(
                  fadeAnim: _fadeAnimations[0],
                  slideAnim: _slideAnimations[0],
                  scaleAnim: _scaleAnimations[0],
                  child: _buildInfoCard(
                    context,
                    title: '📋 معلومات العام الدراسي',
                    children: [
                      _buildInfoRow(
                        context,
                        'العام الدراسي',
                        studentInfo['academic_year'],
                      ),
                      _buildInfoRow(
                        context,
                        'الفصل الدراسي',
                        studentInfo['semester'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _AnimatedSection(
                  fadeAnim: _fadeAnimations[1],
                  slideAnim: _slideAnimations[1],
                  scaleAnim: _scaleAnimations[1],
                  child: _buildQuickStatsRow(
                    context,
                    attendance,
                    rewards,
                    warnings,
                  ),
                ),
                const SizedBox(height: 16),

                _AnimatedSection(
                  fadeAnim: _fadeAnimations[2],
                  slideAnim: _slideAnimations[2],
                  scaleAnim: _scaleAnimations[2],
                  child: _buildAcademicSummaryCard(context, academicSummary),
                ),
                const SizedBox(height: 16),

                _AnimatedSection(
                  fadeAnim: _fadeAnimations[3],
                  slideAnim: _slideAnimations[3],
                  scaleAnim: _scaleAnimations[3],
                  child: _buildExamMarksCard(context, examMarks),
                ),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mainAnimController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _mainAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimations = List.generate(_totalSections, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _slideAnimations = List.generate(_totalSections, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _scaleAnimations = List.generate(_totalSections, (index) {
      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mainAnimController.forward();
    });
  }

  Widget _buildAcademicSummaryCard(
    BuildContext context,
    Map<String, dynamic> summary,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.05),
              colorScheme.primary.withOpacity(0.1),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎯 الملخص الأكاديمي',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'المعدل',
                    '${summary['semester_average']}%',
                    Icons.show_chart,
                    isPercentage: true,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'التقدير',
                    summary['semester_grade'],
                    Icons.grade,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'الترتيب',
                    '${summary['rank_in_class']} / ${summary['total_students']}',
                    Icons.leaderboard,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMarksRow(
    BuildContext context,
    String title,
    Map<String, dynamic> marks,
  ) {
    final theme = Theme.of(context);
    final double percent = (marks['percentage'] as num).toDouble() / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.bodyMedium),
              Row(
                children: [
                  Text(
                    '${marks['mark']}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' / ${marks['max_mark']}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: Text(
                      '${marks['percentage']}%',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: percent),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade200,
                color: _getProgressColor(percent),
                minHeight: 8,
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------- بطاقة علامات الامتحانات مع أشرطة تقدم ----------
  Widget _buildExamMarksCard(BuildContext context, List examMarks) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📚 علامات الامتحانات',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...examMarks.map(
              (subject) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    _buildSubjectHeader(context, subject['subject']),
                    const SizedBox(height: 8),
                    _buildAnimatedMarksRow(
                      context,
                      'الامتحان الشهري',
                      subject['midterm'],
                    ),
                    _buildAnimatedMarksRow(
                      context,
                      'الاختبار الأول',
                      subject['first_test'],
                    ),
                    _buildAnimatedMarksRow(
                      context,
                      'الاختبار الثاني',
                      subject['second_test'],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- بطاقة معلومات العام الدراسي ----------
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- صف البطاقات الثلاث مع تأثيرات نبضية ----------
  Widget _buildQuickStatsRow(
    BuildContext context,
    Map<String, dynamic> attendance,
    Map<String, dynamic> rewards,
    Map<String, dynamic> warnings,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            title: 'الغياب',
            value: '${attendance['total_absences']}',
            icon: Icons.calendar_today,
            color: Colors.red,
            onTap: () => _showAttendanceDetails(context, attendance),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            title: 'المكافئات',
            value: '${rewards['count']}',
            icon: Icons.emoji_events,
            color: Colors.amber,
            onTap: () => _showRewardsDetails(context, rewards),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            title: 'الإنذارات',
            value: '${warnings['count']}',
            icon: Icons.warning_amber_rounded,
            color: Colors.orange,
            onTap: () => _showWarningsDetails(context, warnings),
          ),
        ),
      ],
    );
  }

  // بطاقة إحصائية صغيرة مع نبض متكرر للأيقونة وتأثير عند الضغط
  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        // إضافة تأثير تصغير سريع عند الضغط
        setState(() {});
        onTap();
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              _PulsingIcon(icon: icon, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectHeader(BuildContext context, String subject) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          subject,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool isPercentage = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 28),
          const SizedBox(height: 8),
          isPercentage
              ? _AnimatedCountWidget(
                  targetValue: double.tryParse(value.replaceAll('%', '')) ?? 0,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  suffix: '%',
                )
              : Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
          const SizedBox(height: 4),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Color _getProgressColor(double percent) {
    if (percent >= 0.9) return Colors.green;
    if (percent >= 0.8) return Colors.blue;
    if (percent >= 0.7) return Colors.orange;
    return Colors.red;
  }

  // ---------- نوافذ التفاصيل ----------
  void _showAttendanceDetails(
    BuildContext context,
    Map<String, dynamic> attendance,
  ) {
    final list = attendance['absence_details'] as List;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.red),
            const SizedBox(width: 8),
            const Text('تفاصيل الغياب'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, i) {
              final item = list[i];
              return ListTile(
                leading: Icon(
                  item['is_justified'] ? Icons.check_circle : Icons.cancel,
                  color: item['is_justified'] ? Colors.green : Colors.red,
                ),
                title: Text('${item['day']} - ${item['date']}'),
                subtitle: Text(item['reason']),
                trailing: Text(
                  item['is_justified'] ? 'مبرر' : 'غير مبرر',
                  style: TextStyle(
                    color: item['is_justified'] ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showRewardsDetails(BuildContext context, Map<String, dynamic> rewards) {
    final list = rewards['list'] as List;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber),
            const SizedBox(width: 8),
            const Text('تفاصيل المكافئات'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, i) {
              final item = list[i];
              return ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: Text('${item['type']} - ${item['date']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['reason']),
                    const SizedBox(height: 4),
                    Text('المعلم: ${item['teacher']}'),
                    Text(
                      '🎁 ${item['reward']}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showWarningsDetails(
    BuildContext context,
    Map<String, dynamic> warnings,
  ) {
    final list = warnings['list'] as List;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('تفاصيل الإنذارات'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, i) {
              final item = list[i];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.orange),
                title: Text('${item['type']} - ${item['date']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['reason']),
                    const SizedBox(height: 4),
                    Text(
                      'الإجراء: ${item['action_taken']}',
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}

// ---------- عداد متحرك للأرقام ----------
class _AnimatedCountWidget extends StatefulWidget {
  final double targetValue;
  final TextStyle? style;
  final String suffix;
  const _AnimatedCountWidget({
    required this.targetValue,
    this.style,
    this.suffix = '',
  });

  @override
  State<_AnimatedCountWidget> createState() => _AnimatedCountWidgetState();
}

class _AnimatedCountWidgetState extends State<_AnimatedCountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _countController;
  late Animation<double> _countAnim;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnim,
      builder: (context, _) {
        return Text(
          '${_countAnim.value.toStringAsFixed(1)}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _countAnim = Tween<double>(
      begin: 0,
      end: widget.targetValue,
    ).animate(CurvedAnimation(parent: _countController, curve: Curves.easeOut));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _countController.forward();
    });
  }
}

// ---------- ويدجت القسم المتحرك (Fade + Slide + Scale) ----------
class _AnimatedSection extends StatelessWidget {
  final Widget child;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;
  final Animation<double> scaleAnim;

  const _AnimatedSection({
    required this.child,
    required this.fadeAnim,
    required this.slideAnim,
    required this.scaleAnim,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnim,
      builder: (context, _) {
        return FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: ScaleTransition(scale: scaleAnim, child: child),
          ),
        );
      },
    );
  }
}

// ---------- أيقونة نبضية متكررة ----------
class _PulsingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  const _PulsingIcon({required this.icon, required this.color});

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Icon(widget.icon, color: widget.color, size: 32),
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
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.9, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }
}

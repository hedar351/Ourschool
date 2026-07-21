// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());
// class ClassesScreen extends StatelessWidget {
//   final Map<String, dynamic> school;
//   const ClassesScreen({super.key, required this.school});

//   @override
//   Widget build(BuildContext context) {
//     final List classes = school['classes'];
//     return Scaffold(
//       appBar: AppBar(title: Text(school['school_name']), centerTitle: true),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: classes.length,
//         itemBuilder: (context, index) {
//           final classItem = classes[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 child: Text(
//                   classItem['class_name'][0],
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//               title: Text(
//                 classItem['class_name'],
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('${classItem['divisions'].length} شعب'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => DivisionsScreen(
//                     schoolName: school['school_name'],
//                     classItem: classItem,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ============================================================
// // شاشة عرض الشعب
// // ============================================================
// class DivisionsScreen extends StatelessWidget {
//   final String schoolName;
//   final Map<String, dynamic> classItem;
//   const DivisionsScreen({
//     super.key,
//     required this.schoolName,
//     required this.classItem,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List divisions = classItem['divisions'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$schoolName - ${classItem['class_name']}'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: divisions.length,
//         itemBuilder: (context, index) {
//           final division = divisions[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: const Icon(Icons.group),
//               title: Text(
//                 division['division_name'],
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('${division['students'].length} طلاب'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => StudentsListScreen(
//                     schoolName: schoolName,
//                     className: classItem['class_name'],
//                     divisionName: division['division_name'],
//                     students: division['students'],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'نظام إدارة المعلم',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.teal,
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.grey[50],
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.teal,
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.grey[900],
//       ),
//       themeMode: ThemeMode.system,
//       home: const SchoolsScreen(),
//     );
//   }
// }

// // ============================================================
// // الشاشة الرئيسية: عرض المدارس في GridView
// // ============================================================
// class SchoolsScreen extends StatelessWidget {
//   const SchoolsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final teacherData = responseData['data'];
//     final List schools = teacherData['schools'];

//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
//         child: SafeArea(
//           child: CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.all(16),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) => _SchoolCard(school: schools[index]),
//                     childCount: schools.length,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================
// // شاشة تفاصيل الطالب (تم إزالة المعدل العام)
// // ============================================================
// class StudentDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> studentData;
//   const StudentDetailScreen({super.key, required this.studentData});

//   @override
//   State<StudentDetailScreen> createState() => _StudentDetailScreenState();
// }

// // ============================================================
// // شاشة عرض الطلاب مع بحث (تم تحسين ألوان الخانة)
// // ============================================================
// class StudentsListScreen extends StatefulWidget {
//   final String schoolName;
//   final String className;
//   final String divisionName;
//   final List students;
//   const StudentsListScreen({
//     super.key,
//     required this.schoolName,
//     required this.className,
//     required this.divisionName,
//     required this.students,
//   });

//   @override
//   State<StudentsListScreen> createState() => _StudentsListScreenState();
// }

// class _ExtraMarkCard extends StatelessWidget {
//   final Map<String, dynamic> mark;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   const _ExtraMarkCard({
//     required this.mark,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 6),
//       child: ListTile(
//         title: Text('${mark['type']} : ${mark['mark']}/100'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit, size: 18),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, size: 18, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _GradeCard extends StatelessWidget {
//   final String label;
//   final int value;
//   final Color color;
//   const _GradeCard({
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(label),
//             Text(
//               '$value/100',
//               style: TextStyle(fontWeight: FontWeight.bold, color: color),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _RewardCard extends StatelessWidget {
//   final Map<String, dynamic> reward;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   const _RewardCard({
//     required this.reward,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.amber.shade50,
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: const Icon(Icons.emoji_events, color: Colors.amber),
//         title: Text(
//           reward['reason'],
//           style: const TextStyle(fontWeight: FontWeight.w500),
//         ),
//         subtitle: Text('${reward['date']} | +${reward['points']} نقطة'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit, size: 18),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, size: 18, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SchoolCard extends StatelessWidget {
//   final Map<String, dynamic> school;
//   const _SchoolCard({required this.school});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 4,
//       shadowColor: theme.colorScheme.primary.withOpacity(0.2),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(24),
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => ClassesScreen(school: school)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.school_outlined,
//                 size: 56,
//                 color: theme.colorScheme.primary,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 school['school_name'],
//                 style: theme.textTheme.titleMedium,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '${school['classes'].length} صفوف',
//                 style: theme.textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================
// // ويدجتات مساعدة
// // ============================================================
// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   const _SectionHeader({required this.title, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: Theme.of(context).colorScheme.primary),
//         const SizedBox(width: 8),
//         Text(title, style: Theme.of(context).textTheme.titleMedium),
//       ],
//     );
//   }
// }

// // ============================================================
// // باقي الكود (StudentDetailScreenState مع إزالة المعدل العام)
// // ============================================================
// class _StudentDetailScreenState extends State<StudentDetailScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Map<String, dynamic> student;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final grades = student['grades'];

//     return Scaffold(
//       appBar: AppBar(title: Text(student['student_name']), centerTitle: true),
//       body: FadeTransition(
//         opacity: _controller,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // الدرجات
//               _SectionHeader(title: '📊 الدرجات', icon: Icons.grade),
//               const SizedBox(height: 12),
//               _GradeCard(
//                 label: 'امتحان نصفي',
//                 value: grades['midterm'],
//                 color: Colors.blue,
//               ),
//               _GradeCard(
//                 label: 'امتحان نهائي',
//                 value: grades['final'],
//                 color: Colors.green,
//               ),
//               if (student['extra_marks'].isNotEmpty) ...[
//                 const SizedBox(height: 8),
//                 Text('علامات أخرى', style: theme.textTheme.titleSmall),
//                 ...List.generate(
//                   student['extra_marks'].length,
//                   (index) => _ExtraMarkCard(
//                     mark: student['extra_marks'][index],
//                     onDelete: () => _deleteMark(index),
//                     onEdit: () => _editMarkDialog(index),
//                   ),
//                 ),
//               ],
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: _showAddMarkDialog,
//                   icon: const Icon(Icons.add),
//                   label: const Text('إضافة علامة'),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // المكافآت
//               _SectionHeader(title: '🏆 المكافآت', icon: Icons.emoji_events),
//               const SizedBox(height: 8),
//               if (student['rewards'].isNotEmpty)
//                 ...List.generate(
//                   student['rewards'].length,
//                   (index) => _RewardCard(
//                     reward: student['rewards'][index],
//                     onDelete: () => _deleteReward(index),
//                     onEdit: () => _editRewardDialog(index),
//                   ),
//                 )
//               else
//                 Text('لا توجد مكافآت', style: theme.textTheme.bodySmall),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: _showAddRewardDialog,
//                   icon: const Icon(Icons.add),
//                   label: const Text('إضافة مكافأة'),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // الخطة الدراسية
//               _SectionHeader(
//                 title: '📅 الخطة الدراسية',
//                 icon: Icons.calendar_month,
//               ),
//               const SizedBox(height: 8),
//               if (student['study_plan'] != null)
//                 _StudyPlanCard(
//                   plan: student['study_plan'],
//                   onAddTask: _showAddTaskDialog,
//                   onEditTask: _editTaskDialog,
//                   onDeleteTask: _deleteTask,
//                 )
//               else
//                 Text('لا توجد خطة دراسية', style: theme.textTheme.bodySmall),
//               if (student['study_plan'] == null)
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton.icon(
//                     onPressed: _showAddStudyPlanDialog,
//                     icon: const Icon(Icons.add),
//                     label: const Text('إضافة خطة'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     student = Map.from(widget.studentData);
//     student['extra_marks'] ??= [];
//     student['rewards'] ??= [];
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _controller.forward();
//   }

//   // -------------------- عمليات التعديل والإضافة --------------------
//   void _deleteMark(int index) =>
//       setState(() => student['extra_marks'].removeAt(index));
//   void _deleteReward(int index) =>
//       setState(() => student['rewards'].removeAt(index));
//   void _deleteTask(int index) =>
//       setState(() => student['study_plan']['tasks'].removeAt(index));

//   void _editMarkDialog(int index) async {
//     final mark = student['extra_marks'][index];
//     final typeController = TextEditingController(text: mark['type']);
//     final markController = TextEditingController(text: mark['mark'].toString());
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل العلامة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: typeController,
//               decoration: const InputDecoration(labelText: 'نوع الامتحان'),
//             ),
//             TextField(
//               controller: markController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final newMark = int.tryParse(markController.text);
//               if (typeController.text.isNotEmpty &&
//                   newMark != null &&
//                   newMark >= 0 &&
//                   newMark <= 100) {
//                 setState(() {
//                   student['extra_marks'][index] = {
//                     'type': typeController.text,
//                     'mark': newMark,
//                     'date': mark['date'],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _editRewardDialog(int index) async {
//     final reward = student['rewards'][index];
//     final reasonController = TextEditingController(text: reward['reason']);
//     final pointsController = TextEditingController(
//       text: reward['points'].toString(),
//     );
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل المكافأة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(labelText: 'سبب المكافأة'),
//             ),
//             TextField(
//               controller: pointsController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'النقاط'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final points = int.tryParse(pointsController.text);
//               if (reasonController.text.isNotEmpty && points != null) {
//                 setState(() {
//                   student['rewards'][index] = {
//                     'reward_id': reward['reward_id'],
//                     'reason': reasonController.text,
//                     'date': reward['date'],
//                     'points': points,
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _editTaskDialog(int index) async {
//     final task = student['study_plan']['tasks'][index];
//     final titleController = TextEditingController(text: task['title']);
//     final deadlineController = TextEditingController(text: task['deadline']);
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل المهمة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'عنوان المهمة'),
//             ),
//             TextField(
//               controller: deadlineController,
//               decoration: const InputDecoration(labelText: 'تاريخ التسليم'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   deadlineController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan']['tasks'][index] = {
//                     'task_id': task['task_id'],
//                     'title': titleController.text,
//                     'deadline': deadlineController.text,
//                     'completed': task['completed'],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddMarkDialog() async {
//     final typeController = TextEditingController();
//     final markController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة علامة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: typeController,
//               decoration: const InputDecoration(labelText: 'نوع الامتحان'),
//             ),
//             TextField(
//               controller: markController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final mark = int.tryParse(markController.text);
//               if (typeController.text.isNotEmpty &&
//                   mark != null &&
//                   mark >= 0 &&
//                   mark <= 100) {
//                 setState(() {
//                   student['extra_marks'].add({
//                     'type': typeController.text,
//                     'mark': mark,
//                     'date': DateTime.now().toIso8601String().substring(0, 10),
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddRewardDialog() async {
//     final reasonController = TextEditingController();
//     final pointsController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة مكافأة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(labelText: 'سبب المكافأة'),
//             ),
//             TextField(
//               controller: pointsController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'النقاط'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final points = int.tryParse(pointsController.text);
//               if (reasonController.text.isNotEmpty && points != null) {
//                 setState(() {
//                   student['rewards'].add({
//                     'reward_id': DateTime.now().millisecondsSinceEpoch,
//                     'reason': reasonController.text,
//                     'date': DateTime.now().toIso8601String().substring(0, 10),
//                     'points': points,
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddStudyPlanDialog() async {
//     final descController = TextEditingController();
//     final startController = TextEditingController();
//     final endController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة خطة دراسية'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: descController,
//               decoration: const InputDecoration(labelText: 'وصف الخطة'),
//             ),
//             TextField(
//               controller: startController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ البداية (YYYY-MM-DD)',
//               ),
//             ),
//             TextField(
//               controller: endController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ النهاية (YYYY-MM-DD)',
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (descController.text.isNotEmpty &&
//                   startController.text.isNotEmpty &&
//                   endController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan'] = {
//                     'plan_id': DateTime.now().millisecondsSinceEpoch,
//                     'start_date': startController.text,
//                     'end_date': endController.text,
//                     'description': descController.text,
//                     'tasks': [],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddTaskDialog() async {
//     final titleController = TextEditingController();
//     final deadlineController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة مهمة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'عنوان المهمة'),
//             ),
//             TextField(
//               controller: deadlineController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ التسليم (YYYY-MM-DD)',
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   deadlineController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan']['tasks'].add({
//                     'task_id': DateTime.now().millisecondsSinceEpoch,
//                     'title': titleController.text,
//                     'deadline': deadlineController.text,
//                     'completed': false,
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ============================================================
// // شاشة عرض الطلاب (مع تحسين ألوان البحث)
// // ============================================================
// class _StudentsListScreenState extends State<StudentsListScreen> {
//   late List _filteredStudents;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '${widget.schoolName} - ${widget.className} - ${widget.divisionName}',
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: _searchController,
//               style: theme.textTheme.bodyMedium,
//               decoration: InputDecoration(
//                 hintText: 'بحث عن طالب...',
//                 hintStyle: theme.textTheme.bodySmall?.copyWith(
//                   color: isDark ? Colors.grey[400] : Colors.grey[600],
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: isDark ? Colors.grey[400] : Colors.grey[600],
//                 ),
//                 filled: true,
//                 fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(
//                     color: theme.colorScheme.primary,
//                     width: 1.5,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _filteredStudents.length,
//               itemBuilder: (context, index) {
//                 final student = _filteredStudents[index];
//                 final grades = student['grades'];
//                 final avg =
//                     ((grades['midterm'] as int) + (grades['final'] as int)) ~/
//                     2;
//                 final avgColor = avg >= 90
//                     ? Colors.green
//                     : avg >= 75
//                     ? Colors.orange
//                     : Colors.red;
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: theme.colorScheme.primary,
//                       child: Text(
//                         student['student_name'][0],
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       student['student_name'],
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('المعدل: $avg%'),
//                     trailing: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: avgColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         '$avg%',
//                         style: TextStyle(
//                           color: avgColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             StudentDetailScreen(studentData: Map.from(student)),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _filteredStudents = widget.students;
//     _searchController.addListener(() {
//       setState(() {
//         _filteredStudents = widget.students
//             .where(
//               (student) =>
//                   student['student_name'].contains(_searchController.text),
//             )
//             .toList();
//       });
//     });
//   }
// }

// class _StudyPlanCard extends StatefulWidget {
//   final Map<String, dynamic> plan;
//   final VoidCallback onAddTask;
//   final Function(int) onEditTask;
//   final Function(int) onDeleteTask;
//   const _StudyPlanCard({
//     required this.plan,
//     required this.onAddTask,
//     required this.onEditTask,
//     required this.onDeleteTask,
//   });

//   @override
//   State<_StudyPlanCard> createState() => _StudyPlanCardState();
// }

// class _StudyPlanCardState extends State<_StudyPlanCard> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final tasks = widget.plan['tasks'] as List;
//     final completed = tasks.where((t) => t['completed'] == true).length;
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               widget.plan['description'],
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//             subtitle: Text(
//               '${widget.plan['start_date']} → ${widget.plan['end_date']}',
//             ),
//             trailing: IconButton(
//               icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
//               onPressed: () => setState(() => _expanded = !_expanded),
//             ),
//           ),
//           if (_expanded)
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text('تقدم المهام: $completed/${tasks.length}'),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: LinearProgressIndicator(
//                           value: tasks.isEmpty ? 0 : completed / tasks.length,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   ...List.generate(tasks.length, (index) {
//                     final task = tasks[index];
//                     return ListTile(
//                       leading: Icon(
//                         task['completed']
//                             ? Icons.check_circle
//                             : Icons.radio_button_unchecked,
//                         color: task['completed'] ? Colors.green : Colors.grey,
//                       ),
//                       title: Text(
//                         task['title'],
//                         style: TextStyle(
//                           decoration: task['completed']
//                               ? TextDecoration.lineThrough
//                               : null,
//                         ),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, size: 16),
//                             onPressed: () => widget.onEditTask(index),
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               size: 16,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => widget.onDeleteTask(index),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton.icon(
//                       onPressed: widget.onAddTask,
//                       icon: const Icon(Icons.add),
//                       label: const Text('إضافة مهمة'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

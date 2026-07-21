import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Teacher/ui/page/school_subjects_screen.dart';
import 'package:school/generated/l10n.dart';

import '../bloc/TeacherBloc/teacher_bloc.dart';
import '../widget/TeacherSchoolCard .dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TeacherBloc>()..add(GetTeacherEvent()),
      child: BlocBuilder<TeacherBloc, TeacherState>(
        builder: (context, state) {
          if (state is TeacherLoading) {
            return const Loadingwidget();
          }
          if (state is TeacherLoaded) {
            final profile = state.profile;
            final teacher = profile.teacherInfo;
            final schools = profile.school ?? [];

            return Scaffold(
              appBar: AppBar(
                title: Text(teacher?.name ?? S.of(context).teacher_profile),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<TeacherBloc>().add(RefreshTeacherEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: schools.length,
                  itemBuilder: (context, index) {
                    final school = schools[index];
                    return TeacherSchoolCard(
                      school: school,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SchoolSubjectsScreen(
                              school: school,
                              schoolName: school.schoolName ?? '',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }
          if (state is TeacherError) {
            return Center(child: Text(state.message));
          }
          return const Loadingwidget();
        },
      ),
    );
  }
}

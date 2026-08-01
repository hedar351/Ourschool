// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Our School`
  String get title {
    return Intl.message('Our School', name: 'title', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_continue',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Or explore our school`
  String get or_explore {
    return Intl.message(
      'Or explore our school',
      name: 'or_explore',
      desc: '',
      args: [],
    );
  }

  /// `Browse school information`
  String get browse_school {
    return Intl.message(
      'Browse school information',
      name: 'browse_school',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Our School`
  String get welcome_school {
    return Intl.message(
      'Welcome to Our School',
      name: 'welcome_school',
      desc: '',
      args: [],
    );
  }

  /// `An integrated educational environment that aims to develop skills and build the student's personality in an atmosphere of values, respect, and excellence.`
  String get school_description {
    return Intl.message(
      'An integrated educational environment that aims to develop skills and build the student\'s personality in an atmosphere of values, respect, and excellence.',
      name: 'school_description',
      desc: '',
      args: [],
    );
  }

  /// `We build leaders .. We inspire the future`
  String get we_build_leaders {
    return Intl.message(
      'We build leaders .. We inspire the future',
      name: 'we_build_leaders',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get login_success {
    return Intl.message(
      'Login successful',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Server error, please try again later`
  String get server_failure {
    return Intl.message(
      'Server error, please try again later',
      name: 'server_failure',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get offline_failure {
    return Intl.message(
      'No internet connection',
      name: 'offline_failure',
      desc: '',
      args: [],
    );
  }

  /// `No cached user found`
  String get empty_cache_failure {
    return Intl.message(
      'No cached user found',
      name: 'empty_cache_failure',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error, please try again later`
  String get unexpected_error {
    return Intl.message(
      'Unexpected error, please try again later',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `School Management System`
  String get welcome_screen_subtitle {
    return Intl.message(
      'School Management System',
      name: 'welcome_screen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse school information`
  String get explore_without_login {
    return Intl.message(
      'Browse school information',
      name: 'explore_without_login',
      desc: '',
      args: [],
    );
  }

  /// `School Management System`
  String get school_management_system {
    return Intl.message(
      'School Management System',
      name: 'school_management_system',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get Unavailable {
    return Intl.message('Unavailable', name: 'Unavailable', desc: '', args: []);
  }

  /// `This account is currently not available for viewing`
  String get account_not_available {
    return Intl.message(
      'This account is currently not available for viewing',
      name: 'account_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message('Ok', name: 'Ok', desc: '', args: []);
  }

  /// `Please enter your username`
  String get Username {
    return Intl.message(
      'Please enter your username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get Password {
    return Intl.message(
      'Please enter your password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Students`
  String get Students {
    return Intl.message('Students', name: 'Students', desc: '', args: []);
  }

  /// `Activities`
  String get Activities {
    return Intl.message('Activities', name: 'Activities', desc: '', args: []);
  }

  /// `Announcements`
  String get Announcements {
    return Intl.message(
      'Announcements',
      name: 'Announcements',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `Theme`
  String get Theme {
    return Intl.message('Theme', name: 'Theme', desc: '', args: []);
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get want_to_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'want_to_logout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Payments`
  String get Payments {
    return Intl.message('Payments', name: 'Payments', desc: '', args: []);
  }

  /// `AcademicRecord`
  String get Info {
    return Intl.message('AcademicRecord', name: 'Info', desc: '', args: []);
  }

  /// `There are no bulletins at the moment`
  String get There_are_no_bulletins_at_the_moment {
    return Intl.message(
      'There are no bulletins at the moment',
      name: 'There_are_no_bulletins_at_the_moment',
      desc: '',
      args: [],
    );
  }

  /// `Pull down to refresh.`
  String get Pull_down_to_refresh {
    return Intl.message(
      'Pull down to refresh.',
      name: 'Pull_down_to_refresh',
      desc: '',
      args: [],
    );
  }

  /// `There are no activities or announcements at the moment.`
  String get There_are_no_activities_or_announcements_at_the_moment {
    return Intl.message(
      'There are no activities or announcements at the moment.',
      name: 'There_are_no_activities_or_announcements_at_the_moment',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get Sections {
    return Intl.message('Sections', name: 'Sections', desc: '', args: []);
  }

  /// `There are no sections at the moment`
  String get There_are_no_sections_at_the_moment {
    return Intl.message(
      'There are no sections at the moment',
      name: 'There_are_no_sections_at_the_moment',
      desc: '',
      args: [],
    );
  }

  /// `Guardian Name:`
  String get guardianName {
    return Intl.message(
      'Guardian Name:',
      name: 'guardianName',
      desc: '',
      args: [],
    );
  }

  /// `First Semester`
  String get semester_1 {
    return Intl.message(
      'First Semester',
      name: 'semester_1',
      desc: '',
      args: [],
    );
  }

  /// `Second Semester`
  String get semester_2 {
    return Intl.message(
      'Second Semester',
      name: 'semester_2',
      desc: '',
      args: [],
    );
  }

  /// `Oral`
  String get oral {
    return Intl.message('Oral', name: 'oral', desc: '', args: []);
  }

  /// `Oral 2`
  String get oral_2 {
    return Intl.message('Oral 2', name: 'oral_2', desc: '', args: []);
  }

  /// `Homework`
  String get homework {
    return Intl.message('Homework', name: 'homework', desc: '', args: []);
  }

  /// `Final`
  String get final_exam {
    return Intl.message('Final', name: 'final_exam', desc: '', args: []);
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// ` Subjects`
  String get subjects_title {
    return Intl.message(
      ' Subjects',
      name: 'subjects_title',
      desc: '',
      args: [],
    );
  }

  /// ` Marks`
  String get marks_title {
    return Intl.message(' Marks', name: 'marks_title', desc: '', args: []);
  }

  /// ` Warnings`
  String get warnings_title {
    return Intl.message(
      ' Warnings',
      name: 'warnings_title',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown_name {
    return Intl.message('Unknown', name: 'unknown_name', desc: '', args: []);
  }

  /// `Not specified`
  String get not_specified {
    return Intl.message(
      'Not specified',
      name: 'not_specified',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Warning`
  String get warning {
    return Intl.message('Warning', name: 'warning', desc: '', args: []);
  }

  /// `General`
  String get type_general {
    return Intl.message('General', name: 'type_general', desc: '', args: []);
  }

  /// `Unknown date`
  String get date_unknown {
    return Intl.message(
      'Unknown date',
      name: 'date_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Warning Details`
  String get warning_details {
    return Intl.message(
      'Warning Details',
      name: 'warning_details',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message('Reason', name: 'reason', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Mr./Ms.`
  String get teacher_prefix {
    return Intl.message('Mr./Ms.', name: 'teacher_prefix', desc: '', args: []);
  }

  /// `Semester`
  String get semester {
    return Intl.message('Semester', name: 'semester', desc: '', args: []);
  }

  /// `Final Grade`
  String get final_grade {
    return Intl.message('Final Grade', name: 'final_grade', desc: '', args: []);
  }

  /// `Add New Warning`
  String get add_warning_title {
    return Intl.message(
      'Add New Warning',
      name: 'add_warning_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Warning Type`
  String get select_warning_type {
    return Intl.message(
      'Select Warning Type',
      name: 'select_warning_type',
      desc: '',
      args: [],
    );
  }

  /// `Behavior`
  String get type_behavior {
    return Intl.message('Behavior', name: 'type_behavior', desc: '', args: []);
  }

  /// `Dismissal Warning`
  String get type_dismissal_warning {
    return Intl.message(
      'Dismissal Warning',
      name: 'type_dismissal_warning',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Please select a type and fill the reason`
  String get please_select_type_and_reason {
    return Intl.message(
      'Please select a type and fill the reason',
      name: 'please_select_type_and_reason',
      desc: '',
      args: [],
    );
  }

  /// `Teacher Profile`
  String get teacher_profile {
    return Intl.message(
      'Teacher Profile',
      name: 'teacher_profile',
      desc: '',
      args: [],
    );
  }

  /// `Unknown School`
  String get unknown_school {
    return Intl.message(
      'Unknown School',
      name: 'unknown_school',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message('Subjects', name: 'subjects', desc: '', args: []);
  }

  /// `Classes`
  String get classes {
    return Intl.message('Classes', name: 'classes', desc: '', args: []);
  }

  /// `Subjects in {schoolName}`
  String school_subjects(Object schoolName) {
    return Intl.message(
      'Subjects in $schoolName',
      name: 'school_subjects',
      desc: '',
      args: [schoolName],
    );
  }

  /// `Grades for {subjectName}`
  String subject_grades(Object subjectName) {
    return Intl.message(
      'Grades for $subjectName',
      name: 'subject_grades',
      desc: '',
      args: [subjectName],
    );
  }

  /// `Sections for {gradeName}`
  String grade_sections(Object gradeName) {
    return Intl.message(
      'Sections for $gradeName',
      name: 'grade_sections',
      desc: '',
      args: [gradeName],
    );
  }

  /// `Class`
  String get class_name {
    return Intl.message('Class', name: 'class_name', desc: '', args: []);
  }

  /// `Schools`
  String get schools {
    return Intl.message('Schools', name: 'schools', desc: '', args: []);
  }

  /// `No schools available`
  String get noSchools {
    return Intl.message(
      'No schools available',
      name: 'noSchools',
      desc: '',
      args: [],
    );
  }

  /// `Pull down to refresh`
  String get pullToRefresh {
    return Intl.message(
      'Pull down to refresh',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Teachers`
  String get teachers {
    return Intl.message('Teachers', name: 'teachers', desc: '', args: []);
  }

  /// `Students`
  String get students {
    return Intl.message('Students', name: 'students', desc: '', args: []);
  }

  /// `Teaching Staff`
  String get teachingStaff {
    return Intl.message(
      'Teaching Staff',
      name: 'teachingStaff',
      desc: '',
      args: [],
    );
  }

  /// `more teachers`
  String get moreTeachers {
    return Intl.message(
      'more teachers',
      name: 'moreTeachers',
      desc: '',
      args: [],
    );
  }

  /// `Teachers of`
  String get teachersOf {
    return Intl.message('Teachers of', name: 'teachersOf', desc: '', args: []);
  }

  /// `No teachers in this school`
  String get noTeachers {
    return Intl.message(
      'No teachers in this school',
      name: 'noTeachers',
      desc: '',
      args: [],
    );
  }

  /// `Teacher Details`
  String get teacherDetails {
    return Intl.message(
      'Teacher Details',
      name: 'teacherDetails',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get contactInfo {
    return Intl.message(
      'Contact Info',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `Subjects Taught`
  String get subjectsTaught {
    return Intl.message(
      'Subjects Taught',
      name: 'subjectsTaught',
      desc: '',
      args: [],
    );
  }

  /// `No additional information`
  String get noAdditionalInfo {
    return Intl.message(
      'No additional information',
      name: 'noAdditionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Affiliated Schools`
  String get affiliatedSchools {
    return Intl.message(
      'Affiliated Schools',
      name: 'affiliatedSchools',
      desc: '',
      args: [],
    );
  }

  /// `school`
  String get schoolsCount {
    return Intl.message('school', name: 'schoolsCount', desc: '', args: []);
  }

  /// `teachers`
  String get teachersCount {
    return Intl.message('teachers', name: 'teachersCount', desc: '', args: []);
  }

  /// `student`
  String get studentsCount {
    return Intl.message('student', name: 'studentsCount', desc: '', args: []);
  }

  // skipped getter for the 'full name' key

  /// `Classes Taught`
  String get classesTaught {
    return Intl.message(
      'Classes Taught',
      name: 'classesTaught',
      desc: '',
      args: [],
    );
  }

  /// `There are no Marks at the moment`
  String get There_are_no_Marks_at_the_moment {
    return Intl.message(
      'There are no Marks at the moment',
      name: 'There_are_no_Marks_at_the_moment',
      desc: '',
      args: [],
    );
  }

  /// `There are no Warings at the moment`
  String get There_are_no_Warings_at_the_moment {
    return Intl.message(
      'There are no Warings at the moment',
      name: 'There_are_no_Warings_at_the_moment',
      desc: '',
      args: [],
    );
  }

  /// `Attendances`
  String get Attendance {
    return Intl.message('Attendances', name: 'Attendance', desc: '', args: []);
  }

  /// `Attendance Record`
  String get Attendance_Record {
    return Intl.message(
      'Attendance Record',
      name: 'Attendance_Record',
      desc: '',
      args: [],
    );
  }

  /// `Log`
  String get Log {
    return Intl.message('Log', name: 'Log', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get about_app {
    return Intl.message('About App', name: 'about_app', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `1.0.0`
  String get app_version {
    return Intl.message('1.0.0', name: 'app_version', desc: '', args: []);
  }

  /// `Our School - School Management System`
  String get app_title {
    return Intl.message(
      'Our School - School Management System',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Version: 1.0.0`
  String get app_version_info {
    return Intl.message(
      'Version: 1.0.0',
      name: 'app_version_info',
      desc: '',
      args: [],
    );
  }

  /// `An integrated application for managing schools, students, and teachers.`
  String get app_description {
    return Intl.message(
      'An integrated application for managing schools, students, and teachers.',
      name: 'app_description',
      desc: '',
      args: [],
    );
  }

  /// `We are committed to protecting your personal data. We do not share your information with any third party without your consent.`
  String get privacy_policy_text {
    return Intl.message(
      'We are committed to protecting your personal data. We do not share your information with any third party without your consent.',
      name: 'privacy_policy_text',
      desc: '',
      args: [],
    );
  }

  /// ` Email: support@ourschool.com`
  String get contact_email {
    return Intl.message(
      ' Email: support@ourschool.com',
      name: 'contact_email',
      desc: '',
      args: [],
    );
  }

  /// ` Phone: +963 11 123 4567`
  String get contact_phone {
    return Intl.message(
      ' Phone: +963 11 123 4567',
      name: 'contact_phone',
      desc: '',
      args: [],
    );
  }

  /// `Teacher`
  String get role_teacher {
    return Intl.message('Teacher', name: 'role_teacher', desc: '', args: []);
  }

  /// `Counselor`
  String get role_counselor {
    return Intl.message(
      'Counselor',
      name: 'role_counselor',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get role_student {
    return Intl.message('Student', name: 'role_student', desc: '', args: []);
  }

  /// `Admin`
  String get role_admin {
    return Intl.message('Admin', name: 'role_admin', desc: '', args: []);
  }

  /// `Password must be at least 6 characters`
  String get password_min_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Add Mark`
  String get add_mark {
    return Intl.message('Add Mark', name: 'add_mark', desc: '', args: []);
  }

  /// `Edit Mark`
  String get edit_mark {
    return Intl.message('Edit Mark', name: 'edit_mark', desc: '', args: []);
  }

  /// `No marks for semester 1`
  String get no_marks_semester_1 {
    return Intl.message(
      'No marks for semester 1',
      name: 'no_marks_semester_1',
      desc: '',
      args: [],
    );
  }

  /// `No marks for semester 2`
  String get no_marks_semester_2 {
    return Intl.message(
      'No marks for semester 2',
      name: 'no_marks_semester_2',
      desc: '',
      args: [],
    );
  }

  /// `Quiz Type`
  String get quiz_type {
    return Intl.message('Quiz Type', name: 'quiz_type', desc: '', args: []);
  }

  /// `Quiz 1`
  String get quiz_type_1 {
    return Intl.message('Quiz 1', name: 'quiz_type_1', desc: '', args: []);
  }

  /// `Quiz 2`
  String get quiz_type_2 {
    return Intl.message('Quiz 2', name: 'quiz_type_2', desc: '', args: []);
  }

  /// `Homework`
  String get quiz_type_3 {
    return Intl.message('Homework', name: 'quiz_type_3', desc: '', args: []);
  }

  /// `Final Exam`
  String get quiz_type_5 {
    return Intl.message('Final Exam', name: 'quiz_type_5', desc: '', args: []);
  }

  /// `Score`
  String get score {
    return Intl.message('Score', name: 'score', desc: '', args: []);
  }

  /// `Max Score`
  String get max_score {
    return Intl.message('Max Score', name: 'max_score', desc: '', args: []);
  }

  /// `out of`
  String get out_of {
    return Intl.message('out of', name: 'out_of', desc: '', args: []);
  }

  /// `Please select a semester`
  String get please_select_semester {
    return Intl.message(
      'Please select a semester',
      name: 'please_select_semester',
      desc: '',
      args: [],
    );
  }

  /// `Please select a quiz type`
  String get please_select_quiz_type {
    return Intl.message(
      'Please select a quiz type',
      name: 'please_select_quiz_type',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the score`
  String get please_enter_score {
    return Intl.message(
      'Please enter the score',
      name: 'please_enter_score',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the max score`
  String get please_enter_max_score {
    return Intl.message(
      'Please enter the max score',
      name: 'please_enter_max_score',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get please_enter_valid_number {
    return Intl.message(
      'Please enter a valid number',
      name: 'please_enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Academic Year Info`
  String get academic_year_info {
    return Intl.message(
      'Academic Year Info',
      name: 'academic_year_info',
      desc: '',
      args: [],
    );
  }

  /// `Summons`
  String get summons {
    return Intl.message('Summons', name: 'summons', desc: '', args: []);
  }

  /// `Issued by`
  String get issued_by {
    return Intl.message('Issued by', name: 'issued_by', desc: '', args: []);
  }

  /// `Student ID`
  String get student_id {
    return Intl.message('Student ID', name: 'student_id', desc: '', args: []);
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
  }

  /// `more`
  String get more {
    return Intl.message('more', name: 'more', desc: '', args: []);
  }

  /// `Schedule`
  String get schedule {
    return Intl.message('Schedule', name: 'schedule', desc: '', args: []);
  }

  /// `Quiz 1`
  String get quiz1 {
    return Intl.message('Quiz 1', name: 'quiz1', desc: '', args: []);
  }

  /// `Quiz 2`
  String get quiz2 {
    return Intl.message('Quiz 2', name: 'quiz2', desc: '', args: []);
  }

  /// `Academic Year`
  String get academic_year {
    return Intl.message(
      'Academic Year',
      name: 'academic_year',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/const.dart';
import 'package:school/core/widget/image_viewer.dart';
import 'package:school/generated/l10n.dart';

class ScheduleImageCard extends StatelessWidget {
  final String imageUrl;

  const ScheduleImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fullUrl = _getFullImageUrl();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' 📅 ${S.of(context).schedule}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: GestureDetector(
                onTap: () => ImageViewer.show(context, imageUrl),
                child: CachedNetworkImage(
                  imageUrl: fullUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.h,
                  placeholder: (context, url) => Container(
                    height: 200.h,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: null,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    print('🔴 [Image] Error loading: $error');
                    return Container(
                      height: 200.h,
                      color: Colors.grey.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 50.w,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'تعذر تحميل الصورة',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'اضغط للمحاولة مرة أخرى',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                ' اضغط على الصورة لتكبيرها',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFullImageUrl() {
    final String base = baseUrl.replaceAll('/api', '');
    final String rawUrl = imageUrl.startsWith('http')
        ? imageUrl
        : '$base${imageUrl.startsWith('/') ? '' : '/'}$imageUrl';

    return Uri.parse(rawUrl).toString();
  }
}

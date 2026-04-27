import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/color.dart';
import '../../../model/project_model.dart';
import '../../../model/proposal_model.dart';
import '../../../widget/gradient_button.dart';

class ProjectItemCard extends StatelessWidget {
  final ProposalModel proposal;
  final bool isAccepted;
  final bool isRejected;
  final VoidCallback onAccept;

  const ProjectItemCard({
    super.key,
    required this.isAccepted,
    required this.isRejected,
    required this.onAccept,
    required this.proposal,
  });

  @override
  Widget build(BuildContext context) {
    print("AVATAR URL: ${proposal.avatarUrl}");
    Color buttonColor;

    if (isAccepted) {
      buttonColor = Colors.green;
    } else if (isRejected) {
      buttonColor = Colors.red;
    } else {
      buttonColor = AppColors.primary; // قبل الاختيار
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundImage: proposal.avatarUrl.isNotEmpty
                          ? NetworkImage(proposal.avatarUrl)
                          : AssetImage("assets/images/avatar.png") as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proposal.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                            _timeAgo(proposal.createdAt),
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// صورة المشروع
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                proposal.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/placeholder.png");
                },
              ),
            ),
            SizedBox(height: 8.h),

            /// زر قبول
            ArchiButton(
              label: isAccepted
                  ? 'مقبول'
                  : isRejected
                  ? 'مرفوض'
                  : 'قبول',
              width: 120.w,
              height: 40.h,
              fontSize: 12.sp,
              borderRadius: 7,
              backgroundColor: buttonColor,
              onPressed: (isAccepted || isRejected) ? null : onAccept,
            )
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return "منذ ${diff.inMinutes} دقيقة";
    if (diff.inHours < 24) return "منذ ${diff.inHours} ساعة";
    return "منذ ${diff.inDays} يوم";
  }
}

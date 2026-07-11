// import 'package:flutter/material.dart';
// import 'package:school/generated/l10n.dart';

// class WelcomeHeader extends StatelessWidget {
//   const WelcomeHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Image.asset('assets/logo.png', width: 200, height: 200),
//           Text(
//             S.of(context).title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 34,
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).colorScheme.primary,
//               fontFamily: 'Cairo',
//             ),
//           ),

//           Text(
//             S.of(context).we_build_leaders,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 18,
//               color: Theme.of(context).colorScheme.secondary,
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:school/generated/l10n.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.29),
                  blurRadius: 60,
                ),
              ],
            ),
            child: Image.asset('assets/logo.png', width: 200, height: 200),
          ),
          Text(
            S.of(context).title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            S.of(context).we_build_leaders,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

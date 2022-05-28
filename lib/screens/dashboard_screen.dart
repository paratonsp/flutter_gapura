import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/components/header.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _StateDashboardScreen();
}

class _StateDashboardScreen extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Header(titlePage: ""),
        ),
        Expanded(
          child: SvgPicture.asset(
            "assets/images/gold_logo.svg",
            width: MediaQuery.of(context).size.width / 3,
          ),
        ),
      ],
    ))
        // SingleChildScrollView(
        //   primary: false,
        //   padding: EdgeInsets.all(defaultPadding),
        //   child: Column(
        //     children: [
        //       Header(titlePage: "Dashboard"),
        //       SizedBox(height: defaultPadding),
        //       Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Expanded(
        //             flex: 5,
        //             child: Column(
        //               children: [
        //                 MyFiles(),
        //                 SizedBox(height: defaultPadding),
        //                 RecentFiles(),
        //                 // if (Responsive.isMobile(context))
        //                 //   SizedBox(height: defaultPadding),
        //                 // if (Responsive.isMobile(context)) StarageDetails(),
        //               ],
        //             ),
        //           ),
        //           // if (!Responsive.isMobile(context))
        //           //   SizedBox(width: defaultPadding),
        //           // // On Mobile means if the screen is less than 850 we dont want to show it
        //           // if (!Responsive.isMobile(context))
        //           //   Expanded(
        //           //     flex: 2,
        //           //     child: StarageDetails(),
        //           //   ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}

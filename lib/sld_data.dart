import 'package:flutter/material.dart';

import '../appbar.dart';


class SldDataPage extends StatefulWidget {
  const SldDataPage({super.key});

  @override
  State<SldDataPage> createState() => _SCMDashboardPageState();
}

class _SCMDashboardPageState extends State<SldDataPage> {
  int topTabIndex = 0;
  bool sourceSelected = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FB),
      appBar: CustomAppBar(
        title: 'SCM',
        onBack: () => Navigator.pop(context),
        onBellTap: () {},
        showBellDot: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.045),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7FAFF),
                      border: Border.all(color: const Color(0xFFB9C7D9)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 180,),
                          Image.asset(
                            width: double.infinity,
                              "assets/nodata.png"),
                          Text(
                            textAlign: TextAlign.center,
                            "No Data is There \n Please Wait",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,),)

                        ],
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

}



import 'package:flutter/material.dart';
import 'package:taskapp/Dashboard/total_power.dart';

import '../appbar.dart';
import '../energy_detail_page.dart';
import '../safe_assets.dart';
import '../sld_data.dart';
import '../responsive.dart';

class SCMDashboardPage extends StatefulWidget {
  const SCMDashboardPage({super.key});

  @override
  State<SCMDashboardPage> createState() => _SCMDashboardPageState();
}

class _SCMDashboardPageState extends State<SCMDashboardPage> {
  int topTabIndex = 0;
  bool sourceSelected = true;

  @override
  Widget build(BuildContext context) {
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
          padding: Responsive.horizontal(context, 22),
          child: Column(
            children: [
              SizedBox(height: context.rSpace(20)),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.rSpace(18)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFB9C7D9)),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: context.rSpace(16),
                      ),
                      child: Column(
                        children: [
                          _TopTabs(
                            selectedIndex: topTabIndex,
                            onChanged: (i) =>
                                setState(() => topTabIndex = i),
                          ),
                          SizedBox(height: context.rSpace(4)),
                          Text(
                            "Electricity",
                            style: TextStyle(
                              fontSize: context.rText(16),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF7B8794),
                            ),
                          ),
                          Divider(height: context.rSpace(25)),
                          const TotalPowerRing(
                            valueText: "5.53",
                            unitText: "kw",
                          ),
                          SizedBox(height: context.rSpace(15)),
                          _SegmentToggle(
                            leftText: "Source",
                            rightText: "Load",
                            isLeftSelected: sourceSelected,
                            onChanged: (v) =>
                                setState(() => sourceSelected = v),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.rSpace(8),
                            ),
                            child: const Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.rSpace(10),
                            ),
                            child: const _ScrollableDataContainer(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.rSpace(10)),
                child: const _BottomMenuGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _ScrollableDataContainer extends StatelessWidget {
  const _ScrollableDataContainer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.rSpace(290),
      child: Scrollbar(
        thumbVisibility: true,
        thickness: context.rSpace(4),
        radius: Radius.circular(context.rSpace(8)),
        child: ListView(
          padding: EdgeInsets.all(context.rSpace(2)),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            _buildCard(context, "assets/dashboard/cell.png", "Data View",
                "Active", const Color(0xFF1F6FEB), const Color(0xFF5AA7FF)),
            SizedBox(height: context.rSpace(8)),
            _buildCard(context, "assets/dashboard/second.png", "Data Type 2",
                "Active", const Color(0xFF1F6FEB), const Color(0xFFFFA63D)),
            SizedBox(height: context.rSpace(8)),
            _buildCard(context, "assets/dashboard/grid..png", "Data Type 3",
                "Inactive", const Color(0xFFD32F2F), const Color(0xFF5AA7FF)),
            SizedBox(height: context.rSpace(8)),
            _buildCard(context, "assets/dashboard/cell.png", "Data View",
                "Active", const Color(0xFF1F6FEB), const Color(0xFF5AA7FF)),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String icon,
      String title,
      String status,
      Color statusColor,
      Color dotColor,
      ) {
    return _DataCard(
      iconPath: icon,
      title: title,
      statusText: status,
      statusColor: statusColor,
      colorDot: dotColor,
      data1: "55505.63",
      data2: "58805.63",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const EnergyDetailPage(title: "Data View"),
          ),
        );
      },
    );
  }
}


class _TopTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TopTabs({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final labels = ["Summery", "SLD", "Data"];

    return Container(
      height: context.rSpace(42),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.rSpace(10)),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final selected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFF1296F3) : null,
                  borderRadius: BorderRadius.circular(context.rSpace(9)),
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: context.rText(14),
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


class _SegmentToggle extends StatelessWidget {
  final String leftText;
  final String rightText;
  final bool isLeftSelected;
  final ValueChanged<bool> onChanged;

  const _SegmentToggle({
    required this.leftText,
    required this.rightText,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rSpace(36)),
      child: Container(
        height: context.rSpace(34),
        decoration: BoxDecoration(
          color: const Color(0xFFE8EEF7),
          borderRadius: BorderRadius.circular(context.rSpace(22)),
          border: Border.all(color: const Color(0xFFD5DEEA)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 180),
              alignment: isLeftSelected
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width:
                MediaQuery.sizeOf(context).width * 0.38 * context.rScale,
                height: context.rSpace(44),
                decoration: BoxDecoration(
                  color: const Color(0xFF1296F3),
                  borderRadius: BorderRadius.circular(context.rSpace(22)),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(true),
                    child: Center(
                      child: Text(
                        leftText,
                        style: TextStyle(
                          fontSize: context.rText(14),
                          fontWeight: FontWeight.w600,
                          color: isLeftSelected
                              ? Colors.white
                              : const Color(0xFF6B7C93),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(false),
                    child: Center(
                      child: Text(
                        rightText,
                        style: TextStyle(
                          fontSize: context.rText(14),
                          fontWeight: FontWeight.w600,
                          color: !isLeftSelected
                              ? Colors.white
                              : const Color(0xFF6B7C93),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _DataCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String statusText;
  final Color statusColor;
  final Color colorDot;
  final String data1;
  final String data2;
  final VoidCallback onTap;

  const _DataCard({
    required this.iconPath,
    required this.title,
    required this.statusText,
    required this.statusColor,
    required this.colorDot,
    required this.data1,
    required this.data2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.rSpace(12)),
      child: Container(
        height: context.rSpace(70),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(context.rSpace(12)),
          border: Border.all(color: const Color(0xFFB9C7D9)),
        ),
        child: Row(
          children: [
            SizedBox(width: context.rSpace(10)),
            SafeAssetIcon(
              path: iconPath,
              size: context.rSpace(24),
              fallbackIcon: Icons.insert_chart_outlined,
            ),
            SizedBox(width: context.rSpace(10)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.rSpace(3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: context.rSpace(14),
                          height: context.rSpace(14),
                          decoration: BoxDecoration(
                            color: colorDot,
                            borderRadius:
                            BorderRadius.circular(context.rSpace(4)),
                          ),
                        ),
                        SizedBox(width: context.rSpace(8)),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: context.rText(14),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: context.rSpace(6)),
                        Text(
                          "($statusText)",
                          style: TextStyle(
                            fontSize: context.rText(10),
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rSpace(4)),
                    _DataRow(label: "Data 1", value: data1),
                    _DataRow(label: "Data 2", value: data2),
                  ],
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: context.rSpace(22)),
            SizedBox(width: context.rSpace(8)),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;

  const _DataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: context.rText(12), color: Colors.grey)),
        SizedBox(width: context.rSpace(6)),
        const Text(":"),
        SizedBox(width: context.rSpace(6)),
        Text(value, style: TextStyle(fontSize: context.rText(12))),
      ],
    );
  }
}


void _openPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

class _BottomMenuGrid extends StatelessWidget {
  const _BottomMenuGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row(context, "analysis.png", "Analysis Pro", "generator.png",
            "G. Generator"),
        SizedBox(height: context.rSpace(7)),
        _row(context, "plant.png", "Plant Summery", "gas.png", "Natural Gas"),
        SizedBox(height: context.rSpace(7)),
        _row(context, "generator.png", "D. Generator", "water.png",
            "Water Process"),
      ],
    );
  }

  Widget _row(
      BuildContext context,
      String i1,
      String l1,
      String i2,
      String l2,
      ) {
    return Row(
      children: [
        Expanded(
          child: _MenuButton(
            iconPath: "assets/dashboard/$i1",
            label: l1,
            onTap: () => _openPage(context, const SldDataPage()),
          ),
        ),
        SizedBox(width: context.rSpace(10)),
        Expanded(
          child: _MenuButton(
            iconPath: "assets/dashboard/$i2",
            label: l2,
            onTap: () => _openPage(context, const SldDataPage()),
          ),
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const _MenuButton({
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.rSpace(14)),
      child: Container(
        height: context.rSpace(43),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.rSpace(14)),
          border: Border.all(color: const Color(0xFFB9C7D9)),
        ),
        child: Row(
          children: [
            SizedBox(width: context.rSpace(10)),
            SafeAssetIcon(
              path: iconPath,
              size: context.rSpace(24),
              fallbackIcon: Icons.widgets,
            ),
            SizedBox(width: context.rSpace(10)),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.rText(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

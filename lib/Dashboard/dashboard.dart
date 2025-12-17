import 'package:flutter/material.dart';
import 'package:taskapp/Dashboard/total_power.dart';

import '../appbar.dart';
import '../energy_detail_page.dart';
import '../safe_assets.dart';

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
              /// 🔹 MAIN SCROLLABLE CONTAINER
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
                          _TopTabs(
                            selectedIndex: topTabIndex,
                            onChanged: (i) =>
                                setState(() => topTabIndex = i),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Electricity",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7B8794),
                            ),
                          ),
                          const Divider(height: 30),
                          const TotalPowerRing(
                            valueText: "5.53",
                            unitText: "kw",
                          ),
                          const SizedBox(height: 15),
                          _SegmentToggle(
                            leftText: "Source",
                            rightText: "Load",
                            isLeftSelected: sourceSelected,
                            onChanged: (v) =>
                                setState(() => sourceSelected = v),
                          ),
                          const SizedBox(height: 14),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: _ScrollableDataContainer(),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔹 BOTTOM MENU (STATIC)
              const Padding(
                padding: EdgeInsets.all(10),
                child: _BottomMenuGrid(),
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
      height: 290, // ✅ shows at least 3 full rows
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB9C7D9)),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 4,
          radius: const Radius.circular(8),
          child: ListView(
            padding: const EdgeInsets.all(8),
            physics: const AlwaysScrollableScrollPhysics(),
            children:  [
              _DataCard(
                iconPath: "assets/dashboard/cell.png",
                title: "Data View",
                statusText: "Active",
                statusColor: Color(0xFF1F6FEB),
                colorDot: Color(0xFF5AA7FF),
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
              ),
              SizedBox(height: 8),
              _DataCard(
                iconPath: "assets/dashboard/second.png",
                title: "Data Type 2",
                statusText: "Active",
                statusColor: Color(0xFF1F6FEB),
                colorDot: Color(0xFFFFA63D),
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
              ),
              SizedBox(height: 8),
              _DataCard(
                iconPath: "assets/dashboard/grid.png",
                title: "Data Type 3",
                statusText: "Inactive",
                statusColor: Color(0xFFD32F2F),
                colorDot: Color(0xFF5AA7FF),
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
              ),
              _DataCard(
                iconPath: "assets/dashboard/cell.png",
                title: "Data View",
                statusText: "Active",
                statusColor: Color(0xFF1F6FEB),
                colorDot: Color(0xFF5AA7FF),
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
              ),
              _DataCard(
                iconPath: "assets/dashboard/cell.png",
                title: "Data View",
                statusText: "Active",
                statusColor: Color(0xFF1F6FEB),
                colorDot: Color(0xFF5AA7FF),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ==================== TOP TABS ====================
class _TopTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TopTabs({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final labels = ["Summery", "SLD", "Data"];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


/// ==================== SOURCE / LOAD TOGGLE ====================
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EEF7),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFD5DEEA)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 180),
              alignment:
              isLeftSelected ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.38,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1296F3),
                  borderRadius: BorderRadius.circular(22),
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
                          fontSize: 18,
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
                          fontSize: 18,
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

/// ==================== DATA CARD ====================
class _DataCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String statusText;
  final Color statusColor;
  final Color colorDot;
  final String data1;
  final String data2;
  final VoidCallback onTap; // 👈 NEW

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
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB9C7D9)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            SafeAssetIcon(
              path: iconPath,
              size: 24,
              fallbackIcon: Icons.insert_chart_outlined,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: colorDot,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "($statusText)",
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _DataRow(label: "Data 1", value: data1),
                    _DataRow(label: "Data 2", value: data2),
                  ],
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
            const SizedBox(width: 8),
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
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(width: 6),
        const Text(":"),
        const SizedBox(width: 6),
        Text(value, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

/// ==================== BOTTOM MENU ====================
class _BottomMenuGrid extends StatelessWidget {
  const _BottomMenuGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/analysis.png",
                label: "Analysis Pro",
                onTap: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AnalysisPage()),
                  );*/
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/generator.png",
                label: "G. Generator",
                onTap: () {
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GeneratorPage()),
                  );*/
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/plant.png",
                label: "Plant Summery",
                onTap: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlantSummaryPage()),
                  );*/
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/gas.png",
                label: "Natural Gas",
                onTap: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GasPage()),
                  );*/
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/generator.png",
                label: "D. Generator",
                /*onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DGeneratorPage()),
                  );
                },*/
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MenuButton(
                iconPath: "assets/dashboard/water.png",
                label: "Water Process",
               /* onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WaterProcessPage()),
                  );
                },*/
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap; // <-- new property

  const _MenuButton({
    required this.iconPath,
    required this.label,
    this.onTap, // <-- constructor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // <-- handle tap
      borderRadius: BorderRadius.circular(14), // ripple effect
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB9C7D9)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            SafeAssetIcon(path: iconPath, size: 24, fallbackIcon: Icons.widgets),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

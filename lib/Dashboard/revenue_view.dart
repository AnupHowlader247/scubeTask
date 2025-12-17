import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../appbar.dart';
import '../energy_detail_page.dart';

class EnergyData {
  final DateTime date;
  final String title;
  final double value;
  final double percentage;
  final double cost;
  final Color color;
  final String type;  // "Income" or "Loss"

  EnergyData({
    required this.date,
    required this.title,
    required this.value,
    required this.percentage,
    required this.cost,
    required this.color,
    required this.type,  // Type field added
  });
}

/* =========================================================
   PAGE
   ========================================================= */

class RevenueViewPage extends StatefulWidget {
  final String title;
  const RevenueViewPage({super.key, required this.title});

  @override
  State<RevenueViewPage> createState() => _RevenueViewPageState();
}

class _RevenueViewPageState extends State<RevenueViewPage> {
  bool isRevenueView = false;
  bool isToday = true;
  DateTime? fromDate;
  DateTime? toDate;
  bool showData = false;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: EnergyMainCard(
          isRevenueView: isRevenueView,
          onSwitchChanged: (v) => setState(() => isRevenueView = v),
          isToday: isToday,
          fromDate: fromDate,
          toDate: toDate,
          showData: showData,
          onCustomDateChanged: (range) {
            setState(() {
              fromDate = range['from'];
              toDate = range['to'];
              showData = false;
            });
          },
          onSearchPressed: () => setState(() => showData = true),
          onTodayDataPressed: () {
            setState(() {
              isToday = true;
              fromDate = null;
              toDate = null;
              showData = false;
            });
          },
          onCustomDataPressed: () {
            setState(() {
              isToday = false;
              showData = false;
            });
          },
        ),
      ),
    );
  }
}

/* =========================================================
   MAIN CARD
   ========================================================= */

class EnergyMainCard extends StatefulWidget {
  final bool isRevenueView;
  final ValueChanged<bool> onSwitchChanged;
  final bool isToday;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool showData;
  final ValueChanged<Map<String, DateTime?>> onCustomDateChanged;
  final VoidCallback onSearchPressed;
  final VoidCallback onTodayDataPressed;
  final VoidCallback onCustomDataPressed;

  const EnergyMainCard({
    super.key,
    required this.isRevenueView,
    required this.onSwitchChanged,
    required this.isToday,
    required this.fromDate,
    required this.toDate,
    required this.showData,
    required this.onCustomDateChanged,
    required this.onSearchPressed,
    required this.onTodayDataPressed,
    required this.onCustomDataPressed,
  });

  @override
  State<EnergyMainCard> createState() => _EnergyMainCardState();
}

class _EnergyMainCardState extends State<EnergyMainCard> {
  final double progressValue = 55;

  /* ---------------- MOCK DATA ---------------- */

  final List<EnergyData> mockIncomeData = [
    EnergyData(
      date: DateTime.now(),
      title: "Income A",
      value: 2798.5,
      percentage: 29.53,
      cost: 35689,
      color: Colors.green,
      type: "Income",
    ),
    EnergyData(
      date: DateTime.now(),
      title: "Income B",
      value: 72598.5,
      percentage: 35.39,
      cost: 5259689,
      color: Colors.green,
      type: "Income",
    ),
  ];

  final List<EnergyData> mockLossData = [
    EnergyData(
      date: DateTime.now(),
      title: "Loss A",
      value: 1500,
      percentage: 18.2,
      cost: 21000,
      color: Colors.red,
      type: "Loss",
    ),
    EnergyData(
      date: DateTime.now(),
      title: "Loss B",
      value: 3000,
      percentage: 25.5,
      cost: 42000,
      color: Colors.red,
      type: "Loss",
    ),
  ];

  bool showIncome = true; // Toggle to show income or loss

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 26),
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFB9C7D9)),
          ),
          child: Column(
            children: [
              SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: progressValue,
                appearance: CircularSliderAppearance(
                  startAngle: 150,
                  angleRange: 240,
                  size: 200,
                  customWidths: CustomSliderWidths(
                    progressBarWidth: 12,
                    trackWidth: 12,
                  ),
                  customColors: CustomSliderColors(
                    progressBarColor: const Color(0xFF1296F3),
                    trackColor: Colors.grey.shade300,
                  ),
                  infoProperties: InfoProperties(
                    modifier: (double value) {
                      return value.toStringAsFixed(2);
                    },
                    mainLabelStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF04063E),
                    ),
                    bottomLabelText: "kWh/Sqft",
                    bottomLabelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildToggleIncomeLoss(),
              const SizedBox(height: 20),
              _buildEnergyCharts(),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: TopSwitch(
            isRevenue: widget.isRevenueView,
            onChanged: widget.onSwitchChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleIncomeLoss() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              showIncome = true; // Show Income data
            });
          },
          child: const Text("Income"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showIncome = false; // Show Loss data
            });
          },
          child: const Text("Loss"),
        ),
      ],
    );
  }

  Widget _buildEnergyCharts() {
    List<EnergyData> dataToShow = showIncome ? mockIncomeData : mockLossData;

    return EnergyRow(energyDataList: dataToShow);
  }
}

/* =========================================================
   ROW + SWITCH (UNCHANGED)
   ========================================================= */



class EnergyRow extends StatefulWidget {
  final List<EnergyData> energyDataList;

  const EnergyRow({super.key, required this.energyDataList});

  @override
  State<EnergyRow> createState() => _EnergyRowState();
}

class _EnergyRowState extends State<EnergyRow> {
  bool _isExpanded = false;  // To control the expansion state

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with up/down icon and the clickable icon
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Row(
            children: [
              const Icon(Icons.graphic_eq, size: 20),  // Fixed icon
              const SizedBox(width: 8),
              const Text(
                "Data & Cost Info",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
        ),
        // Content with the dynamic rows (Data and Cost info)
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),  // Empty widget when collapsed
          secondChild: Column(
            children: [
              for (int i = 0; i < widget.energyDataList.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),  // Adds a gap between rows
                Row(
                  children: [
                    Text(
                      "${widget.energyDataList[i].type} ${i + 1}: ",  // Income or Loss
                      style: const TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${widget.energyDataList[i].value}",
                      style: const TextStyle(
                        color: Color(0xFF04063E),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Cost ${i + 1}: ",
                      style: const TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      " ${widget.energyDataList[i].cost}",
                      style: const TextStyle(
                        color: Color(0xFF04063E),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}


class TopSwitch extends StatelessWidget {
  final bool isRevenue;
  final ValueChanged<bool> onChanged;

  const TopSwitch({super.key, required this.isRevenue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Row(
        children: [
          _item("Data View", !isRevenue, () {
            // When "Data View" is tapped, navigate to the EnergyDetailPage
            onChanged(false);  // Update the state if needed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EnergyDetailPage(title: 'SCM')),
            );
          }),

          _item("Revenue View", isRevenue, () {
            // When "Revenue View" is tapped, navigate to the RevenueViewPage
            onChanged(true);  // Set to true so "Revenue View" stays selected
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RevenueViewPage(title: 'SCM')),
            );
          }),
        ],
      ),
    );
  }

  Widget _item(String t, bool a, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            t,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: a ? Colors.blue : Colors.grey, // Highlight selected text in blue
            ),
          ),
        ),
      ),
    );
  }
}

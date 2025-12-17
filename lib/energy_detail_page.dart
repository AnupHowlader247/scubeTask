import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../appbar.dart';

/* =========================================================
   DATA MODEL
   ========================================================= */

class EnergyData {
  final DateTime date;
  final String title;
  final double value;
  final double percentage;
  final double cost;
  final Color color;

  EnergyData({
    required this.date,
    required this.title,
    required this.value,
    required this.percentage,
    required this.cost,
    required this.color,
  });
}

/* =========================================================
   PAGE
   ========================================================= */

class EnergyDetailPage extends StatefulWidget {
  final String title;
  const EnergyDetailPage({super.key, required this.title});

  @override
  State<EnergyDetailPage> createState() => _EnergyDetailPageState();
}

class _EnergyDetailPageState extends State<EnergyDetailPage> {
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

  final List<EnergyData> mockEnergyData = [
    EnergyData(
      date: DateTime.now(),
      title: "Data A",
      value: 2798.5,
      percentage: 29.53,
      cost: 35689,
      color: Colors.blue,
    ),
    EnergyData(
      date: DateTime.now(),
      title: "Data B",
      value: 72598.5,
      percentage: 35.39,
      cost: 5259689,
      color: Colors.lightBlue,
    ),
    EnergyData(
      date: DateTime.now().subtract(const Duration(days: 1)),
      title: "Data C",
      value: 1500,
      percentage: 18.2,
      cost: 21000,
      color: Colors.green,
    ),
  ];

  /* ---------------- FILTER LOGIC ---------------- */

  List<EnergyData> getFilteredData() {
    final now = DateTime.now();

    if (widget.isToday) {
      return mockEnergyData.where((e) =>
      e.date.year == now.year &&
          e.date.month == now.month &&
          e.date.day == now.day).toList();
    }

    if (widget.fromDate != null && widget.toDate != null) {
      return mockEnergyData.where((e) =>
      !e.date.isBefore(widget.fromDate!) &&
          !e.date.isAfter(widget.toDate!)).toList();
    }

    return [];
  }

  /* ---------------- UI ---------------- */

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
                      return value.toStringAsFixed(2); // 🔥 DOUBLE VALUE ONLY
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

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _radio("Today Data", widget.isToday, widget.onTodayDataPressed),
                  const SizedBox(width: 24),
                  _radio("Custom Date Data", !widget.isToday,
                      widget.onCustomDataPressed),
                ],
              ),
              const SizedBox(height: 20),
              if (!widget.isToday) _buildCustomDatePicker(),
              const SizedBox(height: 20),
              if (widget.isToday || widget.showData) _buildEnergyCharts(),
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

  Widget _radio(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? const Color(0xFF1296F3) : Colors.grey,
              ),
            ),
            child: selected
                ? const Center(
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Color(0xFF1296F3),
              ),
            )
                : null,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected
                  ? const Color(0xFF1296F3) // ACTIVE (BLUE)
                  : Colors.grey,           // INACTIVE
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dateBtn("From Date", () async {
          final d = await showDatePicker(
            context: context,
            initialDate: widget.fromDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          widget.onCustomDateChanged({'from': d, 'to': widget.toDate});
        }),
        _dateBtn("To Date", () async {
          final d = await showDatePicker(
            context: context,
            initialDate: widget.toDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          widget.onCustomDateChanged({'from': widget.fromDate, 'to': d});
        }),
        GestureDetector(
          onTap: widget.onSearchPressed,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: const Icon(Icons.search, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _dateBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Text(label, style: const TextStyle(color: Colors.black26)),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_today, size: 18, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyCharts() {
    final data = getFilteredData();

    if (data.isEmpty) {
      return const Text("No Data Available");
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Column(
        children: data
            .map(
              (e) => EnergyRow(
            title: e.title,
            data: "${e.value} (${e.percentage}%)",
            cost: "${e.cost} ৳",
            color: e.color,
          ),
        )
            .toList(),
      ),
    );
  }
}

/* =========================================================
   ROW + SWITCH (UNCHANGED)
   ========================================================= */



class EnergyRow extends StatelessWidget {
  final String title, data, cost;
  final Color color;

  const EnergyRow(
      {super.key,
        required this.title,
        required this.data,
        required this.cost,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Ensure the row items align center
        children: [
          // Column with the Dot and Title
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Vertically center the dot with the text
            crossAxisAlignment: CrossAxisAlignment.start, // Align dot and title to the left
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: color, // Dot color
                ),
              ),
              SizedBox(height: 5), // Spacing between dot and title
              Text(
                title, // Data A
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          // Vertical Line (Container with height and width)
          Container(
            width: 1,
            height: 50, // Adjust this height to match the row height
            color: Colors.grey.shade400,
          ),
          SizedBox(width: 10),
          // Column for Data and Cost (left-aligned)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Data :     ",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold,fontSize: 12
                  ),),
                  Text("$data",style: TextStyle(color: Color(0xFF04063E),fontWeight: FontWeight.bold,fontSize: 12
                  ),),
                ],
              ),
              Row(
                children: [
                  Text("Cost :    ",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold,fontSize: 12
                  ),),
                  Text(" $cost",style: TextStyle(color: Color(0xFF04063E),fontWeight: FontWeight.bold,fontSize: 12
                  ),),
                ],
              ),
            ],
          ),
        ],
      ),
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
          _item("Data View", !isRevenue, () => onChanged(false)),
          _item("Revenue View", isRevenue, () => onChanged(true)),
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
                color: a ? Colors.blue : Colors.grey),
          ),
        ),
      ),
    );
  }
}

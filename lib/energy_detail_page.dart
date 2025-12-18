import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../appbar.dart';
import '../responsive.dart';

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
        padding: EdgeInsets.symmetric(
          vertical: context.rSpace(16),
        ),
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



  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: context.rSpace(26)),
          padding: EdgeInsets.fromLTRB(
            context.rSpace(16),
            context.rSpace(36),
            context.rSpace(16),
            context.rSpace(16),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.rSpace(18)),

          ),
          child: Column(
            children: [

              if (!widget.isRevenueView)
                SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: progressValue,
                  appearance: CircularSliderAppearance(
                    startAngle: 150,
                    angleRange: 240,
                    size: context.rSpace(200),
                    customWidths: CustomSliderWidths(
                      progressBarWidth: context.rSpace(17),
                      trackWidth: context.rSpace(17),
                    ),
                    customColors: CustomSliderColors(
                      progressBarColor: const Color(0xFF4E91FD),
                      trackColor:
                      const Color(0xFFBDF8FE).withOpacity(0.5),
                    ),
                    infoProperties: InfoProperties(
                      modifier: (double value) {
                        return value.toStringAsFixed(2);
                      },
                      mainLabelStyle: TextStyle(
                        fontSize: context.rText(30),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF04063E),
                      ),
                      bottomLabelText: "kWh/Sqft",
                      bottomLabelStyle: TextStyle(
                        fontSize: context.rText(12),
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),


              if (!widget.isRevenueView) ...[
                SizedBox(height: context.rSpace(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _radio(
                      "Today Data",
                      widget.isToday,
                      widget.onTodayDataPressed,
                    ),
                    SizedBox(width: context.rSpace(24)),
                    _radio(
                      "Custom Date Data",
                      !widget.isToday,
                      widget.onCustomDataPressed,
                    ),
                  ],
                ),
                SizedBox(height: context.rSpace(20)),
                if (!widget.isToday) _buildCustomDatePicker(),
              ],

              SizedBox(height: context.rSpace(20)),


              if (widget.isRevenueView) _buildRevenueView(),
              if (!widget.isRevenueView &&
                  (widget.isToday || widget.showData))
                _buildEnergyCharts(),
              SizedBox(height: 300,),
            ],
          ),
        ),

        Positioned(
          top: 0,
          left: context.rSpace(16),
          right: context.rSpace(16),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Container(
                height: context.rSpace(48),
                margin: EdgeInsets.symmetric(
                  horizontal: context.rSpace(6),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    context.rSpace(10),
                  ),
                ),
              ),

              // 🔹 ACTUAL SWITCH
              TopSwitch(
                isRevenue: widget.isRevenueView,
                onChanged: widget.onSwitchChanged,
              ),
            ],
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
            width: context.rSpace(12),
            height: context.rSpace(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.blue : Colors.grey.shade400,
            ),
          ),
          SizedBox(width: context.rSpace(6)),
          Text(
            title,
            style: TextStyle(
              fontSize: context.rText(14),
              fontWeight: FontWeight.w600,
              color: selected
                  ? const Color(0xFF1296F3)
                  : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDatePicker() {
    return Padding(
      padding: EdgeInsets.only(left: context.rSpace(18)),
      child: Row(
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
          SizedBox(width: context.rSpace(10)),
          _dateBtn("To Date", () async {
            final d = await showDatePicker(
              context: context,
              initialDate: widget.toDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            widget.onCustomDateChanged({'from': widget.fromDate, 'to': d});
          }),
          SizedBox(width: context.rSpace(10)),
          GestureDetector(
            onTap: widget.onSearchPressed,
            child: Container(
              padding: EdgeInsets.all(context.rSpace(7)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.rSpace(8)),
                border: Border.all(color: Colors.blue),
              ),
              child: Icon(
                Icons.search,
                size: context.rSpace(20),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.rSpace(16),
          vertical: context.rSpace(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.rSpace(8)),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black26,
                fontSize: context.rText(14),
              ),
            ),
            SizedBox(width: context.rSpace(8)),
            Icon(
              Icons.calendar_today,
              size: context.rSpace(18),
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyCharts() {
    final data = getFilteredData();

    if (data.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.rSpace(20)),
        child: Text(
          "No Data Available",
          style: TextStyle(fontSize: context.rText(16)),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(context.rSpace(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.rSpace(12)),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rSpace(28)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Energy Chart',
                  style: TextStyle(
                    fontSize: context.rText(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '5.53 kW',
                  style: TextStyle(
                    fontSize: context.rText(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.rSpace(12)),


          ...data.map(
                (e) => EnergyRow(
              title: e.title,
              data: "${e.value} (${e.percentage}%)",
              cost: "${e.cost} ৳",
              color: e.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueView() {
    final scale = context.rScale;

    return Column(
      children: [
        SleekCircularSlider(
          min: 0,
          max: 100000,
          initialValue: 88174, // Mock value
          appearance: CircularSliderAppearance(
            startAngle: 150,
            angleRange: 240,
            size: 200 * scale, // responsive size
            customWidths: CustomSliderWidths(
              progressBarWidth: 17 * scale,
              trackWidth: 17 * scale,
            ),
            customColors: CustomSliderColors(
              progressBarColor: const Color(0xFF4E91FD),
              trackColor: Color(0xFFBDF8FE).withOpacity(0.5),
            ),
            infoProperties: InfoProperties(
              modifier: (double value) => value.toStringAsFixed(2),
              mainLabelStyle: TextStyle(
                fontSize: context.rText(30),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF04063E),
              ),
              bottomLabelText: "tk",
              bottomLabelStyle: TextStyle(
                fontSize: context.rText(16),
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: context.rSpace(20)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12 * scale),

          ),
          child: Column(
            children: [
              _revenueRow("Data 1", "2798.50", "35689 ৳"),
            ],
          ),
        ),
      ],
    );
  }
  Widget _revenueRow(String title, String data, String cost) {
    bool isExpanded = true;

    return StatefulBuilder(
      builder: (context, setState) {
        final scale = context.rScale;

        return Stack(
          clipBehavior: Clip.none,
          children: [

            if (isExpanded)
              Container(
                margin: EdgeInsets.only(top: context.rSpace(30)),
                padding: EdgeInsets.fromLTRB(
                    context.rSpace(16), context.rSpace(70), context.rSpace(16), context.rSpace(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.rSpace(10)),
                  border: Border.all(color: Colors.black26, width: 1.2 * scale),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dataCostRow("1", data, cost),
                    _dataCostRow("2", data, cost),
                    _dataCostRow("3", data, cost),
                    _dataCostRow("4", data, cost),
                  ],
                ),
              ),


            Positioned(
              top: context.rSpace(31),
              left: context.rSpace(1),
              right: context.rSpace(1),
              child: Container(
                height: context.rSpace(60),
                padding: EdgeInsets.symmetric(horizontal: context.rSpace(12)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.rSpace(8)),
                  border: Border.all(color: Colors.black26, width: 1.2 * scale),
                ),
                child: Row(
                  children: [
                    Icon(Icons.bar_chart, color: Colors.black26, size: context.rSpace(20)),
                    SizedBox(width: context.rSpace(10)),
                    Text(
                      "Data & Cost Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.rText(14),
                      ),
                    ),
                    Spacer(),


                    CircleAvatar(
                      radius: context.rSpace(16),
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        iconSize: context.rSpace(18),
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_double_arrow_up
                              : Icons.keyboard_double_arrow_down,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _dataCostRow(String number, String data, String cost) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rSpace(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Text(
                "Data $number: $data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.rText(14),
                ),
              ),
              SizedBox(width: context.rSpace(4)),
              Text(
                "($data%)",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: context.rText(12),
                ),
              ),
            ],
          ),

          SizedBox(height: context.rSpace(2)),


          Row(
            children: [
              Text(
                "Cost $number: $cost",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.rText(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



class EnergyRow extends StatelessWidget {
  final String title, data, cost;
  final Color color;

  const EnergyRow({
    super.key,
    required this.title,
    required this.data,
    required this.cost,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.rSpace(3)),
      padding: EdgeInsets.fromLTRB(
        context.rSpace(10),
        context.rSpace(4),
        context.rSpace(10),
        context.rSpace(4),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.rSpace(10)),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: context.rSpace(12)),
                child: CircleAvatar(
                  radius: context.rSpace(5),
                  backgroundColor: color,
                ),
              ),
              SizedBox(height: context.rSpace(5)),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.rText(14),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: context.rSpace(10)),

          Container(
            width: context.rSpace(1),
            height: context.rSpace(30),
            color: Colors.grey.shade400,
          ),
          SizedBox(width: context.rSpace(10)),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Data    :  ",
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                      fontSize: context.rText(12),
                    ),
                  ),
                  Text(
                    "$data",
                    style: TextStyle(
                      color: const Color(0xFF04063E),
                      fontWeight: FontWeight.bold,
                      fontSize: context.rText(12),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Cost    :",
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                      fontSize: context.rText(12),
                    ),
                  ),
                  Text(
                    " $cost",
                    style: TextStyle(
                      color: const Color(0xFF04063E),
                      fontWeight: FontWeight.bold,
                      fontSize: context.rText(12),
                    ),
                  ),
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
      height: context.rSpace(44),
      padding: EdgeInsets.all(context.rSpace(2)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.rSpace(10)),
        border: Border.all(color: const Color(0xFFB9C7D9)),
      ),
      child: Row(
        children: [
          _item(context, "Data View", !isRevenue, () => onChanged(false)),
          _item(context, "Revenue View", isRevenue, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String t, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: context.rSpace(14),
              height: context.rSpace(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: active ? const Color(0xFF1296F3) : Colors.grey,
                  width: context.rSpace(1),
                ),
              ),
              child: active
                  ? Center(
                child: CircleAvatar(
                  radius: context.rSpace(3),
                  backgroundColor: const Color(0xFF1296F3),
                ),
              )
                  : null,
            ),
            SizedBox(width: context.rSpace(8)),


            Text(
              t,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: context.rText(14),
                color: active ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

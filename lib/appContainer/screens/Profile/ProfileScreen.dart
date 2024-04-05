import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:timepomodoro/appContainer/widgets/ItemProfile/ItemProfile.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int count = 0;
  int totalBreaks = 0;
  int totalTimeFocus = 0;
  int nowTimeFocus = 0;
  int totalFocused = 0;
  int totalFocusedNow = 0;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getTotalTimeFocused();
    getTotalData();
    getTotalFocus();
    getTotalTimeFocused();
    getFocusNow();
    getTimeFocusNow();
    super.initState();
  }

  void getTotalData() async {
    print('Estoy sacando info');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String now = dateFormatter.format(DateTime.now());
    int? getValuesFocusedTimes =
        sharedPreferences.getInt('${now}_focused_times');
    int tmpCountFocusedTimes = (getValuesFocusedTimes ?? 0) + 1;

    sharedPreferences.setInt('${now}_focused_times', tmpCountFocusedTimes);
    setState(() {
      totalBreaks = sharedPreferences.getInt('breaks')!;
    });
  }

  void getTotalTimeFocused() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      totalFocused = sharedPreferences.getInt('totalFocused')!;
    });
  }

  void getTotalFocus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      totalTimeFocus = sharedPreferences.getInt('totalFocus')!;
    });
  }

  void getFocusNow() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String now = dateFormatter.format(DateTime.now());
    int getNowTimeFocusedNow =
        sharedPreferences.getInt('${now}_focused_times') ?? 0;

    setState(() {
      totalFocusedNow = sharedPreferences.getInt('${now}_focused_times')!;
    });
  }

  void getTimeFocusNow() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String now = dateFormatter.format(DateTime.now());

    print('$now: ${sharedPreferences.getInt(now)}');

    setState(() {
      nowTimeFocus = sharedPreferences.getInt(now)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget BigCircle = Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
          color: Colors.orangeAccent, shape: BoxShape.circle),
    );

    Widget Separator = Container(
      padding: const EdgeInsets.all(10),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Center(
            child: Text('Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
          Separator,
          Material(
            child: Center(
              child: Stack(
                children: <Widget>[
                  BigCircle,
                  const Positioned(
                    top: 30,
                    left: 30,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text('P',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Separator,
          const Center(
            child: Text('juangamartinez_98@hotmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
          ),
          Separator,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ItemProfile(
                totalBreaks: false,
                minutes: '$nowTimeFocus',
                totalMinutes: '${totalFocusedNow ~/ 60}',
                buttonText: 'Today Focus',
                bgColor: Colors.orange.shade50,
                width: 0.10,
              ),
              ItemProfile(
                totalBreaks: false,
                minutes: '$totalFocused',
                totalMinutes: '${totalTimeFocus ~/ 60}',
                buttonText: 'All Focus',
                bgColor: Colors.white,
                width: 0.10,
              )
            ],
          ),
          Separator,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ItemProfile(
                  minutes: '$totalBreaks',
                  totalBreaks: true,
                  buttonText: 'Total Breaks',
                  bgColor: Colors.white,
                  width: 0.24)
            ],
          )
        ],
      ),
    );
  }
}

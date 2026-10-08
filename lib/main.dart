import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TexconDriverApp());
}

// ============================================================
// [SECTION 1: THEME & COLOR CONFIGURATION]
// ============================================================
class TexconColors {
  static const Color blue = Color(0xFF0057A8);
  static const Color darkBlue = Color(0xFF003B73);
  static const Color lightBlue = Color(0xFFEAF3FB);
  static const Color lightGreenCard = Color(0xFFE8F5E9);
  static const Color lightOrangeCard = Color(0xFFFFF3E0);
  static const Color background = Color(0xFFF4F6F8);
  static const Color green = Color(0xFF16803C);
  static const Color red = Color(0xFFC62828);
  static const Color orange = Color(0xFFEF8A17);
  static const Color darkText = Color(0xFF17202A);
  static const Color grayText = Color(0xFF667085);
}

class TexconDriverApp extends StatelessWidget {
  const TexconDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Texcon Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: TexconColors.blue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: TexconColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: TexconColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const MainDriverScreen(),
    );
  }
}

// ============================================================
// [SECTION 2: DATA MODELS & DIRECTORIES]
// ============================================================
const List<Map<String, String>> gCodeList = [
  {'code': 'Pugmill', 'label': 'Pugmill'},
  {'code': 'G999', 'label': 'G999'},
  {'code': 'Outside Sale', 'label': 'Outside Sale'},
  {'code': 'Other', 'label': 'Other Activity'},
  {'code': 'G1193', 'label': 'Texcon Project'},
  {'code': 'G1200', 'label': 'Sample Job B'},
];

const List<String> otherOptionsList = [
  'Tire Shop',
  'Main Office',
  'Rush',
  'Loan star',
  'Performance',
  'Custom Entry...',
];

const List<String> standardTaskCodes = [
  'Pug – Yard Work / Sand',
  'Outside Sale',
  '300 – Storm Sewer',
  '400 – Sanitary Sewer',
  '500 – Water Line',
  '800 – Base',
  '900 – Asphalt',
];

const List<String> otherTaskCodes = [
  'GL',
  '1900',
];

const List<String> tmoListOptions = [
  'Other',
  'Time Charge - Time Out of Local Area - Price - Per-Ton',
  'TMO09 - Asphalt Millings',
  'TMO11 - Grade 3, 4, or 5 Stone - Limestone',
  'TMO19 - Cement Stabilized Sand ( 5% )',
  'TMO27 - Cement Stabilized Sand ( 6% ) - 1 1/2 Sack',
  'TMO30 - Washed Pea Gravel',
  'TMO40 - Standard Flex Base ( A-Base )',
  'TMO42 - State Approved Base - Grade 1 ( S-Base )',
  'TMO43 - Cement Stabilized Base',
  'TMO46 - Reclaim Base',
  'TMO49 - Special Mix ( Miscellaneous )',
  'TMO50 - 3" x 5" Limestone Rock ( Hard Stone )',
  'TMO51 - 1" Washed Limestone',
  'TMO53 - 1" x 12" Hard Stone',
  'TMO56 - 18" x 24" Rip Rap',
  'TMO57 - 12" x 18" Rip Rap',
  'TMO58 - 6" x 8" Rip Rap',
  'TMO59 - General Fill ( SNS )',
  'TMO60 - Select Fill ( SNS )',
  'TMO61 - Fill Sand ( SNS )',
  'TMO62 - Topsoil ( SNS )',
  'TMO63 - 0" - 1" Slag',
  'TMO64 - 1" - 2" Slag',
  'TMO65 - 2" - 4" Slag',
  'TMO68 - Iron Ore Rock',
  'TMO70 - 1" Washed River Rock',
  'TMO83 - 2" River Rock',
  'TMO84 - 3" - 4" River Rock',
  'Flat Rate - Price Per Load',
  'Per Hour Rate - Per-Hour Charge Time',
  'Haul Off - Haul Off',
  'Per Ton Rate - TexCon - Outside Work Per-Ton',
];

const List<String> delayReasons = [
  'Waiting to Load',
  'Waiting to Unload',
  'Traffic Delay',
  'Railroad Train',
  'Accident',
  'Scale Backed Up',
  'Loader Breakdown',
  'Mechanical Issue',
  'Other',
];

final List<Map<String, String>> driverPhoneList = [
  {'name': 'Driver: John Doe', 'number': '555-0101'},
  {'name': 'Driver: Mike Smith', 'number': '555-0102'},
  {'name': 'Driver: Carlos R.', 'number': '555-0103'},
  {'name': 'Driver: Alex B.', 'number': '555-0104'},
];

final List<Map<String, String>> fieldPhoneList = [
  {'name': 'Dispatch Central', 'number': '555-0200'},
  {'name': 'Pugmill Operator', 'number': '555-0201'},
  {'name': 'Site Foreman - G1193', 'number': '555-0202'},
  {'name': 'Safety Manager', 'number': '555-0203'},
];

enum LogEntryType { preTrip, postTrip, equipmentSwap, loadTrip, standaloneActivity }

class DailyLogEntry {
  final LogEntryType type;
  final DateTime startTime;
  DateTime? endTime;
  String equipmentInfo;
  String? startingMileage;
  String? endingMileage;
  String details;
  LoadTrip? loadTripData;
  TripActivity? standaloneActivity;

  DailyLogEntry({
    required this.type,
    required this.startTime,
    this.endTime,
    required this.equipmentInfo,
    this.startingMileage,
    this.endingMileage,
    this.details = '',
    this.loadTripData,
    this.standaloneActivity,
  });
}

class TripActivity {
  final String title;
  final DateTime startTime;
  DateTime? endTime;
  String notes;

  TripActivity({
    required this.title,
    required this.startTime,
    this.endTime,
    this.notes = '',
  });

  Duration get duration => (endTime ?? DateTime.now()).difference(startTime);
}

class LoadTrip {
  final int id;
  String gCode;
  String jobName;
  String taskCode;
  String material;
  String fromLocation;
  String pitName;
  String toLocation;
  String poNumber;
  String otherReason;
  String notes;
  final DateTime startTime;
  DateTime? endTime;
  bool isCompleted;
  bool lunchTaken;
  Duration totalLunchDuration;

  // Track Pugmill Material workflow status
  bool isPugmillMaterial;
  DateTime? arrivedAtPitTime;
  DateTime? scaledOutTime;

  final List<TripActivity> activities;

  LoadTrip({
    required this.id,
    required this.gCode,
    required this.jobName,
    required this.taskCode,
    required this.material,
    required this.fromLocation,
    this.pitName = '',
    required this.toLocation,
    this.poNumber = '',
    this.otherReason = '',
    this.notes = '',
    required this.startTime,
    this.endTime,
    this.isCompleted = false,
    this.lunchTaken = false,
    this.totalLunchDuration = Duration.zero,
    this.isPugmillMaterial = false,
    this.arrivedAtPitTime,
    this.scaledOutTime,
    List<TripActivity>? activities,
  }) : activities = activities ?? [TripActivity(title: 'Load Started', startTime: startTime, endTime: startTime)];

  Duration get duration => (endTime ?? DateTime.now()).difference(startTime);
  bool get isAsphaltTask => taskCode.toLowerCase().contains('asphalt');

  String get routeDisplay {
    if (isPugmillMaterial) {
      final pitInfo = pitName.isNotEmpty ? ' - $pitName (Pugmill)' : ' (Pugmill)';
      return '$fromLocation$pitInfo ➔ $toLocation';
    }
    return '$fromLocation ➔ $gCode - $toLocation';
  }
}

class GeofenceServicePlaceholder {
  static void initializeGeofence() {}
  static void checkLocationAndPromptMap(BuildContext context, String locationName) {
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.map, color: TexconColors.blue),
            const SizedBox(width: 8),
            Expanded(child: Text('Location Actions: $locationName')),
          ],
        ),
        content: Text('Select an option for $locationName:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(d);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Displaying info for $locationName')),
              );
            },
            child: const Text('View Location Info'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(d);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening Navigation Maps for $locationName...')),
              );
            },
            icon: const Icon(Icons.navigation, size: 16),
            label: const Text('Get Directions'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// [SECTION 3: UTILITIES]
// ============================================================
String formatTime(DateTime d) {
  final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final m = d.minute.toString().padLeft(2, '0');
  final s = d.second.toString().padLeft(2, '0');
  return '$h:$m:$s ${d.hour < 12 ? 'AM' : 'PM'}';
}

String formatDuration(Duration d) {
  final hours = d.inHours.toString().padLeft(2, '0');
  final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}

String formatHoursWorked(Duration d) {
  final hours = d.inHours;
  final mins = d.inMinutes % 60;
  return '${hours}h ${mins}m';
}

// ============================================================
// [SECTION 4: MAIN DRIVER SCREEN STATE]
// ============================================================
class MainDriverScreen extends StatefulWidget {
  const MainDriverScreen({super.key});

  @override
  State<MainDriverScreen> createState() => _MainDriverScreenState();
}

class _MainDriverScreenState extends State<MainDriverScreen> {
  int currentTabIndex = 0;
  bool isClockedIn = false;
  DateTime? clockInTime;
  bool isPreTripInProgress = false;
  bool isPreTripCompleted = false;
  DateTime? preTripStartTime;
  bool isPostTripInProgress = false;
  bool isPostTripCompleted = false;
  DateTime? postTripStartTime;
  String currentTruck = '245';
  String currentTrailer = '781';
  LoadTrip? activeLoad;
  TripActivity? activeTimedEvent;
  bool isLunchInProgress = false;
  bool isLunchTakenToday = false;
  DateTime? lunchStartTime;
  Duration totalLunchDurationToday = Duration.zero;
  final List<DailyLogEntry> chronologicalLog = [];
  DateTime selectedDate = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    GeofenceServicePlaceholder.initializeGeofence();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool get hasAsphaltLoadToday {
    if (activeLoad != null && activeLoad!.isAsphaltTask) return true;
    return chronologicalLog.any((entry) => entry.loadTripData != null && entry.loadTripData!.isAsphaltTask);
  }

  Duration get grossShiftDuration {
    if (clockInTime == null) return Duration.zero;
    return DateTime.now().difference(clockInTime!);
  }

  Duration get calculatedLunchDeduction {
    if (hasAsphaltLoadToday) return Duration.zero;
    if (isLunchTakenToday) {
      return totalLunchDurationToday < const Duration(minutes: 30)
          ? const Duration(minutes: 30)
          : totalLunchDurationToday;
    }
    return const Duration(minutes: 30);
  }

  Duration get netPaidShiftDuration {
    final gross = grossShiftDuration;
    final deduction = calculatedLunchDeduction;
    if (deduction >= gross) return Duration.zero;
    return gross - deduction;
  }

  Future<String?> askText(String title, {String? initialValue, bool isNumber = false, String? hintText}) {
    final c = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: c,
          autofocus: true,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(hintText: hintText),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, c.text.trim()), child: const Text('OK')),
        ],
      ),
    );
  }

  Future<String?> chooseOption(String title, List<String> options) {
    return showDialog<String>(
      context: context,
      builder: (d) => SimpleDialog(
        title: Text(title),
        children: [
          for (final o in options)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(d, o),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(o, style: const TextStyle(fontSize: 16)),
              ),
            )
        ],
      ),
    );
  }

  Future<void> changeTruckOrTrailer() async {
    final truckController = TextEditingController(text: currentTruck);
    final trailerController = TextEditingController(text: currentTrailer);
    final endingMilesController = TextEditingController();
    final startingMilesController = TextEditingController();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Change Truck / Trailer'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Complete Post-Trip for current equipment and Pre-Trip for new equipment.',
                style: TextStyle(fontSize: 12, color: TexconColors.grayText),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: endingMilesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Current Truck Ending Mileage', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: truckController,
                decoration: const InputDecoration(labelText: 'New Truck #', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: trailerController,
                decoration: const InputDecoration(labelText: 'New Trailer #', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: startingMilesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'New Truck Beginning Mileage', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Confirm Swap')),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    final now = DateTime.now();
    final newTruckVal = truckController.text.trim();
    final newTrailerVal = trailerController.text.trim();
    final swapText = 'Swapped to Truck #$newTruckVal | Trailer #$newTrailerVal';

    setState(() {
      currentTruck = newTruckVal;
      currentTrailer = newTrailerVal;
      if (activeLoad != null) {
        activeLoad!.activities.add(
          TripActivity(
            title: 'Equipment Swap',
            startTime: now,
            endTime: now,
            notes: '$swapText (End Miles: ${endingMilesController.text.trim()}, Start Miles: ${startingMilesController.text.trim()})',
          ),
        );
      } else {
        chronologicalLog.add(DailyLogEntry(
          type: LogEntryType.equipmentSwap,
          startTime: now,
          endTime: now,
          equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
          endingMileage: endingMilesController.text.trim(),
          details: 'Post-Trip for Equipment Swap',
        ));
        chronologicalLog.add(DailyLogEntry(
          type: LogEntryType.equipmentSwap,
          startTime: now,
          endTime: now,
          equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
          startingMileage: startingMilesController.text.trim(),
          details: 'Pre-Trip for New Equipment',
        ));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched to Truck #$currentTruck | Trailer #$currentTrailer')),
    );
  }

  Future<void> handlePreTripToggle() async {
    if (!isPreTripInProgress) {
      setState(() {
        isPreTripInProgress = true;
        preTripStartTime = DateTime.now();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pre-Trip Inspection Started.')));
    } else {
      final miles = await askText('Enter Beginning Mileage', isNumber: true);
      if (!mounted || miles == null || miles.isEmpty) return;

      final now = DateTime.now();
      final preTripLog = DailyLogEntry(
        type: LogEntryType.preTrip,
        startTime: preTripStartTime ?? now,
        endTime: now,
        equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
        startingMileage: miles,
        details: 'Initial Pre-Trip Inspection',
      );

      setState(() {
        isPreTripInProgress = false;
        isPreTripCompleted = true;
        chronologicalLog.add(preTripLog);
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pre-Trip Completed & Logged.')));
    }
  }

  Future<void> handlePostTripToggle() async {
    if (activeLoad != null || activeTimedEvent != null || isLunchInProgress) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete active loads, delays, or breaks before starting Post-Trip.')),
      );
      return;
    }

    if (!isPostTripInProgress) {
      setState(() {
        isPostTripInProgress = true;
        postTripStartTime = DateTime.now();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post-Trip Inspection Started.')));
    } else {
      final miles = await askText('Enter Ending Mileage', isNumber: true);
      if (!mounted || miles == null || miles.isEmpty) return;

      final now = DateTime.now();
      final postTripLog = DailyLogEntry(
        type: LogEntryType.postTrip,
        startTime: postTripStartTime ?? now,
        endTime: now,
        equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
        endingMileage: miles,
        details: 'End of Shift Post-Trip Inspection',
      );

      setState(() {
        isPostTripInProgress = false;
        isPostTripCompleted = true;
        isClockedIn = false;
        chronologicalLog.add(postTripLog);
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post-Trip Completed. Shift finished!')));
    }
  }

  void showPhoneDirectory(String title, List<Map<String, String>> contacts) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (b) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone, color: TexconColors.blue),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (c, i) => ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: TexconColors.lightBlue,
                    child: Icon(Icons.person, color: TexconColors.blue),
                  ),
                  title: Text(contacts[i]['name']!),
                  subtitle: Text(contacts[i]['number']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone, color: TexconColors.green),
                    onPressed: () {
                      Navigator.pop(b);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dialing ${contacts[i]['name']} (${contacts[i]['number']})...')),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startNewLoad() async {
    if (activeTimedEvent != null || isLunchInProgress) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please end active Delay, Break, or Lunch before starting a load.')),
      );
      return;
    }

    final gOptions = gCodeList.map((item) {
      return item['code'] == 'G999' ? 'G999' : '${item['code']} - ${item['label']}';
    }).toList();

    final selectedG = await chooseOption('Select G-Code', gOptions);
    if (!mounted || selectedG == null) return;

    final code = selectedG.contains(' - ') ? selectedG.split(' - ').first : selectedG.trim();
    String jobName = '';
    String poNumber = '';
    String otherReason = '';
    String task = '';
    String material = '';
    String from = '';
    String pitName = '';
    String to = '';
    bool isPugMaterial = false;

    if (code == 'G999') {
      final inputJob = await askText('Enter Job Name for G999', hintText: 'Job Name');
      if (!mounted || inputJob == null || inputJob.isEmpty) return;
      jobName = inputJob;

      final poInput = await askText('Enter PO Number', hintText: 'PO Number');
      if (poInput != null) poNumber = poInput;

      final selectedMaterial = await chooseOption('Select Material (TMO)', tmoListOptions);
      if (!mounted || selectedMaterial == null) return;
      if (selectedMaterial == 'Other') {
        final customMat = await askText('Enter Material / TMO');
        if (!mounted || customMat == null || customMat.isEmpty) return;
        material = customMat;
      } else {
        material = selectedMaterial;
      }

      final startLoc = await askText('Enter Starting Location');
      if (!mounted || startLoc == null || startLoc.isEmpty) return;
      from = startLoc;

      final custLoc = await askText('Enter Customer Location');
      if (!mounted || custLoc == null || custLoc.isEmpty) return;
      to = custLoc;
      task = 'Custom Job';
    } else if (code == 'Pugmill') {
      jobName = 'Pugmill Operations';
      final pugType = await chooseOption('Select Pugmill Type', ['Onsite', 'Material']);
      if (!mounted || pugType == null) return;

      if (pugType == 'Material') {
        isPugMaterial = true;
        task = 'Inbound Material';

        // 1. Select TMO Number
        final selectedMaterial = await chooseOption('Select TMO Number', tmoListOptions);
        if (!mounted || selectedMaterial == null) return;
        if (selectedMaterial == 'Other') {
          final customMat = await askText('Enter TMO Number or Material');
          if (!mounted || customMat == null || customMat.isEmpty) return;
          material = customMat;
        } else {
          material = selectedMaterial;
        }

        // 2. PO Number
        final poInput = await askText('Enter PO Number', hintText: 'PO Number');
        if (poInput != null) poNumber = poInput;

        // 3. Starting Location
        final startChoice = await chooseOption('Starting Location', ['Yard', 'Quarry', 'Plant', 'Other']);
        if (!mounted || startChoice == null) return;
        if (startChoice == 'Other') {
          final customStart = await askText('Enter Starting Location Name');
          if (!mounted || customStart == null || customStart.isEmpty) return;
          from = customStart;
        } else {
          from = startChoice;
        }

        // 4. Pit Name
        final pitInput = await askText('Enter Pit Name', hintText: 'Pit Name');
        if (pitInput != null && pitInput.isNotEmpty) pitName = pitInput;

        to = 'Pugmill';
      } else {
        final onsiteChoice = await chooseOption('Select Onsite Task', ['Sand', 'Move Material']);
        if (!mounted || onsiteChoice == null) return;
        task = onsiteChoice;
        material = onsiteChoice;
        from = 'Pugmill';
        to = 'Pugmill';
      }
    } else if (code == 'Outside Sale') {
      final inputJob = await askText('Enter Job Name', hintText: 'Job Name');
      if (!mounted || inputJob == null || inputJob.isEmpty) return;
      jobName = inputJob;

      final selectedTmo = await chooseOption('Select TMO', tmoListOptions);
      if (!mounted || selectedTmo == null) return;
      if (selectedTmo == 'Other') {
        final customTmo = await askText('Enter TMO Number / Description');
        if (!mounted || customTmo == null || customTmo.isEmpty) return;
        material = customTmo;
      } else {
        material = selectedTmo;
      }

      task = 'Outside Sale';
      final poInput = await askText('Enter PO Number (Optional)', hintText: 'Leave blank if unavailable');
      if (poInput != null) poNumber = poInput;

      final startChoice = await chooseOption('Starting Location', ['Pugmill', 'Quarry', 'Yard', 'Other']);
      if (!mounted || startChoice == null) return;
      if (startChoice == 'Other') {
        final customStart = await askText('Enter Starting Location');
        if (!mounted || customStart == null || customStart.isEmpty) return;
        from = customStart;
      } else {
        from = startChoice;
      }

      final deliveryType = await chooseOption('Delivery Location', ['Customer Site']);
      if (!mounted || deliveryType == null) return;
      final customDelivery = await askText('Enter Customer Site Address / Location Name');
      if (!mounted || customDelivery == null || customDelivery.isEmpty) return;
      to = customDelivery;
    } else if (code == 'Other') {
      final selectedOther = await chooseOption('Select Other Activity', otherOptionsList);
      if (!mounted || selectedOther == null) return;

      if (selectedOther == 'Custom Entry...') {
        final typed = await askText('Enter Activity Details');
        if (typed != null && typed.isNotEmpty) otherReason = typed;
      } else {
        otherReason = selectedOther;
      }

      jobName = 'Other: $otherReason';
      final selectedOtherTask = await chooseOption('Select Task Code', otherTaskCodes);
      if (!mounted || selectedOtherTask == null) return;
      task = selectedOtherTask;

      final poInput = await askText('Enter PO Number (Optional)', hintText: 'Leave blank if unavailable');
      if (poInput != null) poNumber = poInput;

      final matInput = await askText('Material Name');
      if (!mounted || matInput == null || matInput.isEmpty) return;
      material = matInput;

      final startChoice = await chooseOption('Starting Location', ['Pugmill', 'Quarry', 'Yard', 'Other']);
      if (!mounted || startChoice == null) return;
      if (startChoice == 'Other') {
        final customStart = await askText('Enter Starting Location');
        if (!mounted || customStart == null || customStart.isEmpty) return;
        from = customStart;
      } else {
        from = startChoice;
      }

      final endChoice = await chooseOption('Delivery Location', ['Yard', 'Plant', 'Customer Site', 'Other']);
      if (!mounted || endChoice == null) return;
      if (endChoice == 'Other') {
        final customEnd = await askText('Enter Delivery Location');
        if (!mounted || customEnd == null || customEnd.isEmpty) return;
        to = customEnd;
      } else {
        to = endChoice;
      }
    } else {
      // Standard G-Code logic (e.g., G1193, G1200)
      final matchedItem = gCodeList.firstWhere((e) => e['code'] == code, orElse: () => {'code': code, 'label': code});
      jobName = matchedItem['label']!;

      final selectedTask = await chooseOption('Select Task Code', standardTaskCodes);
      if (!mounted || selectedTask == null) return;
      task = selectedTask;

      final matInput = await askText('Material Name (e.g., Flex Base, Sand)');
      if (!mounted || matInput == null || matInput.isEmpty) return;
      material = matInput;

      final startChoice = await chooseOption('Starting Location', ['Pugmill', 'Quarry', 'Yard', 'Other']);
      if (!mounted || startChoice == null) return;
      if (startChoice == 'Other') {
        final customStart = await askText('Enter Starting Location');
        if (!mounted || customStart == null || customStart.isEmpty) return;
        from = customStart;
      } else {
        from = startChoice;
      }

      // Bypass Delivery Location prompt for codes starting with 'G'
      if (code.toUpperCase().startsWith('G')) {
        to = jobName;
      } else {
        final endChoice = await chooseOption('Delivery Location', ['Yard', 'Plant', 'Customer Site', 'Other']);
        if (!mounted || endChoice == null) return;
        if (endChoice == 'Other') {
          final customEnd = await askText('Enter Delivery Location');
          if (!mounted || customEnd == null || customEnd.isEmpty) return;
          to = customEnd;
        } else {
          to = endChoice;
        }
      }
    }

    final now = DateTime.now();
    final loadCount = chronologicalLog.where((e) => e.type == LogEntryType.loadTrip).length + 1;
    final newTrip = LoadTrip(
      id: loadCount,
      gCode: code,
      jobName: jobName,
      taskCode: task,
      material: material,
      fromLocation: from,
      pitName: pitName,
      toLocation: to,
      poNumber: poNumber,
      otherReason: otherReason,
      startTime: now,
      isPugmillMaterial: isPugMaterial,
    );

    final logEntry = DailyLogEntry(
      type: LogEntryType.loadTrip,
      startTime: now,
      equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
      loadTripData: newTrip,
    );

    setState(() {
      activeLoad = newTrip;
      chronologicalLog.add(logEntry);
    });
  }

  void markArrivedAtPit() {
    if (activeLoad == null) return;
    final now = DateTime.now();
    setState(() {
      activeLoad!.arrivedAtPitTime = now;
      activeLoad!.activities.add(TripActivity(
        title: 'Arrived at Pit',
        startTime: now,
        endTime: now,
        notes: activeLoad!.pitName.isNotEmpty ? 'Pit: ${activeLoad!.pitName}' : '',
      ));
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Arrived at Pit logged.')));
  }

  void markScaledOut() {
    if (activeLoad == null) return;
    final now = DateTime.now();
    setState(() {
      activeLoad!.scaledOutTime = now;
      activeLoad!.activities.add(TripActivity(
        title: 'Scaled Out',
        startTime: now,
        endTime: now,
      ));
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Scaled Out logged.')));
  }

  void completeActiveLoad() {
    if (activeLoad == null || activeTimedEvent != null || isLunchInProgress) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please end active Delay, Break, or Lunch before completing load.')),
      );
      return;
    }

    final now = DateTime.now();
    setState(() {
      activeLoad!.endTime = now;
      activeLoad!.isCompleted = true;
      activeLoad!.activities.add(TripActivity(title: 'Load Completed', startTime: now, endTime: now));
      activeLoad = null;
    });
  }

  Future<void> handleLoadDelay() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Add Load Delay?'),
        content: const Text('Would you like to start a load delay log?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Yes, Start Delay')),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    final reason = await chooseOption('Select Delay Reason', delayReasons);
    if (!mounted || reason == null) return;

    String note = reason;
    if (reason == 'Other') {
      final extraOther = await askText('Enter Delay Reason');
      if (extraOther != null && extraOther.isNotEmpty) note = extraOther;
    } else {
      final extra = await askText('Additional Details (Optional)');
      if (extra != null && extra.isNotEmpty) note = '$note - $extra';
    }

    startTimedEvent('Load Delay', note);
  }

  Future<void> handleBreak() async {
    final c = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Start Break'),
        content: TextField(
          controller: c,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Reason for Break (Optional)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, null), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, c.text.trim()), child: const Text('Start Break')),
        ],
      ),
    );

    if (note == null || !mounted) return;
    startTimedEvent('Break', note);
  }

  void startTimedEvent(String type, String note) {
    final event = TripActivity(
      title: type,
      startTime: DateTime.now(),
      notes: note,
    );

    setState(() {
      activeTimedEvent = event;
      if (activeLoad != null) {
        activeLoad!.activities.add(event);
      } else {
        chronologicalLog.add(DailyLogEntry(
          type: LogEntryType.standaloneActivity,
          startTime: event.startTime,
          equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
          standaloneActivity: event,
        ));
      }
    });
  }

  void endTimedEvent() {
    if (activeTimedEvent == null) return;
    final now = DateTime.now();
    setState(() {
      activeTimedEvent!.endTime = now;
      activeTimedEvent = null;
    });
  }

  Future<void> handleLunchToggle() async {
    final now = DateTime.now();

    if (!isLunchInProgress) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Start Lunch?'),
          content: const Text('Are you sure you want to start your lunch break?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Yes, Start Lunch')),
          ],
        ),
      );

      if (confirm != true) return;

      final lunchActivity = TripActivity(title: 'Lunch Break', startTime: now);

      setState(() {
        isLunchInProgress = true;
        lunchStartTime = now;
        if (activeLoad != null) {
          activeLoad!.lunchTaken = true;
          activeLoad!.activities.add(lunchActivity);
        } else {
          chronologicalLog.add(DailyLogEntry(
            type: LogEntryType.standaloneActivity,
            startTime: now,
            equipmentInfo: 'Truck #$currentTruck | Trailer #$currentTrailer',
            standaloneActivity: lunchActivity,
          ));
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lunch Break Started.')));
    } else {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Finished with Lunch?'),
          content: const Text('Are you sure you are finished with your lunch break?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Yes, Finish Lunch')),
          ],
        ),
      );

      if (confirm != true) return;

      TripActivity? lunchActivity;
      if (activeLoad != null) {
        lunchActivity = activeLoad!.activities.firstWhere((a) => a.title == 'Lunch Break' && a.endTime == null);
      } else {
        final entry = chronologicalLog.firstWhere(
            (e) => e.type == LogEntryType.standaloneActivity && e.standaloneActivity?.title == 'Lunch Break' && e.standaloneActivity?.endTime == null);
        lunchActivity = entry.standaloneActivity;
      }

      if (lunchActivity != null) {
        lunchActivity.endTime = now;
        final duration = lunchActivity.duration;

        setState(() {
          isLunchInProgress = false;
          isLunchTakenToday = true;
          totalLunchDurationToday += duration;
          if (activeLoad != null) {
            activeLoad!.totalLunchDuration += duration;
          }
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lunch Break Ended & Logged.')));
    }
  }

  Future<void> editTripField(LoadTrip trip) async {
    final fields = [
      'Truck / Trailer #',
      'G-Code',
      'Task Code',
      'Material',
      'Pick-Up Location',
      if (trip.isPugmillMaterial) 'Pit Name',
      if (!trip.gCode.toUpperCase().startsWith('G')) 'Delivery Location',
      'PO Number',
      'Notes',
    ];

    final fieldToEdit = await chooseOption('Select Field to Edit', fields);
    if (!mounted || fieldToEdit == null) return;

    switch (fieldToEdit) {
      case 'Truck / Trailer #':
        final t = await askText('Truck Number', initialValue: currentTruck);
        if (t != null && t.isNotEmpty) setState(() => currentTruck = t);
        final tr = await askText('Trailer Number', initialValue: currentTrailer);
        if (tr != null && tr.isNotEmpty) setState(() => currentTrailer = tr);
        break;
      case 'G-Code':
        final gOptions = gCodeList.map((item) => item['code'] == 'G999' ? 'G999' : '${item['code']} - ${item['label']}').toList();
        final g = await chooseOption('Select New G-Code', gOptions);
        if (g != null) {
          final code = g.contains(' - ') ? g.split(' - ').first : g.trim();
          setState(() {
            trip.gCode = code;
            final match = gCodeList.firstWhere((e) => e['code'] == code, orElse: () => {'label': code});
            trip.jobName = match['label']!;
            if (code.toUpperCase().startsWith('G')) {
              trip.toLocation = trip.jobName;
            }
          });
        }
        break;
      case 'Task Code':
        if (trip.gCode == 'Other') {
          final task = await chooseOption('Select New Task Code', otherTaskCodes);
          if (task != null) setState(() => trip.taskCode = task);
        } else if (trip.gCode == 'Outside Sale') {
          final task = await chooseOption('Select TMO / Rate', tmoListOptions);
          if (task != null) {
            if (task == 'Other') {
              final custom = await askText('Enter TMO Number or Material');
              if (custom != null && custom.isNotEmpty) setState(() => trip.taskCode = custom);
            } else {
              setState(() => trip.taskCode = task);
            }
          }
        } else {
          final task = await chooseOption('Select New Task Code', standardTaskCodes);
          if (task != null) setState(() => trip.taskCode = task);
        }
        break;
      case 'Material':
        final mat = await askText('Enter Material Name', initialValue: trip.material);
        if (mat != null && mat.isNotEmpty) setState(() => trip.material = mat);
        break;
      case 'Pick-Up Location':
        final loc = await chooseOption('Select Pick-Up Location', ['Pugmill', 'Quarry', 'Yard', 'Other']);
        if (loc != null) {
          if (loc == 'Other') {
            final custom = await askText('Enter Pick-Up Location');
            if (custom != null && custom.isNotEmpty) setState(() => trip.fromLocation = custom);
          } else {
            setState(() => trip.fromLocation = loc);
          }
        }
        break;
      case 'Pit Name':
        final pit = await askText('Enter Pit Name', initialValue: trip.pitName);
        if (pit != null) setState(() => trip.pitName = pit);
        break;
      case 'Delivery Location':
        final loc = await chooseOption('Select Delivery Location', ['Yard', 'Plant', 'Customer Site', 'Other']);
        if (loc != null) {
          if (loc == 'Other' || loc == 'Customer Site') {
            final custom = await askText('Enter Delivery Location');
            if (custom != null && custom.isNotEmpty) setState(() => trip.toLocation = custom);
          } else {
            setState(() => trip.toLocation = loc);
          }
        }
        break;
      case 'PO Number':
        final po = await askText('Enter PO Number', initialValue: trip.poNumber);
        if (po != null) setState(() => trip.poNumber = po);
        break;
      case 'Notes':
        final n = await askText('Enter Notes', initialValue: trip.notes);
        if (n != null) setState(() => trip.notes = n);
        break;
    }
  }

  // ============================================================
  // [SECTION 5: DASHBOARD & LOG VIEWS]
  // ============================================================
  Widget buildActiveDashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SHIFT STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: TexconColors.grayText)),
                    Text(
                      !isClockedIn
                          ? 'Clocked Out'
                          : (isPostTripInProgress
                              ? 'Post-Trip in Progress'
                              : (isPreTripInProgress
                                  ? 'Pre-Trip in Progress'
                                  : (isPreTripCompleted ? 'Pre-Trip Done' : 'Pre-Trip Pending'))),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: !isClockedIn ? TexconColors.red : (isPreTripCompleted ? TexconColors.green : TexconColors.orange),
                      ),
                    ),
                  ],
                ),
                Text('Truck #$currentTruck | Trailer #$currentTrailer', style: const TextStyle(fontWeight: FontWeight.bold, color: TexconColors.darkBlue)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (!isClockedIn)
          FilledButton.icon(
            onPressed: () => setState(() {
              isClockedIn = true;
              clockInTime = DateTime.now();
            }),
            style: FilledButton.styleFrom(backgroundColor: TexconColors.green, minimumSize: const Size.fromHeight(50)),
            icon: const Icon(Icons.play_arrow),
            label: const Text('CLOCK IN FOR SHIFT', style: TextStyle(fontWeight: FontWeight.bold)),
          )
        else if (!isPreTripCompleted)
          FilledButton.icon(
            onPressed: handlePreTripToggle,
            style: FilledButton.styleFrom(
              backgroundColor: isPreTripInProgress ? TexconColors.orange : TexconColors.blue,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: Icon(isPreTripInProgress ? Icons.check_circle_outline : Icons.assignment_turned_in),
            label: Text(
              isPreTripInProgress ? 'END PRE-TRIP (Enter Mileage)' : 'START PRE-TRIP',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        else ...[
          const Text('Action Controls', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: activeTimedEvent?.title == 'Load Delay'
                    ? FilledButton.icon(
                        onPressed: endTimedEvent,
                        style: FilledButton.styleFrom(backgroundColor: TexconColors.red, padding: const EdgeInsets.symmetric(vertical: 12)),
                        icon: const Icon(Icons.stop_circle_outlined, size: 18),
                        label: Text('END DELAY (${formatDuration(activeTimedEvent!.duration)})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      )
                    : OutlinedButton.icon(
                        onPressed: (activeTimedEvent != null || isLunchInProgress) ? null : handleLoadDelay,
                        icon: const Icon(Icons.warning_amber, color: TexconColors.orange, size: 18),
                        label: const Text('LOAD DELAY', style: TextStyle(fontSize: 12)),
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: activeTimedEvent?.title == 'Break'
                    ? FilledButton.icon(
                        onPressed: endTimedEvent,
                        style: FilledButton.styleFrom(backgroundColor: TexconColors.red, padding: const EdgeInsets.symmetric(vertical: 12)),
                        icon: const Icon(Icons.stop_circle_outlined, size: 18),
                        label: Text('END BREAK (${formatDuration(activeTimedEvent!.duration)})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      )
                    : OutlinedButton.icon(
                        onPressed: (activeTimedEvent != null || isLunchInProgress) ? null : handleBreak,
                        icon: const Icon(Icons.free_breakfast, color: TexconColors.blue, size: 18),
                        label: const Text('BREAK', style: TextStyle(fontSize: 12)),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: isLunchInProgress
                    ? FilledButton.icon(
                        onPressed: handleLunchToggle,
                        style: FilledButton.styleFrom(backgroundColor: TexconColors.red, padding: const EdgeInsets.symmetric(vertical: 12)),
                        icon: const Icon(Icons.restaurant_menu, size: 18),
                        label: Text('END LUNCH (${formatDuration(DateTime.now().difference(lunchStartTime!))})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      )
                    : OutlinedButton.icon(
                        onPressed: (activeTimedEvent != null || isLunchTakenToday) ? null : handleLunchToggle,
                        icon: const Icon(Icons.restaurant, color: TexconColors.darkBlue, size: 18),
                        label: Text(isLunchTakenToday ? 'LUNCH DONE' : 'START LUNCH', style: const TextStyle(fontSize: 12)),
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: isPostTripInProgress
                    ? FilledButton.icon(
                        onPressed: handlePostTripToggle,
                        style: FilledButton.styleFrom(backgroundColor: TexconColors.orange, padding: const EdgeInsets.symmetric(vertical: 12)),
                        icon: const Icon(Icons.check_circle_outline, size: 18),
                        label: const Text('FINISH POST-TRIP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      )
                    : OutlinedButton.icon(
                        onPressed: (activeLoad != null || activeTimedEvent != null || isLunchInProgress) ? null : handlePostTripToggle,
                        icon: const Icon(Icons.assignment_return, color: TexconColors.red, size: 18),
                        label: const Text('POST-TRIP', style: TextStyle(fontSize: 12)),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: changeTruckOrTrailer,
            icon: const Icon(Icons.swap_horiz, color: TexconColors.orange, size: 18),
            label: const Text('CHANGE TRUCK / TRAILER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              side: const BorderSide(color: TexconColors.orange),
            ),
          ),
          const SizedBox(height: 16),
          if (activeLoad != null) ...[
            const Text('Active Trip in Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LoadCard(
              trip: activeLoad!,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TripDetailScreen(trip: activeLoad!, onTripUpdated: () => setState(() {}))),
              ),
              onEdit: () => editTripField(activeLoad!),
            ),
            const SizedBox(height: 12),
            if (activeLoad!.isPugmillMaterial) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: activeLoad!.arrivedAtPitTime != null ? null : markArrivedAtPit,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: activeLoad!.arrivedAtPitTime != null ? Colors.grey : TexconColors.blue),
                      ),
                      icon: Icon(Icons.location_on, color: activeLoad!.arrivedAtPitTime != null ? Colors.grey : TexconColors.blue, size: 16),
                      label: Text(
                        activeLoad!.arrivedAtPitTime != null ? 'PIT ARRIVED' : 'ARRIVED AT PIT',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: activeLoad!.scaledOutTime != null ? null : markScaledOut,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: activeLoad!.scaledOutTime != null ? Colors.grey : TexconColors.orange),
                      ),
                      icon: Icon(Icons.scale, color: activeLoad!.scaledOutTime != null ? Colors.grey : TexconColors.orange, size: 16),
                      label: Text(
                        activeLoad!.scaledOutTime != null ? 'SCALED OUT' : 'SCALE OUT',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            FilledButton.icon(
              onPressed: (activeTimedEvent != null || isLunchInProgress) ? null : completeActiveLoad,
              icon: const Icon(Icons.check_circle),
              label: const Text('COMPLETE LOAD', style: TextStyle(fontWeight: FontWeight.bold)),
              style: FilledButton.styleFrom(backgroundColor: TexconColors.green, minimumSize: const Size.fromHeight(50)),
            ),
          ] else ...[
            Card(
              color: TexconColors.lightBlue,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.local_shipping, size: 48, color: TexconColors.blue),
                    SizedBox(height: 8),
                    Text('No Active Load', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TexconColors.darkBlue)),
                    Text('Tap below to start your next load.', style: TextStyle(color: TexconColors.grayText)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: startNewLoad,
              style: FilledButton.styleFrom(backgroundColor: TexconColors.blue, minimumSize: const Size.fromHeight(52)),
              icon: const Icon(Icons.add_location_alt),
              label: const Text('START NEW LOAD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => showPhoneDirectory('Driver Phone Directory', driverPhoneList),
                  icon: const Icon(Icons.phone, color: TexconColors.blue, size: 18),
                  label: const Text('Driver Phone Numbers', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => showPhoneDirectory('Field Phone Directory', fieldPhoneList),
                  icon: const Icon(Icons.phone, color: TexconColors.darkBlue, size: 18),
                  label: const Text('Field Phone Numbers', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget buildDailyHistoryTab() {
    final completedLoadsCount = chronologicalLog.where((e) => e.type == LogEntryType.loadTrip && e.loadTripData != null && e.loadTripData!.isCompleted).length;

    return Column(
      children: [
        Container(
          height: 56,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              final date = DateTime.now().subtract(Duration(days: index));
              final isSelected = date.day == selectedDate.day && date.month == selectedDate.month;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: ChoiceChip(
                  label: Text('${date.month}/${date.day}'),
                  selected: isSelected,
                  selectedColor: TexconColors.blue,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  onSelected: (_) => setState(() => selectedDate = date),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Container(
          color: TexconColors.lightBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('GROSS SHIFT HOURS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: TexconColors.grayText)),
                      Text(
                        isClockedIn ? formatHoursWorked(grossShiftDuration) : '0h 0m',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: TexconColors.darkText),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('NET PAID HOURS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: TexconColors.grayText)),
                      Text(
                        isClockedIn ? formatHoursWorked(netPaidShiftDuration) : '0h 0m',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: TexconColors.blue),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hasAsphaltLoadToday
                        ? '• Asphalt Exemption: 0m Deducted'
                        : (isLunchTakenToday
                            ? '• Lunch Taken: -${calculatedLunchDeduction.inMinutes}m Deducted'
                            : '• No Lunch Taken: -30m Auto-Deducted'),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: hasAsphaltLoadToday
                          ? TexconColors.blue
                          : (isLunchTakenToday ? TexconColors.green : TexconColors.red),
                    ),
                  ),
                  Text(
                    '$completedLoadsCount Loads Completed',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: TexconColors.grayText),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: chronologicalLog.isEmpty
              ? const Center(child: Text('No shift activity recorded for this day.', style: TextStyle(color: TexconColors.grayText)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chronologicalLog.length,
                  itemBuilder: (context, index) {
                    final log = chronologicalLog[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildLogCard(log),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget buildLogCard(DailyLogEntry log) {
    switch (log.type) {
      case LogEntryType.preTrip:
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: const Icon(Icons.assignment_turned_in, color: TexconColors.green),
            title: Text('Pre-Trip – ${log.equipmentInfo}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Start: ${formatTime(log.startTime)}  ➔  End: ${log.endTime != null ? formatTime(log.endTime!) : 'In Progress'}\n'
              '${log.startingMileage != null ? 'Beginning Mileage: ${log.startingMileage} mi' : 'Mileage: N/A'}',
            ),
          ),
        );
      case LogEntryType.postTrip:
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: const Icon(Icons.assignment_return, color: TexconColors.red),
            title: Text('Post-Trip – ${log.equipmentInfo}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Start: ${formatTime(log.startTime)}  ➔  End: ${log.endTime != null ? formatTime(log.endTime!) : 'In Progress'}\n'
              '${log.endingMileage != null ? 'Ending Mileage: ${log.endingMileage} mi' : 'Mileage: N/A'}',
            ),
          ),
        );
      case LogEntryType.equipmentSwap:
        return Card(
          color: TexconColors.lightOrangeCard,
          child: ListTile(
            leading: const Icon(Icons.swap_horiz, color: TexconColors.orange),
            title: Text(log.details, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Equipment: ${log.equipmentInfo}\nTime: ${formatTime(log.startTime)}\n'
              '${log.startingMileage != null ? 'Beginning Mileage: ${log.startingMileage} mi' : ''}'
              '${log.endingMileage != null ? 'Ending Mileage: ${log.endingMileage} mi' : ''}',
            ),
          ),
        );
      case LogEntryType.standaloneActivity:
        final act = log.standaloneActivity!;
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              act.title == 'Lunch Break' ? Icons.restaurant : Icons.free_breakfast,
              color: act.title == 'Lunch Break' ? TexconColors.darkBlue : TexconColors.blue,
            ),
            title: Text('${act.title} (Between Loads)', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Start: ${formatTime(act.startTime)} ${act.endTime != null ? '➔ End: ${formatTime(act.endTime!)} (${formatDuration(act.duration)})' : '(In Progress...)'}',
            ),
          ),
        );
      case LogEntryType.loadTrip:
        final trip = log.loadTripData!;
        return LoadCard(
          trip: trip,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TripDetailScreen(trip: trip, onTripUpdated: () => setState(() {}))),
          ),
          onEdit: () => editTripField(trip),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEXCON DISPATCH', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      ),
      body: currentTabIndex == 0 ? buildActiveDashboard() : buildDailyHistoryTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        selectedItemColor: TexconColors.blue,
        onTap: (i) => setState(() => currentTabIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Active Load'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Daily Logs (20 Days)'),
        ],
      ),
    );
  }
}

// ============================================================
// [SECTION 6: LOAD CARD]
// ============================================================
class LoadCard extends StatelessWidget {
  final LoadTrip trip;
  final VoidCallback onTap;
  final VoidCallback? onEdit;

  const LoadCard({
    super.key,
    required this.trip,
    required this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final int lunchMins = trip.totalLunchDuration.inMinutes;

    return Card(
      color: trip.isCompleted ? TexconColors.lightGreenCard : TexconColors.lightOrangeCard,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      alignment: WrapAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: trip.isCompleted ? TexconColors.green.withOpacity(0.15) : TexconColors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'LOAD #${trip.id}  •  ${trip.gCode}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: trip.isCompleted ? TexconColors.green : TexconColors.orange,
                            ),
                          ),
                        ),
                        if (trip.isCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: TexconColors.green, borderRadius: BorderRadius.circular(6)),
                            child: const Text('FINISHED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: TexconColors.orange, borderRadius: BorderRadius.circular(6)),
                            child: const Text('IN PROGRESS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        if (trip.poNumber.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: TexconColors.darkBlue, borderRadius: BorderRadius.circular(6)),
                            child: Text('PO: ${trip.poNumber}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        if (trip.lunchTaken)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: TexconColors.darkBlue, borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.restaurant, color: Colors.white, size: 10),
                                const SizedBox(width: 4),
                                Text(
                                  'LUNCH TAKEN${lunchMins > 0 ? ' (${lunchMins}m)' : ''}',
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        formatDuration(trip.duration),
                        style: const TextStyle(fontFamily: 'Monospace', fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(Icons.edit_note, size: 22, color: TexconColors.blue),
                          tooltip: 'Edit Job Field',
                          onPressed: onEdit,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(trip.jobName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('${trip.taskCode}  |  Mat: ${trip.material}', style: const TextStyle(color: TexconColors.grayText, fontSize: 13)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 15, color: TexconColors.grayText),
                  const SizedBox(width: 4),
                  Text(
                    'Start: ${formatTime(trip.startTime)}${trip.endTime != null ? '  ➔  End: ${formatTime(trip.endTime!)}' : ''}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: TexconColors.darkText),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () => GeofenceServicePlaceholder.checkLocationAndPromptMap(context, trip.routeDisplay),
                child: Row(
                  children: [
                    const Icon(Icons.map, size: 18, color: TexconColors.blue),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        trip.routeDisplay,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: TexconColors.blue, decoration: TextDecoration.underline),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// [SECTION 7: DETAILED TRIP ACTIVITY LOG SHEET]
// ============================================================
class TripDetailScreen extends StatefulWidget {
  final LoadTrip trip;
  final VoidCallback onTripUpdated;

  const TripDetailScreen({super.key, required this.trip, required this.onTripUpdated});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  Future<void> editActivityNote(TripActivity act) async {
    final c = TextEditingController(text: act.notes);
    final note = await showDialog<String>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('Edit Note for ${act.title}'),
        content: TextField(controller: c, maxLines: 3, decoration: const InputDecoration(hintText: 'Enter delay reason or notes...')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, c.text.trim()), child: const Text('Save Note')),
        ],
      ),
    );

    if (!mounted || note == null) return;
    setState(() => act.notes = note);
    widget.onTripUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load #${widget.trip.id} Detail Sheet'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: widget.trip.isCompleted ? TexconColors.lightGreenCard : TexconColors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.trip.gCode} - ${widget.trip.jobName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: TexconColors.darkBlue)),
                  const SizedBox(height: 4),
                  Text('Task: ${widget.trip.taskCode}  |  Material: ${widget.trip.material}'),
                  Text('Route: ${widget.trip.routeDisplay}'),
                  if (widget.trip.poNumber.isNotEmpty) Text('PO #: ${widget.trip.poNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (widget.trip.notes.isNotEmpty) Text('Notes: ${widget.trip.notes}', style: const TextStyle(fontStyle: FontStyle.italic)),
                  const Divider(height: 16),
                  Text('Start Time: ${formatTime(widget.trip.startTime)}'),
                  if (widget.trip.arrivedAtPitTime != null) Text('Arrived at Pit: ${formatTime(widget.trip.arrivedAtPitTime!)}'),
                  if (widget.trip.scaledOutTime != null) Text('Scaled Out: ${formatTime(widget.trip.scaledOutTime!)}'),
                  if (widget.trip.endTime != null) Text('Completion Time: ${formatTime(widget.trip.endTime!)}'),
                  Text('Total Elapsed: ${formatDuration(widget.trip.duration)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (widget.trip.lunchTaken)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Lunch Taken During Load: ${widget.trip.totalLunchDuration.inMinutes} mins', style: const TextStyle(color: TexconColors.darkBlue, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Chronological Load Event Log', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (final act in widget.trip.activities)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: act.title == 'Equipment Swap' ? TexconColors.lightOrangeCard : Colors.white,
              child: ListTile(
                leading: act.title == 'Equipment Swap'
                    ? const Icon(Icons.swap_horiz, color: TexconColors.orange)
                    : Icon(
                        act.title == 'Lunch Break' ? Icons.restaurant : Icons.access_time,
                        color: TexconColors.blue,
                      ),
                title: Text(act.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start: ${formatTime(act.startTime)} ${act.endTime != null && act.title != 'Equipment Swap' && act.title != 'Arrived at Pit' && act.title != 'Scaled Out' ? '➔ End: ${formatTime(act.endTime!)} (${formatDuration(act.duration)})' : ''}',
                      style: const TextStyle(fontSize: 12, color: TexconColors.grayText),
                    ),
                    if (act.notes.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          act.title == 'Equipment Swap' ? act.notes : 'Reason/Notes: ${act.notes}',
                          style: const TextStyle(color: TexconColors.darkBlue, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                trailing: act.title != 'Load Started' && act.title != 'Load Completed' && act.title != 'Equipment Swap'
                    ? IconButton(
                        icon: const Icon(Icons.edit_note, color: TexconColors.blue),
                        onPressed: () => editActivityNote(act),
                      )
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}
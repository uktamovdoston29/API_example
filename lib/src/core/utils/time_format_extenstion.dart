// * dart
// * user defined | build in function

// * extension malum bir class qoshimcha qoshish | build in function

extension TimeFormatExtenstion on num {
  String formatTime() {
    final duration = Duration(seconds: toInt());
    final int minutes = duration.inMinutes;
    final int seconds = toInt() % 60; // Calculate remaining seconds

    // Use padLeft to ensure two digits for minutes and seconds
    final String minutesString = '$minutes'.padLeft(2, '0');
    final String secondsString = '$seconds'.padLeft(2, '0');

    return '$minutesString:$secondsString'; // Returns in "MM:SS" format
  }
}

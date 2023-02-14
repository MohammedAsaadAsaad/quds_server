part of quds_server;

abstract class CliCommand {
  String get prefix;
  Future<void> execute(ArgResults args);

  void printColored(
    Object msg, {
    int r = 0,
    int g = 0,
    int b = 0,
    bool bg = false,
  }) {
    AnsiPen pen = AnsiPen();
    pen.rgb(r: r, g: g, b: b, bg: bg);
    pen(
      msg,
    );
  }

  void printRed(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.red(bg: bg, bold: bold);
    pen(msg);
  }

  void printWhite(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.white(bg: bg, bold: bold);
    pen(msg);
  }

  void printBlue(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.blue(bg: bg, bold: bold);
    pen(msg);
  }

  void printBlack(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.black(bg: bg, bold: bold);
    pen(msg);
  }

  void printGreen(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.green(bg: bg, bold: bold);
    pen(msg);
  }

  void printYellow(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.yellow(bg: bg, bold: bold);
    pen(msg);
  }

  void printMagenta(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.magenta(bg: bg, bold: bold);
    pen(msg);
  }

  void printCyan(Object msg, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.cyan(bg: bg, bold: bold);
    pen(msg);
  }
}

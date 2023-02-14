part of quds_server;

abstract class CliCommand {
  String get prefix;
  Future<void> execute(ArgResults args);

  void printColored(
    String text, {
    int r = 0,
    int g = 0,
    int b = 0,
    bool bg = false,
  }) {
    AnsiPen pen = AnsiPen();
    pen.rgb(r: r, g: g, b: b, bg: bg);
    pen(
      text,
    );
  }

  void printRed(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.red(bg: bg, bold: bold);
    pen(text);
  }

  void printWhite(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.white(bg: bg, bold: bold);
    pen(text);
  }

  void printBlue(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.blue(bg: bg, bold: bold);
    pen(text);
  }

  void printBlack(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.black(bg: bg, bold: bold);
    pen(text);
  }

  void printGreen(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.green(bg: bg, bold: bold);
    pen(text);
  }

  void printYellow(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.yellow(bg: bg, bold: bold);
    pen(text);
  }

  void printMagenta(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.magenta(bg: bg, bold: bold);
    pen(text);
  }

  void printCyan(String text, {bool bg = false, bool bold = false}) {
    AnsiPen pen = AnsiPen();
    pen.cyan(bg: bg, bold: bold);
    pen(text);
  }
}

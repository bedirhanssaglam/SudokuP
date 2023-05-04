extension ImageExtensions on String {
  String get toPng => "assets/images/$this.png";
  String get toSvg => "assets/icons/$this.svg";
}

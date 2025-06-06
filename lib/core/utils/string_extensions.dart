///
/// String extension
///
extension StringHelper on String? {

  ///
  /// null이 아니고 비어있지 않으면 true
  ///
  /// test;               False
  /// test = "";          False
  /// test = "flutter";   True
  ///
  bool get isNotNullOrEmpty => this?.isNotEmpty == true;

  ///
  /// null이거나 비어있으면 true
  ///
  /// test;               True
  /// test = "";          True
  /// test = "flutter";   False
  ///
  // bool get isNullOrEmpty => this?.isEmpty != false;
}

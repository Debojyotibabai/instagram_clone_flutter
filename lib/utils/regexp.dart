final RegExp letterOnlyRegex = RegExp(r'^[a-zA-Z]+$');
final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
final RegExp passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
final RegExp min10Max100Regex = RegExp(r'^.{10,100}$');

import "package:unicode/unicode.dart" as unicode;
import "package:unittest/unittest.dart";

void main() {
  testCharacterSets();
  testIsXXX();
  testSimpleCasing();
  testToCase();
  testUnassigned();
}

void testCharacterSets() {
  //
  var subject = "uppercaseLetterCharacters";
  var character = 65; // A
  var result = unicode.uppercaseLetterCharacters[character];
  expect(result, true, reason: subject);
}

void testIsXXX() {
  //
  var subject = "isUppercaseLetter";
  var character = 65; // A
  var result = unicode.isUppercaseLetter(character);
  expect(result, true, reason: subject);
  //
  subject = "isUppercaseLetter";
  character = unicode.toRune("Я"); // Я
  result = unicode.isUppercaseLetter(character);
  expect(result, true, reason: subject);
  //
  subject = "isLowercaseLetter";
  character = 97; // a
  result = unicode.isLowercaseLetter(character);
  expect(result, true, reason: subject);
  //
  subject = "isLowercaseLetter";
  character = unicode.toRune("я"); // я
  result = unicode.isLowercaseLetter(character);
  expect(result, true, reason: subject);
}

void testSimpleCasing() {
  //
  var subject = "simpleLowercaseMapping";
  var character = unicode.toRune("Я");
  var result = unicode.simpleLowercaseMapping[character];
  expect(result, unicode.toRune("я"), reason: subject);
  //
  subject = "simpleUppercaseMapping";
  character = unicode.toRune("я");
  result = unicode.simpleUppercaseMapping[character];
  result = unicode.simpleUppercaseMapping[character];
  expect(result, unicode.toRune("Я"), reason: subject);
  //
  subject = "simpleTitlecaseMapping";
  character = unicode.toRune("я");
  result = unicode.simpleTitlecaseMapping[character];
  result = unicode.simpleTitlecaseMapping[character];
  expect(result, unicode.toRune("Я"), reason: subject);
}

void testToCase() {
  //
  var subject = "toLowercase";
  var string = "Привет, Андрей!";
  var result = unicode.toLowercase(string);
  expect(result, "привет, андрей!", reason: subject);
  //
  subject = "toUppercase";
  string = "Привет, Андрей!";
  result = unicode.toUppercase(string);
  expect(result, "ПРИВЕТ, АНДРЕЙ!", reason: subject);
  //
  subject = "toTitlecase";
  string = "Привет, Андрей!";
  result = unicode.toTitlecase(string);
  expect(result, "ПРИВЕТ, АНДРЕЙ!", reason: subject);
  // Performance
  var count = 1000000;
  string = "Привет, Андрей!";
  measure("String.toUpperCase()", () {
    for (var i = 0; i < count; i++) {
      var result = string.toUpperCase();
    }
  });

  measure("unicode.toUppercase(string)", () {
    for (var i = 0; i < count; i++) {
      var result = unicode.toLowercase(string);
    }
  });
}

void testUnassigned() {
  // Unassigned
  var subject = "generalCategories";
  var result = unicode.generalCategories[0x378];
  expect(result, 0, reason: subject);
}

void measure(String msg, f()) {
  var sw = new Stopwatch();
  sw.start();
  f();
  sw.stop();
  var time = sw.elapsedMicroseconds / 1000000;
  print("$msg: $time sec");
}

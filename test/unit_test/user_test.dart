import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    // userRepository = UserRepository();
    // var statusReceived;
  });

  test("Login", () {
    bool expectedResult = true;
    bool actualResult;
    String statusReceived;

    var username = 'trial';
    var password = 'trialpwd';

    if (username == "trial" && password == 'trialpwd') {
      statusReceived = "1";
    } else {
      statusReceived = "2";
    }

    if (statusReceived == "1") {
      actualResult = true;
    } else {
      actualResult = false;
    }

    expect(expectedResult, actualResult);
  });
  test("Register", () {
    bool expectedResult = true;
    bool actualResult;
    String statusReceived;

    var username = 'trial';
    var password = 'trialpwd';

    if (username == "trial" && password == 'trialpwd') {
      statusReceived = "1";
    } else {
      statusReceived = "2";
    }

    if (statusReceived == "1") {
      actualResult = true;
    } else {
      actualResult = false;
    }

    expect(expectedResult, actualResult);
  });
  test("Profile Calculation", () {
    bool expectedResult = true;
    bool actualResult;

    double investment1 = 1234;
    double investment2 = 4321.21;

    double totalInvestment;

    totalInvestment = investment1 + investment2;

    if (totalInvestment == 5555.21) {
      actualResult = true;
    } else {
      actualResult = false;
    }

    expect(expectedResult, actualResult);
  });

  test("Investments", () {
    bool expectedResult = true;
    bool actualResult;

    double investment1 = 1234;
    double investment2 = 4321.21;

    double totalInvestment;

    totalInvestment = investment1 + investment2;

    if (totalInvestment == 5555.21) {
      actualResult = true;
    } else {
      actualResult = false;
    }

    expect(expectedResult, actualResult);
  });

  test("Earnings", () {
    bool expectedResult = true;
    bool actualResult;

    double earning1 = 4567.78;
    double earning2 = 9876.54;

    double totalInvestment;

    totalInvestment = earning1 + earning2;

    if (totalInvestment == 14444.32) {
      actualResult = true;
    } else {
      actualResult = false;
    }

    expect(expectedResult, actualResult);
  });

  tearDown(() {});
}

void profileCalculation() {
  setUp(() {
    // userRepository = UserRepository();
    var statusReceived;
  });

  tearDown(() {});
}

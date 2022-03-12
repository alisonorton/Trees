import 'dart:io';
import 'package:stack/stack.dart';

/***********************************************
* Solving RPN String Equation
***********************************************/
void exampleEquation() {
  String exampleEquation = "6 6 * 2 7 * - 2 /";
  var exampleArray = new List();
  num exampleResult;

  exampleArray = exampleEquation.split(" ");

  exampleResult = calculateTotal(exampleArray);
  stdout.write("Input: $exampleEquation\n");
  stdout.write("Result: $exampleResult\n\n");
}

/***********************************************
* Displaying the file input and results
***********************************************/
void display(String input, num result) {
  print("Input: ${input}");
  print("Result: ${result}\n");
}

/***********************************************
* Checking if file content is a number
***********************************************/
bool isNum(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null || double.tryParse(s) != null;
}

/***********************************************
* Calculating results for RPN equations
***********************************************/
num calculateTotal(List equation) {
  Stack<num> stack = Stack<num>();
  num total;

  for (int i = 0; i < equation.length; i++) {
    //Checking for numbers
    if (isNum(equation[i])) {
      stack.push(num.parse(equation[i]));
    }
    //Checking for operators
    else if (equation[i] == "+" ||
        equation[i] == "-" ||
        equation[i] == "*" ||
        equation[i] == "/") {
      //Poping top two items off the stack
      num num1 = stack.pop();
      num num2 = stack.pop();

      //performing operations and pushing
      //the total onto the stack
      if (equation[i] == "*") {
        num total = num1 * num2;
        stack.push(total);
      }

      if (equation[i] == "-") {
        num total = num2 - num1;
        stack.push(total);
      }

      if (equation[i] == "+") {
        num total = num1 + num2;
        stack.push(total);
      }
      if (equation[i] == "/") {
        num total;
        //Trying to account for double division
        if (num is double) {
          total = num2 / num1;
          stack.push(total);
        } else {
          total = num2 ~/ num1;
          stack.push(total);
        }
      }
    }
  }
  return total = stack.top();
}

void main(args) {
  //exampleEquation();

  /***********************************************
   * RPN File Input
   ***********************************************/

  if (args.isEmpty) {
    stdout.write("ERROR: Could not find input file.\n");
  } else {
    new File(args[0].toString()).readAsLines().then((List<String> input) {
      var equation = new List();

      for (int i = 0; i < input.length; i++) {
        equation = input[i].split(" ");
        num total = calculateTotal(equation);
        display(input[i], total);
      }
    });
  }
}

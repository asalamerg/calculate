import 'package:culculator/screenui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Cul());
}


class Cul extends StatefulWidget {
  const Cul({super.key});

  @override
  State<StatefulWidget> createState() =>Fulwed();


}
class Fulwed extends State{
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('الة الحاسبة',
            style: TextStyle(fontSize: 30, color: Colors.yellow,),),),
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              decoration: const BoxDecoration(color: Colors.white54),
              child: Text(result, style: const TextStyle(color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),),),
          ),
          Expanded(child: Row(children: [
            Ui(text: '9', on: onDigitC,),
            Ui(text: '8', on: onDigitC),
            Ui(text: '7', on: onDigitC),
            Ui(text: '/', on: onOperator),
          ],)),
          Expanded(child: Row(children: [
            Ui(text: '6', on: onDigitC),
            Ui(text: '5', on: onDigitC),
            Ui(text: '4', on: onDigitC),
            Ui(text: '*', on: onOperator),
          ],)),
          Expanded(child: Row(children: [
            Ui(text: '3', on: onDigitC),
            Ui(text: '2', on: onDigitC),
            Ui(text: '1', on: onDigitC),
            Ui(text: '+', on: onOperator),
          ],)),
          Expanded(child: Row(children: [
            Ui(text: '.', on:onDot),
            Ui(text: '0', on: onDigitC),
            Ui(text: '-', on: onOperator,),
            Ui(text: '=', on: onEqual),
          ],)),
          Expanded(child: Row(children: [Ui(text: 'delete', on: onDelete)],)),
        ],),
      ),

    );
  }



  String result = '';     // الشاشة الرئيسية لعرض النتيجة
  String digit = '';      // الرقم الأول
  String saveOperator = ''; // العملية الحسابية الحالية

  void onDigitC(String num) {
    setState(() {
      result += num; // نضيف الرقم المدخل إلى النتيجة
    });
  }


  // عند اختيار عملية حسابية (+, -, *, /)
  void onOperator(String op) {
    if (result.isEmpty) return; // إذا كانت النتيجة فارغة، نتجاهل العملية
    if (digit.isEmpty) {
      digit = result;  // نخزن الرقم الأول
      saveOperator = op;  // نحفظ العملية التي تم اختيارها
    } else {
      digit = calculate(digit, saveOperator, result); // حساب النتيجة المؤقتة
      saveOperator = op;  // تحديث العملية الحالية
    }
    result = ''; // إفراغ الشاشة للتحضير للرقم الثاني
    setState(() {});
  }

  // دالة الحساب
  String calculate(String num1, String op, String num2) {
    double n1 = double.parse(num1); // تحويل الرقم الأول إلى double
    double n2 = double.parse(num2); // تحويل الرقم الثاني إلى double
    late double resultCalc;

    switch (op) {
      case '*':
        resultCalc = n1 * n2;
        break;
      case '+':
        resultCalc = n1 + n2;
        break;
      case '-':
        resultCalc = n1 - n2;
        break;
      case '/':
        if (n2 != 0) {
          resultCalc = n1 / n2;
        } else {
          return 'Error'; // لا يمكن القسمة على صفر
        }
        break;
      default:
        return 'Error';
    }

    return resultCalc.toString(); // تحويل النتيجة إلى String وإعادتها
  }
  // عند الضغط على زر '='
  void onEqual(String _) {
    if (saveOperator.isEmpty || digit.isEmpty) return; // التأكد من وجود عملية ورقمين
    setState(() {
      result = calculate(digit, saveOperator, result); // حساب النتيجة النهائية
      digit = ''; // إعادة تعيين الرقم الأول
      saveOperator = ''; // إعادة تعيين العملية
    });
  }
  void onDot (String _){
    if(result.contains('.')) return;
    result='$result.';
    setState(() {});
  }

  void onDelete(String _){
    setState(() {
      if (result.isNotEmpty) {
        // لحذف آخر رقم فقط
        result = result.substring(0, result.length - 1);
      }
    });
  }
}



import "package:flutter/material.dart";
import "package:calculator2/data/bdata.dart";
import "package:math_expressions/math_expressions.dart";
import "package:petitparser/petitparser.dart";
import "dart:math";

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    final builder = ExpressionBuilder<num>();
    builder.primitive(digit()
        .plus()
        .seq(char('.').seq(digit().plus()).optional())
        .flatten()
        .trim()
        .map(num.parse));
    builder.group().wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
    // Negation is a prefix operator.
    builder.group().prefix(char('-').trim(), (operator, value) => -value);

// Power is right-associative.

    builder
        .group()
        .right(char('^').trim(), (left, operator, right) => pow(left, right));

// Multiplication and addition are left-associative, multiplication has
// higher priority than addition.
    builder.group()
      ..left(char('*').trim(), (left, operator, right) => left * right)
      ..left(char('/').trim(), (left, operator, right) => left / right);
    builder.group()
      ..left(char('+').trim(), (left, operator, right) => left + right)
      ..left(char('-').trim(), (left, operator, right) => left - right);
    final parser = builder.build();
    final Size size = MediaQuery.of(context).size;
    TextEditingController txtcon = TextEditingController();
    TextEditingController txtcon2 = TextEditingController();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            SizedBox(
              height: size.width / 10,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: txtcon,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                  ),
                  fillColor: Colors.blueGrey[900],
                  hintText: "0",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  labelStyle: const TextStyle(),
                  hintTextDirection: TextDirection.rtl,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: size.width / 30,
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 80),
              child: TextField(
                controller: txtcon2,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                  ),
                  fillColor: Colors.blueGrey[900],
                  hintText: "0",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: const TextStyle(),
                  hintTextDirection: TextDirection.rtl,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.width / 10,
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 150),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                      width: 20,
                      child: ElevatedButton(
                          onPressed: () {
                            String txt1 = txtcon.text + b_data[index].txt;
                            if (b_data[index].txt == "CE" ||
                                b_data[index].txt == "C") {
                              txtcon.value = TextEditingValue(
                                text: "",
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: "".length),
                                ),
                              );
                              txtcon2.value = TextEditingValue(
                                text: "0",
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: "0".length),
                                ),
                              );
                            } else {
                              if (b_data[index].txt == "=") {
                                String exp = parser
                                    .parse(txtcon.text.toString())
                                    .value
                                    .toString();
                                txtcon2.value = TextEditingValue(
                                  text: exp,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: exp.length),
                                  ),
                                );
                                txtcon.value = TextEditingValue(
                                  text: "",
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: "".length),
                                  ),
                                );
                              } else {
                                if (b_data[index].txt == "1/x") {
                                  String exp = parser
                                      .parse("1 / " + txtcon.text.toString())
                                      .value
                                      .toString();
                                  txtcon2.value = TextEditingValue(
                                    text: exp,
                                    selection: TextSelection.fromPosition(
                                      TextPosition(offset: exp.length),
                                    ),
                                  );
                                  txtcon.value = TextEditingValue(
                                    text: "",
                                    selection: TextSelection.fromPosition(
                                      TextPosition(offset: "".length),
                                    ),
                                  );
                                } else {
                                  if (b_data[index].txt == "%") {
                                    String exp = parser
                                        .parse(
                                            txtcon.text.toString() + " / 100")
                                        .value
                                        .toString();
                                    txtcon2.value = TextEditingValue(
                                      text: exp,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: exp.length),
                                      ),
                                    );
                                    txtcon.value = TextEditingValue(
                                      text: "",
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: "".length),
                                      ),
                                    );
                                  } else {
                                    if (b_data[index].txt == "sqrt(x)") {
                                      double x =
                                          double.parse(txtcon.text.toString());
                                      String exp = sqrt(x).toString();
                                      txtcon2.value = TextEditingValue(
                                        text: exp,
                                        selection: TextSelection.fromPosition(
                                          TextPosition(offset: exp.length),
                                        ),
                                      );
                                      txtcon.value = TextEditingValue(
                                        text: "",
                                        selection: TextSelection.fromPosition(
                                          TextPosition(offset: "".length),
                                        ),
                                      );
                                    } else {
                                      if (b_data[index].txt == "x") {
                                        String str = txtcon.text;
                                        if (str != null && str.length > 0) {
                                          str =
                                              str.substring(0, str.length - 1);
                                          txtcon.text = str;
                                        }
                                      } else {
                                        txtcon.value = TextEditingValue(
                                          text: txt1,
                                          selection: TextSelection.fromPosition(
                                            TextPosition(offset: txt1.length),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: b_data[index].col,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              //border radius equal to or more than 50% of width
                            ),
                          ),
                          child: Text(b_data[index].txt)),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

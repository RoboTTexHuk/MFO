
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfo_showcase_app/cubit/confirm_cubit.dart';
import 'package:mfo_showcase_app/cubit/confirm_cubit.dart';
import 'package:mfo_showcase_app/cubit/confirm_cubit.dart';
import 'package:mfo_showcase_app/cubit/confirm_cubit.dart';
import 'package:mfo_showcase_app/cubit/navigation_cubit.dart';


class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int _initialDebit = 1000;
  int _monthlyPay = 1000;
  int _percentage = 5;
  int _term = 5;

  int calculate() {
    return (_initialDebit * math.pow((1 + _percentage / 100), _term / 12))
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 36),
          Text(
            "Первоначальный взнос:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Slider(
            min: 1000,
            max: 20000,
            value: _initialDebit.toDouble(),
            divisions: 16,
            label: _initialDebit.toString(),
            onChanged: (value) => setState(() {
              _initialDebit = value.toInt();
            }),
          ),
          const SizedBox(height: 8),
          Text(
            "Ежемесячный взнос:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Slider(
            min: 1000,
            max: 20000,
            value: _monthlyPay.toDouble(),
            divisions: 16,
            label: _monthlyPay.toString(),
            onChanged: (value) => setState(() {
              _monthlyPay = value.toInt();
            }),
          ),
          const SizedBox(height: 8),
          Text(
            "Процентная ставка:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Slider(
            min: 5,
            max: 30,
            value: _percentage.toDouble(),
            divisions: 5,
            label: "$_percentage%",
            onChanged: (value) => setState(() {
              _percentage = value.toInt();
            }),
          ),
          const SizedBox(height: 8),
          Text(
            "Срок депозита:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Slider(
            min: 1,
            max: 36,
            value: _term.toDouble(),
            divisions: 36,
            label: "$_term месяцев",
            onChanged: (value) => setState(() {
              _term = value.toInt();
            }),
          ),
          const SizedBox(height: 32),
          BlocBuilder<ConfirmCubit, ConfirmState>(
            builder: (context, state) {
              return Center(
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 64.0),
                    child: Text(
                      "Подробнее",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  color: Color(0xFF138DDB),
                  disabledColor: Color(0x0F138DDB),
                  textColor: Colors.white,
                  onPressed: state is ConfirmPass || state is ConfirmFail
                      ? () {
                          if (state is ConfirmPass) {
                            BlocProvider.of<NavigationCubit>(context)
                                .toOfferList();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Результат:"),
                                content: Text(
                                  calculate().toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        }
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

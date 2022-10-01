import 'package:filo_assignment/utils/gap.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, this.str, this.btn1, this.btn2,
    required this.onClick, required this.onClick2}) : super(key: key);

  final String? str;
  final String? btn1;
  final String? btn2;
  final VoidCallback onClick;
  final VoidCallback onClick2;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const VerticalGap(gap: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Text(
                str??"",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff004238),
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const VerticalGap(gap: 20.0),
          const LineBg(strokeWidth: 0.8, color: Color(0xff004238)),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onClick,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      btn1??"",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff004238),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: btn2 != null,
                  child: Container(
                      color: const Color(0xff004238),
                      height: 40.0,
                      width: 0.8)),
              Visibility(
                visible: btn2 != null,
                child: Expanded(
                  child: InkWell(
                    onTap: onClick2,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        btn2 == null ? "" : btn2??"",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xff004238),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

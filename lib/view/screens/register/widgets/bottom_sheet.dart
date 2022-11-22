import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:provider/provider.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheet();
}

class _OtpBottomSheet extends State<OtpBottomSheet> {
  Timer? _timer;
  int _start = 40;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (_start == 0) {
          Navigations.pop();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberVerifyController =
        Provider.of<PhoneNumberViewModel>(context, listen: false);
    return SizedBox(
      height: widget.size.height / 1.5,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(children: [
            KSizedBox.kHeigh_10,
            TitleWidget(
              'Verify otp',
              color: KColors.kThemeGreen,
            ),
            KSizedBox.kHeigh_20,
            PinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              autoDisposeControllers: false,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              controller: numberVerifyController.otpController,
              onChanged: (value) {},
              appContext: context,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget('You have  ', fontSize: 16),
                TitleWidget('$_start', fontSize: 20, color: KColors.kLiteGreen),
                TitleWidget('  Seconds remaining', fontSize: 16),
              ],
            ),
            const Spacer(),
            Selector<PhoneNumberViewModel, bool>(
              selector: (_, obj) => obj.isLoading,
              builder: (__, isLoading, _) => isLoading
                  ? const LoadingIndicator(
                      color: KColors.kThemeGreen,
                    )
                  : ButtonWidget(
                      text: 'Verify',
                      onTap: () {
                        numberVerifyController.onOtpVerifyButton();
                      },
                      color: KColors.kThemeGreen,
                    ),
            )
          ]),
        ),
      ),
    );
  }
}

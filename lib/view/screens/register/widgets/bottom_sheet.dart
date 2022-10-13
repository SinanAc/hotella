import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/single_color_title.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:provider/provider.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheet();
}

class _ShowBottomSheet extends State<ShowBottomSheet> {
  bool isTimesUp = false;
  Timer? _timer;
  int _start = 40;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isTimesUp = true;
            timer.cancel();
          });
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
    Provider.of<PhoneNumberViewModel>(context, listen: false).mobileNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberVerifyController =
        Provider.of<PhoneNumberViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(30),
      height: widget.size.height / 1.45,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          const SingleColorTitle(
            text: 'Verify otp',
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
            readOnly: isTimesUp?true:false,
          ),
          isTimesUp?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const SingleColorTitle(text: 'Times up !!!', fontSize: 20,color: KColors.kRedColor,),
               KSizedBox.kWidth_10,
               ButtonWidget(text: 'Go back', onTap: (){
                PushFunctions.pop(context);
               },width: 150,color: KColors.kThemeGreen,)
            ],
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SingleColorTitle(text: 'You have  ', fontSize: 16),
              SingleColorTitle(
                  text: '$_start', fontSize: 20, color: KColors.kLiteGreen),
              const SingleColorTitle(text: '  Seconds remaining', fontSize: 16),
            ],
          ),
          const Spacer(),
          Consumer<PhoneNumberViewModel>(
            builder: (context, value, _) => value.isLoading
                ? const LoadingIndicator(
                    color: KColors.kThemeGreen,
                  )
                : ButtonWidget(
                    text: 'Verify',
                    onTap: () {
                      value.onOtpVerifyButton(context);
                    },
                    color: KColors.kThemeGreen,
                  ),
          )
        ]),
      ),
    );
  }
}

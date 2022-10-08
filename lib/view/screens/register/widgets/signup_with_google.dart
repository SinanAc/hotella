import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:premio_inn/utils/sizes.dart';

class SignUpWithGoogle extends StatelessWidget {
  const SignUpWithGoogle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 8,
      child: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(185, 15, 102, 87),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 30,
                child: SvgPicture.asset('assets/images/Google__G__Logo.svg')),
            KSizedBox.kHeigh_5,
            const Text(
              'Continue with google',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

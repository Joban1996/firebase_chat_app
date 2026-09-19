import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/core/theme/app_colors.dart';
import 'package:flutter_base_architecture/core/theme/app_theme.dart';
import 'package:flutter_base_architecture/core/utils/size_utils.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
                'assets/images/coffee_bg.webp'),fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Text('Fall in Love with \nCoffee in Blissful \nDelight!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.surface,
                    fontSize: AppFontSizes.heading,
                    fontWeight: FontWeight.w800)),
            Text('Welcome to our cozy coffee corner, where \nevery cup is a delightful for you.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.greySurface,fontSize: AppFontSizes.base,fontWeight: FontWeight.w600)),
            Padding(padding: EdgeInsetsGeometry.only(bottom: 16)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.surface,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                onPressed: (){}, child: Text('Get Started')),
            Padding(padding: EdgeInsets.only(bottom: context.screenHeight*0.02))
          ],
        ),
      ),
    );
  }
}

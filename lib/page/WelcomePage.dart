import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ExchangePage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.attach_money),
        title: Text('แปลงค่าเงินบาทไทย'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "ยินดีต้อนรับสู่แอปของเรา",
                          style: GoogleFonts.sriracha(
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        TextSpan(
                          text: "เว็บนี้มีไว้เพื่อแปลงค่าเงินบาทไทยในต่างประเทศ(เท่านั้น)",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ExchangePage();
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "คลิกที่นี่",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 30, height: 35,),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:exchange_currency/api/Exchange.dart';
import 'WidgetBox.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {

  late Exchange _dataFromAPI;
  final control = TextEditingController();
  var textMes = '';
  double resultNum = 0;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future <Exchange> getExchangeRate() async {
    var url = Uri.parse("https://api.exchangerate-api.com/v4/latest/THB");
    var response = await http.get(url);
    _dataFromAPI = exchangeFromJson(response.body); // Json เป็น dart obj.
    return _dataFromAPI;
  }

  void getNumber() {
    var value = double.tryParse(control.text);

    if (value == null) {
      setState(() {
        textMes = 'ใส่ค่าที่ต้องการแปลง';
      });
    } else {
      setState(() {
        resultNum = value;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.attach_money),
        title: Text('แปลงค่าเงินบาทไทย'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            future: getExchangeRate(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var result = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 125,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "สกุลเงิน(THB) ",
                              style: GoogleFonts.kanit(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: control,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'ใส่จำนวนเงิน',
                                ),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<
                                    Color>(Colors.white),
                              ),
                              onPressed: getNumber,
                              child: Text(
                                "แปลง",
                                style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      widgetBox(
                          "USD", resultNum * result.rates["USD"], Colors.green,
                          90),
                      SizedBox(height: 5),
                      widgetBox("EUR", resultNum * result.rates["EUR"],
                          Colors.redAccent, 90),
                      SizedBox(height: 5),
                      widgetBox("AED", resultNum * result.rates["AED"],
                          Colors.pinkAccent, 90),
                      SizedBox(height: 5),
                      widgetBox("JPY", resultNum * result.rates["JPY"],
                          Colors.orangeAccent, 90),
                      SizedBox(height: 5),
                      widgetBox(
                          "AUD", resultNum * result.rates["AUD"], Colors.teal,
                          90),
                      SizedBox(height: 5),
                      widgetBox("TWD", resultNum * result.rates["TWD"],
                          Colors.blueGrey, 90),
                      SizedBox(height: 5),
                      widgetBox("KRW", resultNum * result.rates["KRW"],
                          Colors.purpleAccent, 90),
                      SizedBox(height: 5),
                      widgetBox("BHD", resultNum * result.rates["BHD"],
                          Colors.purpleAccent, 90),
                    ],
                  ),
                );
              }
              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
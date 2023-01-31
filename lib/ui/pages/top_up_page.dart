part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  const TopUpPage(this.pageEvent, {super.key});
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: "IDR 0");
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData.from(
            colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ))));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(widget.pageEvent);

        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Stack(
                children: <Widget>[
                  SafeArea(
                      child: Container(
                    margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                    child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(widget.pageEvent);
                        },
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black)),
                  )),
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Top Up",
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          onChanged: (text) {
                            String temp = "";

                            for (int i = 0; i < text.length; i++) {
                              temp += text.isDigit(i) ? text[i] : "";
                            }
                            setState(() {
                              selectedAmount = int.tryParse(temp) ?? 0;
                            });

                            amountController.text = NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'IDR ',
                                    decimalDigits: 0)
                                .format(selectedAmount);

                            amountController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: amountController.text.length));
                          },
                          controller: amountController,
                          decoration: InputDecoration(
                              labelStyle: greyTextFont,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Amount"),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 14),
                            child: Text("Choose by Template",
                                style: blackTextFont),
                          ),
                        ),
                        Wrap(
                          spacing: 20,
                          runSpacing: 14,
                          children: <Widget>[
                            makeMoneyCard(
                              amount: 50000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 100000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 150000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 200000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 250000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 300000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 350000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 400000,
                              width: cardWidth,
                            ),
                            makeMoneyCard(
                              amount: 450000,
                              width: cardWidth,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 46,
                          width: 250,
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3E9D9D),
                                  disabledForegroundColor:
                                      const Color(0xFFE4E4E4).withOpacity(0.38),
                                  disabledBackgroundColor:
                                      const Color(0xFFE4E4E4).withOpacity(0.12),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: (selectedAmount > 0)
                                  ? () {
                                      context.read<PageBloc>().add(
                                            GoToSuccessPage(
                                              "" as Ticket,
                                              FlutixTransaction(
                                                  userID:
                                                      (userState as UserLoaded)
                                                          .user
                                                          .id,
                                                  title: "Top Up Wallet",
                                                  amount: selectedAmount,
                                                  subtitle:
                                                      "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                                  time: DateTime.now(),
                                                  picture: ''),
                                            ),
                                          );
                                    }
                                  : null,
                              child: Text(
                                "Top Up My Wallet",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (selectedAmount > 0)
                                        ? Colors.white
                                        : const Color(0xFFBEBEBE)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  MoneyCard makeMoneyCard({int? amount, double? width}) {
    return MoneyCard(
      amount: amount!,
      width: width!,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
                  locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
              .format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}

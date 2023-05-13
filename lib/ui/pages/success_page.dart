part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket? ticket;
  final FlutixTransaction transaction;

  const SuccessPage(this.ticket, this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
              future: processingTopUp(context),
              builder: (_, snapshot) => (snapshot.connectionState ==
                      ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.only(bottom: 70),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ticket == null
                                  ? "assets/top_up_done.png"
                                  : "assets/ticket_done.png"),
                            ),
                          ),
                        ),
                        Text(
                          (ticket == null) ? "Emm Yummy!" : "Happy Watching!",
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          (ticket == null)
                              ? "You have successfully\ntop up the wallet"
                              : "you have successfully\nbought the ticket",
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          height: 45,
                          width: 250,
                          margin: const EdgeInsets.only(top: 70, bottom: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              (ticket == null) ? "My Wallet" : "My Tickets",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () {
                              if (ticket == null) {
                                context
                                    .read<PageBloc>()
                                    .add(const GoToWalletPage(GoToMainPage()));
                              } else {
                                context.read<PageBloc>().add(
                                    const GoToMainPage(bottomNavBarIndex: 1));
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Discover new movie? ",
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<PageBloc>()
                                    .add(const GoToMainPage());
                              },
                              child: Text(
                                "Back to Home",
                                style: purpleTextFont,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    )),
        ));
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.read<UserBloc>().add(Purchase(ticket!.totalPrice));
    context.read<TicketBloc>().add(BuyTicket(ticket!, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.read<UserBloc>().add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}

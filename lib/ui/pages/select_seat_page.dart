part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  const SelectSeatPage(this.ticket, {Key? key}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context
              .read<PageBloc>()
              .add(GoToSelectSchedulePage(widget.ticket.movieDetail));

          return Future.value(true);
        },
        child: Scaffold(
            body: Center(
                child: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: defaultMargin),
                          padding: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(
                                  GoToSelectSchedulePage(
                                      widget.ticket.movieDetail));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: defaultMargin),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    widget.ticket.movieDetail.title,
                                    style: blackTextFont.copyWith(fontSize: 20),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.end,
                                  )),
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${imageBaseURL}w154${widget.ticket.movieDetail.posterPath}"),
                                      )))
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: 277,
                      height: 84,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/screen.png"))),
                    ),
                    generateSeats(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: selectedSeats.isNotEmpty
                              ? mainColor
                              : const Color(0xFFE4E4E4),
                          onPressed: selectedSeats.isNotEmpty
                              ? () {
                                  context.read<PageBloc>().add(GoToCheckoutPage(
                                      widget.ticket
                                          .copyWith(seats: selectedSeats)));
                                }
                              : null,
                          child: Icon(
                            Icons.arrow_forward,
                            color: selectedSeats.isNotEmpty
                                ? Colors.white
                                : const Color(0xFFBEBEBE),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              ],
            )
          ],
        ))));
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numberofSeats[i],
            (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index < numberofSeats[i] - 1 ? 16 : 0, bottom: 16),
                  child: SelectableBox(
                    "${String.fromCharCode(i + 65)}${index + 1}",
                    width: 40,
                    height: 40,
                    textStyle: whiteNumberFont.copyWith(color: Colors.black),
                    isSelected: selectedSeats
                        .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                    onTap: () {
                      String seatNumber =
                          "${String.fromCharCode(i + 65)}${index + 1}";
                      setState(() {
                        if (selectedSeats.contains(seatNumber)) {
                          selectedSeats.remove(seatNumber);
                        } else {
                          selectedSeats.add(seatNumber);
                        }
                      });
                    },
                    isEnabled: index != 0,
                  ),
                )),
      ));
    }

    return Column(
      children: widgets,
    );
  }
}

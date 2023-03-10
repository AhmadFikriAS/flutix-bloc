part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color? color;
  final MainAxisAlignment alignment;

  const RatingStars(
      {Key? key,
      this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.color,
      this.alignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: Colors.yellow,
              size: starSize,
            ));

    widgets.add(const SizedBox(
      width: 3,
    ));
    widgets.add(Text(
      "$voteAverage/10",
      style: whiteNumberFont.copyWith(
          color: color, fontWeight: FontWeight.w300, fontSize: fontSize),
    ));
    return Row(
      mainAxisAlignment: alignment,
      children: widgets,
    );
  }
}

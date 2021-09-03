import 'dart:math';

import 'package:youtube_on_steroids/app/app.dart';

class TableGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing, crossAxisSpacing;
  final MainAxisAlignment mainAxisAlignment;

  TableGrid({
    this.children,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 4,
    this.crossAxisSpacing = 4,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    int rowIndex = -1, itemIndex = -1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.filled((children.length / crossAxisCount).ceil(), 0).map((_) {
        ++rowIndex;
        int colCount = crossAxisCount;
        if (children.length % crossAxisCount != 0 &&
            rowIndex == (children.length / crossAxisCount).floor()) {
          colCount = children.length % crossAxisCount;
        }
        final semanticRowList = Iterable<int>.generate(colCount * 2 - 1);
        return Padding(
          padding: EdgeInsets.only(top: rowIndex > 0 ? crossAxisSpacing : 0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: semanticRowList.map<Widget>((semanticRowIndex) {
              return semanticRowIndex.isOdd
                  ? SizedBox(width: mainAxisSpacing)
                  : children[++itemIndex];
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class SeparatedColumn extends StatelessWidget {
  final List<Widget> children;
  final Widget separator;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  SeparatedColumn({
    @required this.children,
    @required this.separator,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = max(0, children.length * 2 - 1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [for (int i = 0; i < itemCount; i += 1) i].map((index) {
        final int itemIndex = index ~/ 2;
        return index.isEven ? children[itemIndex] : separator;
      }).toList(),
    );
  }
}

class SeparatedRow extends StatelessWidget {
  final List<Widget> children;
  final Widget separator;
  final MainAxisAlignment mainAxisAlignment;

  SeparatedRow({
    @required this.children,
    @required this.separator,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = max(0, children.length * 2 - 1);
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [for (int i = 0; i < itemCount; i += 1) i].map((index) {
        final int itemIndex = index ~/ 2;
        return index.isEven ? children[itemIndex] : separator;
      }).toList(),
    );
  }
}

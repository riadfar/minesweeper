import 'package:flutter/material.dart';

import '../../../logic/block.dart';

class BlockWidget extends StatefulWidget {
  final Block block;

  const BlockWidget({super.key, required this.block});

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(_imagePath(widget.block), fit: BoxFit.cover),
    );
  }

  String _imagePath(Block block) {
    if (block.state == BlockState.flagged) {
      return "assets/images/flag.png";
    }
    if (block.state == BlockState.revealed) {
      if (block.type != BlockType.number && block.type != BlockType.empty) {
        return "assets/images/mine.png";
      }
      return "assets/images/${block.number}.png";
    }
    return "assets/images/hidden.png";
  }
}

import 'package:minesweeper/logic/field.dart';

import 'field_config.dart';

void main() {
  FieldConfig config =FieldConfig(width: 4, height: 4, minesCount: 5);
  FieldTest field = FieldTest(config: config);
  Field field2 = Field(config: config);
  field.printField(revealMines: true);
  field2.printField(revealMines: true);
  field.printField();
  field2.printField();



}
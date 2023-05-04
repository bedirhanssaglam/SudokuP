import 'package:flutter/foundation.dart' show immutable;
import 'package:sudoku_app/core/constants/app/string_constants.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

@immutable
class NewGame {
  const NewGame._();

  static Future<List<List<List<int>>>> getNewGame(
      [String difficulty = AppConstants.easy]) async {
    int? emptySquares;
    switch (difficulty) {
      case AppConstants.test:
        {
          emptySquares = 2;
        }
        break;
      case AppConstants.beginner:
        {
          emptySquares = 18;
        }
        break;
      case AppConstants.easy:
        {
          emptySquares = 27;
        }
        break;
      case AppConstants.medium:
        {
          emptySquares = 36;
        }
        break;
      case AppConstants.hard:
        {
          emptySquares = 54;
        }
        break;
      default:
        {
          emptySquares = 2;
        }
        break;
    }
    SudokuGenerator generator = SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }
}

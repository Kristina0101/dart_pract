import 'dart:io';
import 'dart:math';

void main() {
  while (true) {
    print("\nНовая игра!");


    int size = 0;
    while (size < 3 || size > 9) {
      stdout.write("Введите размер игрового поля (3-9): ");
      size = int.tryParse(stdin.readLineSync()!) ?? 0;
      if (size < 3 || size > 9) {
        print("Неверный размер. Повторите ввод.");
      }
    }

    List<List<String>> board = List.generate(size, (_) => List.filled(size, '.'));

    String currentPlayer = Random().nextBool() ? 'X' : 'O';
    print("Первым ходит $currentPlayer!");

    while (true) {
      printBoard(board);

      stdout.write("$currentPlayer, введите строку и столбец (например, 1 2): ");
      List<int>? move = parseMove(stdin.readLineSync(), size);

      if (move == null) {
        print("Неверный ввод. Попробуйте снова.");
        continue;
      }

      int row = move[0] - 1;
      int col = move[1] - 1;

      if (board[row][col] != '.') {
        print("Ячейка занята. Попробуйте снова.");
        continue;
      }

      board[row][col] = currentPlayer;


      if (checkWinner(board, currentPlayer, row, col, size)) {
        printBoard(board);
        print("$currentPlayer победил!");
        break;
      }

      if (board.every((row) => row.every((cell) => cell != '.'))) {
        printBoard(board);
        print("Ничья!");
        break;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    stdout.write("Хотите сыграть снова? 1 - да, 2 - нет: ");
    String? response = stdin.readLineSync()?.toLowerCase();
    if (response != '1') {
      print("Спасибо за игру!");
      break;
    }
  }
}

void printBoard(List<List<String>> board) {
  print("\n  ${List.generate(board.length, (i) => i + 1).join(' ')}");
  for (int i = 0; i < board.length; i++) {
    print("${i + 1} ${board[i].join(' ')}");
  }
}

List<int>? parseMove(String? input, int size) {
  if (input == null) return null;
  List<String> parts = input.split(' ');
  if (parts.length != 2) return null;

  int? row = int.tryParse(parts[0]);
  int? col = int.tryParse(parts[1]);

  if (row == null || col == null || row < 1 || row > size || col < 1 || col > size) {
    return null;
  }

  return [row, col];
}

bool checkWinner(List<List<String>> board, String player, int row, int col, int size) {
  bool checkLine(int dr, int dc) {
    int count = 0;
    for (int i = -size; i <= size; i++) {
      int r = row + dr * i;
      int c = col + dc * i;
      if (r >= 0 && r < size && c >= 0 && c < size && board[r][c] == player) {
        count++;
        if (count == size) return true;
      } else {
        count = 0;
      }
    }
    return false;
  }

  return checkLine(0, 1) || checkLine(1, 0) || checkLine(1, 1) || checkLine(1, -1);
}

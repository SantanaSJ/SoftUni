package Advanced.Exam;

import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class Bombs {
    static boolean isEndReached = false;
    static int bombCounter = 0;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int n = Integer.parseInt(scanner.nextLine());

        char[][] matrix = new char[n][];

        List<String> commands = Arrays.stream(scanner.nextLine().split(","))
                .map(String::toString)
                .collect(Collectors.toList());

        int[] positions = new int[2];

        int currentBombs = 0;
        for (int row = 0; row < n; row++) {
            String lines = scanner.nextLine();

            String strippedString = lines.replaceAll("\\s+", "");
            if (strippedString.contains("s")) {
                positions[0] = row;
                positions[1] = strippedString.indexOf("s");
            }
            for (int i = 0; i < strippedString.length(); i++) {
                if (strippedString.charAt(i) == 'B') {
                    currentBombs++;
                }
            }

            matrix[row] = strippedString.toCharArray();
        }

        while (currentBombs > bombCounter && !commands.isEmpty()) {

            String s = commands.get(0);

            switch (s) {
                case "up":
                    move(positions[0] - 1, positions[1], positions, matrix);
                    break;
                case "down":
                    move(positions[0] + 1, positions[1], positions, matrix);
                    break;
                case "left":
                    move(positions[0], positions[1] - 1, positions, matrix);
                    break;
                case "right":
                    move(positions[0], positions[1] + 1, positions, matrix);
                    break;
            }
            commands.remove(0);
            if (isEndReached) {//&& currentBombs - bombCounter > 0
                break;
            }
            if (currentBombs == bombCounter) {
                break;
            }
        }

        if (bombCounter == currentBombs) {
            System.out.println("Congratulations! You found all bombs!");
        } else if (isEndReached) {
            System.out.printf("END! %d bombs left on the field", currentBombs - bombCounter);
        } else {
            System.out.printf("%d bombs left on the field. Sapper position: (%d,%d)", currentBombs - bombCounter,
                    positions[0], positions[1]);
        }
    }


    private static void move(int row, int col, int[] positions, char[][] matrix) {

        if (isInBounds(row, col, matrix)) {
            char currentElement = matrix[row][col];
            if (currentElement == 'B') {
                bombCounter++;//!!
                System.out.println("You found a bomb!");
            } else if (currentElement == 'e') {
                isEndReached = true;
            }
            matrix[row][col] = 's';
            matrix[positions[0]][positions[1]] = '+';
            positions[0] = row;
            positions[1] = col;
        } else {
            matrix[positions[0]][positions[1]] = 's';
        }

    }

    private static boolean isInBounds(int row, int col, char[][] matrix) {
        return row < matrix.length && row >= 0 && col < matrix[row].length
                && col >= 0;

    }
}
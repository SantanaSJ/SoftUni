package Advanced;

import java.util.Scanner;

public class FillTheMatrix {
    public static void main(String[] args) {


        Scanner scanner = new Scanner(System.in);


        String[] line = scanner.nextLine().split(", ");
        int rows = Integer.parseInt(line[0]);
        String type = line[1];
        int[][] matrix = new int[rows][];
        switch (type) {
            case "A": {
                matrix = fillArrayA(rows);
                break;
            }
            case "B": {
                matrix = fillArrayB(rows);
                break;
            }
        }
        printMatrix(matrix);
    }

    private static void printMatrix(int[][] matrix) {
        for (int[] numbers : matrix) {
            for (int number : numbers) {
                System.out.print(number + " ");
            }
            System.out.println();
        }

    }

    private static int[][] fillArrayB(int rows) {
        int[][] matrix = new int[rows][rows];
        int counter = 0;
        for (int col = 0; col < rows; col++) {
            if (col % 2 == 0) {
                for (int row = 0; row < rows; row++) {
                    counter++;
                    matrix[row][col] = counter;
                }
            } else {
                for (int row = rows - 1; row >= 0; row--) {
                    counter++;
                    matrix[row][col] = counter;
                }
            }
        }

        return matrix;
    }

    private static int[][] fillArrayA(int rows) {
        int[][] matrix = new int[rows][rows];
        int counter = 0;
        for (int col = 0; col < rows; col++) {
            for (int row = 0; row < rows; row++) {
                counter++;
                matrix[row][col] = counter;
            }
        }
        return matrix;
    }
}





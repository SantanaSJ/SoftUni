package Advanced.MultidimensionalArrays;

import java.util.Arrays;
import java.util.Scanner;

public class MatrixShuffling {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String[][] matrix = readMatrix(scanner);

        String line = scanner.nextLine();
        while (!"END".equals(line)) {
            try {
                String[] parts = line.split("\\s+");
                String command = parts[0];

                if (!"swap".equals(command) || parts.length > 5) {
                    throw new IllegalStateException();
                }
                int row1 = Integer.parseInt(parts[1]);
                int col1 = Integer.parseInt(parts[2]);
                int row2 = Integer.parseInt(parts[3]);
                int col2 = Integer.parseInt(parts[4]);


                String temp = matrix[row1][col1];
                matrix[row1][col1] = matrix[row2][col2];
                matrix[row2][col2] = temp;

                printMatrix(matrix);
            } catch (IndexOutOfBoundsException | IllegalStateException ex) {
                System.out.println("Invalid input!");
            }

            line = scanner.nextLine();

        }

    }

    private static void printMatrix(String[][] matrix) {
        for (String[] strings : matrix) {
            for (String string : strings) {
                System.out.print(string + " ");
            }
            System.out.println();
        }
    }

    private static String[][] readMatrix(Scanner scanner) {

        int[] array = Arrays.stream(scanner.nextLine().split("\\s+"))
                .mapToInt(Integer::parseInt)
                .toArray();

        int rows = array[0];
        int cols = array[1];

        String[][] matrix = new String[rows][cols];

        for (int row = 0; row < rows; row++) {
            String[] line = scanner.nextLine().split("\\s+");
            for (int col = 0; col < cols; col++) {
                matrix[row][col] = (line[col]);
            }
        }
        return matrix;
    }
}






package Advanced.FunctionalProgramming;

import java.util.Arrays;
import java.util.Scanner;
import java.util.stream.Collectors;

public class SortEvenNumbers {

    public static class Math {
        public static boolean isEven(int number) {
            return isDivisibleBy(number, 2);
        }

        public static boolean isDivisibleBy(int number, int divisor) {
            return number % divisor == 0;
        }

    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int[] numbers = Arrays.stream(scanner.nextLine().split(", "))
                .mapToInt(Integer::parseInt)
                .filter(Math::isEven)
                .toArray();

        System.out.println(formatArray(numbers));
        Arrays.sort(numbers);
        System.out.println(formatArray(numbers));

    }

    private static String formatArray(int[] array) {
        return Arrays
                .stream(array)
                .mapToObj(String::valueOf)
                .collect(Collectors.joining(", "));

    }

    public static boolean isEven(int number) {
        return isDivisibleBy(number, 2);
    }

    public static boolean isDivisibleBy(int number, int divisor) {
        return number % divisor == 0;
    }
}



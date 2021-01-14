package Advanced;

import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Scanner;
import java.util.stream.Collectors;

public class MathPotato {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);


        ArrayDeque<String> names = Arrays
                .stream(scanner.nextLine().split(" "))
                .collect(Collectors.toCollection(ArrayDeque::new));

        int n = scanner.nextInt();

        int cycle = 1;
        while (names.size() > 1) {
            for (int i = 1; i < n; i++) {
                names.offer(names.poll());
            }
            if (isPrime(cycle)) {
                System.out.println("Prime " + names.peek());
            } else {
                System.out.println("Removed " + names.poll());
            }
            cycle++;
        }
        System.out.println("Last is " + names.poll());
    }

    private static boolean isPrime(int n) {
        if (n == 1) {
            return false;
        }
        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }

}




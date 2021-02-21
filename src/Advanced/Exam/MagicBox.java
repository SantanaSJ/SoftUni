package Advanced.Exam;

import java.util.*;

public class MagicBox {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Deque<Integer> firstQ = new ArrayDeque<>();
        Deque<Integer> secondS = new ArrayDeque<>();

        Arrays.stream(scanner.nextLine().split("\\s+"))
                .mapToInt(Integer::parseInt)
                .forEach(f -> firstQ.offer(f));
        Arrays.stream(scanner.nextLine().split("\\s+"))
                .mapToInt(Integer::parseInt)
                .forEach(m -> secondS.push(m));

        List<Integer> claimedItems = new ArrayList<>();

        while (!firstQ.isEmpty() && !secondS.isEmpty()) {
            int firstItem = firstQ.poll();
            int secondItem = secondS.pop();

            int sum = firstItem + secondItem;
            if (sum % 2 == 0) {
                claimedItems.add(sum);
            } else {
                firstQ.offer(secondItem);
                firstQ.addFirst(firstItem);
            }
        }

        if (firstQ.isEmpty()) {
            System.out.println("First magic box is empty.");
        } else {
            System.out.println("Second magic box is empty.");
        }

        int sum = claimedItems
                .stream()
                .mapToInt(i -> Integer.parseInt(String.valueOf(i)))
                .sum();
        if (sum >= 90) {
            System.out.printf("Wow, your prey was epic! Value: %d", sum);
        } else {
            System.out.println("Poor prey... Value: " + sum);
        }
    }
}

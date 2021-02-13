package Advanced.ExamPrep;

import java.util.*;
import java.util.stream.Collectors;

public class Cooking {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Deque<Integer> liquidsQ = new ArrayDeque<>();
        Deque<Integer> ingredientsStack = new ArrayDeque<>();

        Arrays.stream(scanner.nextLine().split("\\s+"))
                .map(Integer::parseInt)
                .forEach(e -> liquidsQ.offer(e));

        Arrays.stream(scanner.nextLine().split("\\s+"))
                .map(Integer::parseInt)
                .forEach(e -> ingredientsStack.push(e));


        Map<String, Integer> foodsCount = new TreeMap<>();
        foodsCount.put("Bread", 0);
        foodsCount.put("Cake", 0);
        foodsCount.put("Pastry", 0);
        foodsCount.put("Fruit Pie", 0);


        while (!liquidsQ.isEmpty() && !ingredientsStack.isEmpty()) {
            int sum;
            int firstLiquid = liquidsQ.poll();
            int lastIngredient = ingredientsStack.pop();

            sum = firstLiquid + lastIngredient;

            if (isEqualToNumbers(sum)) {
                String typeOfFood = getTypeOfFood(sum);

                foodsCount.put(typeOfFood, foodsCount.get(typeOfFood) + 1);

            } else {
                ingredientsStack.push(lastIngredient + 3);
            }
        }

        if (hasUsedAllIngredients(foodsCount)) {
            System.out.println("Wohoo! You succeeded in cooking all the food!");
        } else {
            System.out.println("Ugh, what a pity! You didn't have enough materials to to cook everything.");
        }

        if (!liquidsQ.isEmpty()) {
            System.out.print("Liquids left: ");
            System.out.println(print(liquidsQ));
        } else {
            System.out.println("Liquids left: none");
        }
        if (!ingredientsStack.isEmpty()) {
            System.out.print("Ingredients left: ");
            System.out.println(print(ingredientsStack));
        } else {
            System.out.println("Ingredients left: none");
        }

        foodsCount.forEach((k,v)->System.out.println(k +": "+v));

    }

    public static String print(Deque<Integer> deque) {
        return deque
                .stream()
                .map(Integer -> String.valueOf(Integer))
                .collect(Collectors.joining(", "));
    }

    public static boolean hasUsedAllIngredients(Map<String, Integer> count) {
        return count
                .values()
                .stream()
                .noneMatch(v -> v == 0);
    }

    private static String getTypeOfFood(int sum) {
        if (sum == 25) {
            return "Bread";
        } else if (sum == 50) {
            return "Cake";
        } else if (sum == 75) {
            return "Pastry";
        }
        return "Fruit Pie";
    }

    private static boolean isEqualToNumbers(int sum) {
        return sum == 25 || sum == 50 || sum == 75 || sum == 100;
    }
}

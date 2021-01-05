package Fundamentals;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class SoftUniExamResults {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, Integer> namePoints = new HashMap<>();
        Map<String, Integer> languageCount = new HashMap<>();

        String line = scanner.nextLine();
        while (!line.equals("exam finished")) {
            String[] parts = line.split("-");
            String name = parts[0];
            if (parts[1].equals("banned")) {
                namePoints.remove(name);

            } else {
                String language = parts[1];
                int points = Integer.parseInt(parts[2]);

                if (!namePoints.containsKey(name)) {
                    namePoints.put(name, points);
                    Integer currentCount = languageCount.get(language);
                    if (currentCount == null) {
                        languageCount.put(language, 1);
                    } else {
                        languageCount.put(language, currentCount + 1);
                    }

                } else {
                    Integer currentPoints = namePoints.get(name);
                    if (points > currentPoints) {
                        namePoints.put(name, points);
                    }
                    languageCount.put(language, languageCount.get(language) + 1);
                }
            }
            line = scanner.nextLine();
        }
        System.out.println("Results:");
        namePoints
                .entrySet()
                .stream()
                .sorted((a, b) -> {
                    int result = b.getValue().compareTo(a.getValue());
                    if (result == 0) {
                        result = a.getKey().compareTo(b.getKey());
                    }
                    return result;
                })
                .forEach((e -> System.out.println(e.getKey() + " | " + e.getValue())));
        System.out.println("Submissions:");
        languageCount
                .entrySet()
                .stream()
                .sorted((a, b) -> {
                    int result = b.getValue().compareTo(a.getValue());
                    if (result == 0) {
                        result = a.getKey().compareTo(b.getKey());
                    }
                    return result;
                }).forEach(e -> System.out.println(e.getKey() + " - " + e.getValue()));
    }
}




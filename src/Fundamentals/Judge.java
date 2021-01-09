package Fundamentals;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicInteger;

public class Judge {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, LinkedHashMap<String, Integer>> usersInfo = new LinkedHashMap<>();

        String lines = scanner.nextLine();
        while (!lines.equals("no more time")) {
            String[] parts = lines.split(" -> ");
            String name = parts[0];
            String contest = parts[1];
            int points = Integer.parseInt(parts[2]);

            if (!usersInfo.containsKey(contest)) {
                usersInfo.put(contest, new LinkedHashMap<>());
                usersInfo.get(contest).put(name, points);
            } else {
                if (!usersInfo.get(contest).containsKey(name)) {
                    usersInfo.get(contest).put(name, points);
                } else {
                    int currentPoints = usersInfo.get(contest).get(name);
                    usersInfo.get(contest).put(name, (Math.max(currentPoints, points)));
                }
            }
            lines = scanner.nextLine();
        }

        AtomicInteger counter = new AtomicInteger();
        usersInfo.forEach((key, value) -> {
            counter.set(1);
            System.out.printf("%s: %d participants%n", key, value.size());
            value
                    .entrySet()
                    .stream()
                    .sorted((a, b) -> {
                        int result = b.getValue().compareTo(a.getValue());
                        if (result == 0) {
                            result = a.getKey().compareTo(b.getKey());
                        }
                        return result;
                    })
                    .forEach(e -> System.out.printf("%d. %s <::> %d%n",
                            counter.getAndIncrement(), e.getKey(), e.getValue()));
        });
        System.out.println("Individual standings:");

        Map<String, Integer> newMap = new LinkedHashMap<>();

        for (Map.Entry<String, LinkedHashMap<String, Integer>> e : usersInfo.entrySet()) {
            for (Map.Entry<String, Integer> ee : e.getValue().entrySet()) {
                String name = ee.getKey();
                int points = ee.getValue();
                if (!newMap.containsKey(name)) {
                    newMap.put(name, points);
                } else {
                    int currentPoints = newMap.get(name);
                    newMap.put(name, points + currentPoints);
                }
            }
        }
        counter.set(1);
        newMap
                .entrySet()
                .stream()
                .sorted((a, b) -> {
                    int result = b.getValue().compareTo(a.getValue());
                    if (result == 0) {
                        result = a.getKey().compareTo(b.getKey());
                    }
                    return result;
                })
                .forEach(e -> System.out.printf("%d. %s -> %d%n",counter.getAndIncrement(), e.getKey(), e.getValue() ));


    }
}

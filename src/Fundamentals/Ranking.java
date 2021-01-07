package Fundamentals;

import java.util.*;

public class Ranking {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, String> contestPass = new HashMap<>();

        TreeMap<String, LinkedHashMap<String, Integer>> user = new TreeMap<>();

        String line = scanner.nextLine();
        while (!line.equals("end of contests")) {
            String[] parts = line.split(":");
            String contest = parts[0];
            String password = parts[1];

            contestPass.put(contest, password);

            line = scanner.nextLine();
        }

        String input = scanner.nextLine();
        while (!input.equals("end of submissions")) {
            String[] parts = input.split("=>");
            String contest = parts[0];
            String password = parts[1];
            String username = parts[2];
            int points = Integer.parseInt(parts[3]);

            if (contestPass.containsKey(contest) && contestPass.containsValue(password)) {

                if (!user.containsKey(username)) {
                    user.put(username, new LinkedHashMap<>());
                    user.get(username).put(contest, points);
                } else if (!user.get(username).containsKey(contest)) {
                    user.get(username).put(contest, points);
                } else {
                    int currentPoints = user.get(username).get(contest);
                    if (points > currentPoints) {
                        user.get(username).put(contest, points);
                    }
                }
            }

            input = scanner.nextLine();
        }

        int bestSum = 0;
        String bestCandidate = "";

        for (Map.Entry<String, LinkedHashMap<String, Integer>> k : user.entrySet()) {
            int sum = 0;
            for (Map.Entry<String, Integer> v : k.getValue().entrySet()) {
                int currentNumber = v.getValue();
                sum = sum + currentNumber;
            }
            if (sum > bestSum) {
                bestSum = sum;
                bestCandidate = k.getKey();
            }
        }
        System.out.printf("Best candidate is %s with total %d points.%n", bestCandidate, bestSum);

        System.out.println("Ranking: ");
        user.
                forEach((k, v) -> {
                    System.out.println(k);
                    v.entrySet()
                            .stream()
                            .sorted((a, b) ->
                                    b.getValue().compareTo(a.getValue()))
                            .forEach(e -> System.out.printf("#  %s -> %d%n", e.getKey(), e.getValue()));

                });


    }
}




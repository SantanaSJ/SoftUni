package Fundamentals;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Scanner;

public class MobaChallenger {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, LinkedHashMap<String, Integer>> info = new LinkedHashMap<>();
        String lines = scanner.nextLine();
        while (!lines.equals("Season end")) {
            if (lines.contains("->")) {
                String[] parts = lines.split(" -> ");
                String name = parts[0];
                String position = parts[1];
                int skill = Integer.parseInt(parts[2]);
//
                if (!info.containsKey(name)) {
                    info.put(name, new LinkedHashMap<>());
                    info.get(name).put(position, skill);
                } else {
                    if (!info.get(name).containsKey(position)) {
                        info.get(name).put(position, skill);
                    } else {
                        int currentSkill = info.get(name).get(position);
                          info.get(name).put(position, (Math.max(skill, currentSkill)));
                    }
                }
            } else {
                String[] parts = lines.split(" vs ");
                String player1 = parts[0];
                String player2 = parts[1];

                if (info.containsKey(player1) && info.containsKey(player2)) {
                    boolean areTheSame = false;
                    for (String s1 : info.get(player1).keySet()) {
                        for (String s2 : info.get(player2).keySet()) {
                            if (s1.equals(s2)) {
                                areTheSame = true;
                                break;
                            }
                        }
                    }
                    if (areTheSame) {
                        int sum1 = info.get(player1).values()
                                .stream().mapToInt(i -> i).sum();
                        int sum2 = info.get(player2).values()
                                .stream().mapToInt(i -> i).sum();
                        if (sum1 > sum2) {
                            info.remove(player2);
                        } else if (sum2 > sum1) {
                            info.remove(player1);
                        }
                    }
                }
            }
            lines = scanner.nextLine();
        }

        info.entrySet()
                .stream()
                .sorted((a, b) -> {
                    int sum1 = a.getValue().values().stream().mapToInt(i -> i).sum();
                    int sum2 = b.getValue().values().stream().mapToInt(i -> i).sum();
                    int result = Integer.compare(sum2, sum1);
                    if (result == 0) {
                       result = a.getKey().compareTo(b.getKey());
                    }
                    return result;
                })
                .forEach(key -> {
                    System.out.printf("%s: %d skill%n", key.getKey(),
                            key.getValue().values().stream().mapToInt(i -> i).sum());
                    key.getValue()
                            .entrySet()
                            .stream()
                            .sorted((a, b) -> {
                                int result = b.getValue().compareTo(a.getValue());
                                if (result == 0) {
                                    result = a.getKey().compareTo(b.getKey());
                                }
                                return result;
                            })
                            .forEach(k -> System.out.printf("- %s <::> %d%n", k.getKey(), k.getValue()));
                });






    }
}

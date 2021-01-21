package Advanced.SetsAndMaps;

import java.util.*;

public class CitiesByContinentAndCountry {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int n = Integer.parseInt(scanner.nextLine());

        Map<String, Map<String, List<String>>> info = new LinkedHashMap<>();

        while (n-- > 0) {
            String[] tokens = scanner.nextLine().split(" ");
            String continent = tokens[0];
            String country = tokens[1];
            String city = tokens[2];

            info.putIfAbsent(continent, new LinkedHashMap<>());
            info.get(continent).putIfAbsent(country, new ArrayList<>());
            info.get(continent).get(country).add(city);

        }
        info
                .forEach((key, value) -> {
                    System.out.println(key + ":");
                    value
                            .forEach((k, v) ->
                                    System.out.printf("  %s -> %s %n", k,
                                            String.join(", ", v)));
                });
    }
}



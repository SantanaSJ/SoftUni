package Fundamentals;

import java.util.*;

public class PlantDiscovery {
    public static class Plant {

        String name;
        int rarity;
        List<Double> ratings;

        public Plant(String name, int rarity) {
            this.name = name;
            this.rarity = rarity;
            this.ratings = new ArrayList<>();//сетваме листа да е на 0
        }

        public String getName() {
            return name;
        }

        public void addRating(double rating) {
            this.ratings.add(rating);
        }

        public void setRarity(int rarity) {
            this.rarity = rarity;
        }

        public void resetRating() {
            this.ratings.clear();
        }

        public int getRarity() {
            return rarity;
        }

        public double getAverageRating() {
            if (this.ratings.isEmpty()) {
                return 0;
            }
            double averageRating = 0;
            for (Double rating : this.ratings) {
                averageRating = averageRating + rating;
            }
            averageRating = averageRating / this.ratings.size();
            return averageRating;

        }
    }


    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, Plant> plantsByName = new HashMap<>();
        int n = Integer.parseInt(scanner.nextLine());

        for (int i = 0; i < n; i++) {
            String[] nameAndRarity = scanner.nextLine().split("<->");
            String name = nameAndRarity[0];
            int rarity = Integer.parseInt(nameAndRarity[1]);
            Plant p = new Plant(name, rarity);
            plantsByName.put(p.getName(), p);
        }

        String command = scanner.nextLine();
        while (!command.equals("Exhibition")) {
            String[] commandAndParameters = command.split(": ");
            switch (commandAndParameters[0]) {
                case "Rate":
                    String[] rateParameters = commandAndParameters[1].split(" - ");
                    String ratePlantName = rateParameters[0];
                    int rating = Integer.parseInt(rateParameters[1]);

                    Plant ratePlant = plantsByName.get(ratePlantName);
                    if (ratePlant != null) {
                        ratePlant.addRating(rating);
                    } else {
                        System.out.println("error");
                    }

                    break;
                case "Update":
                    String[] updateParameters = commandAndParameters[1].split(" - ");
                    String updatePlantName = updateParameters[0];
                    int rarity = Integer.parseInt(updateParameters[1]);

                    Plant updatePlant = plantsByName.get(updatePlantName);
                    if (updatePlant != null) {
                        updatePlant.setRarity(rarity);
                    } else {
                        System.out.println("error");
                    }
                    break;
                case "Reset":
                    String resetPlantName = commandAndParameters[1];

                    Plant resetPlant = plantsByName.get(resetPlantName);
                    if (resetPlant != null) {
                        resetPlant.resetRating();
                    } else {
                        System.out.println("error");
                    }
                    break;
                default:
                    System.out.println("error");
                    break;
            }

            command = scanner.nextLine();
        }
        System.out.println("Plants for the exhibition:");

        plantsByName.values()
                .stream()
                .sorted((a, b) -> {
                    if (a.getRarity() != b.getRarity()) {
                        return Integer.compare(b.getRarity(), a.getRarity());
                    } else {
                        return Double.compare(b.getAverageRating(), a.getAverageRating());
                    }
                })
                .map(p -> "- "
                        + p.getName()
                        + "; Rarity: "
                        + p.getRarity()
                        + "; Rating: "
                        + String.format("%.2f", p.getAverageRating()))
                .forEach(s -> System.out.println(s));


    }
}






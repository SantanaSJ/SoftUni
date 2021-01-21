package Advanced.SetsAndMaps;

import java.util.*;


public class AverageStudentGrades {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int n = Integer.parseInt(scanner.nextLine());

        Map<String, List<Double>> info = new TreeMap<>();

        for (int i = 0; i < n; i++) {
            String[] input = scanner.nextLine().split(" ");
            String name = input[0];
            Double grade = Double.parseDouble(input[1]);

            if (!info.containsKey(name)) {
                info.put(name, new ArrayList<>());
            }
            info.get(name).add(grade);
        }

        info.forEach((key, value) -> {
            System.out.print(key + " -> ");
            double sum = 0;
            for (Double grade : value) {
                System.out.printf("%.2f ", grade);
                sum = sum + grade;
            }
            double average = sum / value.size();

            System.out.printf("(avg: %.2f)%n", average);
        });
    }
}



package OOP.borderControl;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        List<Identifiable> list = new ArrayList<>();

        String input = scanner.nextLine();
        while (!input.equals("End")) {
            String[] info = input.split("\\s+");
            if (info.length == 3) {
                String name = info[0];
                int age = Integer.parseInt(info[1]);
                String id = info[2];
                Citizen citizen = new Citizen(name, age, id);
                list.add(citizen);

            } else if (info.length == 2) {
                String model = info[0];
                String id = info[1];

                Robot robot = new Robot(model, id);
                list.add(robot);
            }
            input = scanner.nextLine();
        }

        String lastDigits = scanner.nextLine();

        for (Identifiable identifiable : list) {
            String id = identifiable.getId();
            String substring = id.substring(id.length() - 3);
            if (lastDigits.equals(substring)) {
                System.out.println(id);
            }
        }


    }
}

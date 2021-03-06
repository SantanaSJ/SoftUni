package OOP.animals;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);


        List<Animal> animalList = new ArrayList<>();

        String typeOfAnimal = scanner.nextLine();
        while (!typeOfAnimal.equals("Beast!")) {
            String[] animalInfo = scanner.nextLine().split("\\s+");
            String name = animalInfo[0];
            int age = Integer.parseInt(animalInfo[1]);
            String gender = animalInfo[2];

            Animal animal = null;

            try {
                switch (typeOfAnimal) {
                    case "Cat":
                        animal = new Cat(name, age, gender);
                        break;
                    case "Dog":
                        animal = new Dog(name, age, gender);
                        break;
                    case "Frog":
                        animal = new Frog(name, age, gender);
                        break;
                    case "Kittens":
                        animal = new Kitten(name, age);
                        break;
                    case "Tomcat":
                        animal = new Tomcat(name, age);
                        break;
                }


            } catch (IllegalArgumentException exception) {
                System.out.println(exception.getMessage());
            }
            animalList.add(animal);

            typeOfAnimal = scanner.nextLine();
        }
        animalList.forEach(a -> System.out.println(a));

    }
}

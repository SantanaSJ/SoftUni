package Advanced.FunctionalProgramming;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.function.Consumer;
import java.util.function.Predicate;

public class FilterByAge {


    public static class Person {
        private String name;
        private int age;

        public Person(String name, int age) {
            this.name = name;
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public int getAge() {
            return age;
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int n = Integer.parseInt(scanner.nextLine());

        List<Person> people = new ArrayList<>();

        while (n-- > 0) {
            getInfo(scanner, people);
        }

        String condition = scanner.nextLine();
        int age = Integer.parseInt(scanner.nextLine());
        String printCondition = scanner.nextLine();


        Predicate<Person> personPredicate = getPersonPredicate(condition, age);


        Consumer<Person> printPerson = printPerson(printCondition);

        people
                .stream()
                .filter(personPredicate)
                .forEach(printPerson);


    }

    private static Consumer<Person> printPerson(String condition) {
        switch (condition) {
            case "name":
                return person -> System.out.println(person.getName());
            case "age":
                return person -> System.out.println(person.getAge());
            default:
                return person -> System.out.println(person.getName() + " - " + person.getAge());
        }

    }

    private static Predicate<Person> getPersonPredicate(String condition, int age) {
        Predicate<Person> personPredicate = null;
        switch (condition) {
            case "older":
                return personPredicate = person -> person.getAge() >= age;
            case "younger":
                return personPredicate = person -> person.getAge() <= age;
        }
        return personPredicate;
    }

    private static void getInfo(Scanner scanner, List<Person> people) {
        String[] parts = scanner.nextLine().split(", ");
        String name = parts[0];
        int age = Integer.parseInt(parts[1]);

        Person person = new Person(name, age);
        people.add(person);
    }


}


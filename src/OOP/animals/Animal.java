package OOP.animals;

public class Animal {
    private String name;
    private int age;
    private String gender;

    public Animal(String name, int age, String gender) {
        setName(name);
        setAge(age);
        setGender(gender);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getGender() {
        return gender;
    }

    private void setGender(String gender) {
        if (gender == null) {
            throw new IllegalArgumentException("Invalid input!");
        }
        this.gender = gender;
    }

    private void setAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("Invalid input!");
        }
        this.age = age;
    }

    private void setName(String name) {
        if (name == null) {
            throw new IllegalArgumentException("Invalid input!");
        }
        this.name = name;
    }

    public String produceSound() {
        return "";
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(this.getClass().getSimpleName());
        sb.append(System.lineSeparator());
        sb.append(String.format("%s %d %s%n%s",
                this.name, this.age, this.gender, this.produceSound()));
        return sb.toString().trim();
    }
}

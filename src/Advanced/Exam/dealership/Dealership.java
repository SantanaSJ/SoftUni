package Advanced.Exam.dealership;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Dealership {
    private String name;
    private int capacity;
    private List<Car> data;

    public Dealership(String name, int capacity) {
        this.name = name;
        this.capacity = capacity;
        this.data = new ArrayList<>();
    }

    public void add(Car car) {
        if (capacity > this.data.size()) {
            this.data.add(car);
        }
    }

    public boolean buy(String manufacturer, String model) {
        int indexToRemove = -1;

        for (int i = 0; i < this.data.size(); i++) {
            Car car = this.data.get(i);
            if (car.getManufacturer().equals(manufacturer) && car.getModel().equals(model)) {
                indexToRemove = i;
            }
        }
        if (indexToRemove != -1) {
            this.data.remove(indexToRemove);
            return true;
        }
        return false;
    }

    public Car getLatestCar() {
        return this.data.stream().max(Comparator.comparing(c -> c.getYear())).orElse(null);
    }

    public Car getCar(String manufacturer, String model) {
        for (Car car : this.data) {
            if (car.getManufacturer().equals(manufacturer) && car.getModel().equals(model)) {
                return car;
            }
        }
        return null;
    }

    public int getCount() {
        return this.data.size();
    }

    public String getStatistics() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("The cars are in a car dealership %s:", this.name))
                .append(System.lineSeparator());
        for (Car car : this.data) {
            sb.append(car.toString()).append(System.lineSeparator());
        }
        return sb.toString().trim();
    }
}

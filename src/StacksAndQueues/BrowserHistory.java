package StacksAndQueues;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Scanner;

public class BrowserHistory {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);


        Deque<String> history = new ArrayDeque<>();

        while (true) {
            String input = scanner.nextLine();
            String currentURL;
            switch (input) {
                case "back":
                    if (history.size() > 1) {
                        history.pop();
                        currentURL = history.peek();
                    } else {
                        currentURL = "no previous URLs";
                    }
                    break;
                case "Home":
                    return;
                default:
                    history.push(input);
                    currentURL = input;
            }
            System.out.println(currentURL);
        }

    }
}

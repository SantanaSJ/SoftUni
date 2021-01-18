package Advanced.StacksAndQueues;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Scanner;

public class BrowserHistoryUpgrade {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Deque<String> history = new ArrayDeque<>();
        Deque<String> forward = new ArrayDeque<>();


        while (true) {
            String input = scanner.nextLine();
            String currentURL;
            String forwardURL;
            switch (input) {
                case "back":
                    if (history.size() > 1) {
                        forwardURL = history.pop();
                        forward.push(forwardURL);
                        currentURL = history.peek();
                        System.out.println(currentURL);

                    } else {
                        System.out.println("no previous URLs");
                    }
                    break;
                case "forward":
                    if (forward.size() > 0) {
                        currentURL = forward.pop();
                        System.out.println(currentURL);
                        history.push(currentURL);
                    } else {
                        System.out.println("no next URLs");
                    }

                    break;
                case "Home":
                    return;
                default:
                    history.push(input);
                    System.out.println(input);
                    forward.clear();
            }

        }
    }
}

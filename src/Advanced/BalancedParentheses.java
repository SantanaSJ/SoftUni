package Advanced;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Scanner;

public class BalancedParentheses {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        Deque<String> stack = new ArrayDeque<>();

        String[] parentheses = scanner.nextLine().split("");


        boolean isValid = true;
        for (String currentP : parentheses) {
            switch (currentP) {
                case "{":
                case "(":
                case "[":
                    stack.push(currentP);
                    break;
                case ")":
                case "]":
                case "}":
                    if (stack.isEmpty()) {
                        isValid = false;
                    } else {
                        String stackP = stack.peek();
                        if (!(currentP.equals(")") && stackP.equals("(")
                                || currentP.equals("]") && stackP.equals("[")
                                || currentP.equals("}") && stackP.equals("{"))) {

                            isValid = false;
                        } else {
                            stack.pop();
                        }
                    }
            }
        }
        if (isValid) {
            System.out.println("YES");
        } else {
            System.out.println("NO");
        }
    }
}


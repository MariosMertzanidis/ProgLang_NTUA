import java.util.*;

public class ZtalocState implements State {


      private char move;
      private int num1, num2;
      private State previous;

      public ZtalocState(char m, int n1, int n2, State p) {
        move = m;
        num1 = n1;
        num2 = n2;
        previous = p;
      }

      @Override
      public boolean isFinal(int goal1, int goal2) {
        return num1>=goal1 && num2<=goal2;
      }

      @Override
      public boolean isBad() {
          return num2>=1000000;
      }

      @Override
      public Collection<State> next() {
        Collection<State> states = new ArrayList<>();
        states.add(new ZtalocState('h', num1/2, num2/2, this));
        states.add(new ZtalocState('t', num1*3+1, num2*3+1, this));
        return states;
      }

      @Override
      public State getPrevious() {
        return previous;
      }

      @Override
      public char getChar() {
        return move;
      }

      @Override
      public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ZtalocState other = (ZtalocState) o;
        return num1 == other.num1 && num2 == other.num2;
      }

      @Override
      public int hashCode() {
        return Objects.hash(num1,num2);
      }

}

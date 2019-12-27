import java.util.Collection;

public interface State {

      public boolean isFinal(int goal1, int goal2);

      public boolean isBad();

      public Collection<State> next();

      public char getChar();

      public State getPrevious();
}

import java.util.*;

public interface State {

public int getPosition();

public char getChar();

public int getTime(ArrayList<Integer> waters);

public boolean isBad(ArrayList<Integer> waters, int m, int n);

public Collection<State> next(int m);

public State getPrevious();

    }


import java.util.*;

public class catState implements State {

private int position;

private int time;

private char previous;

private State prevPosition;

public catState(int pos,int t, char prev, State prevP) {
position = pos; time = t; previous = prev; prevPosition = prevP;
}

@Override
public int getPosition(){
 return position;
}

@Override
public int getTime(ArrayList<Integer> waters) {
 return waters.get(position);
}

@Override
public char getChar() {
 return previous;
}

@Override
public boolean isBad(ArrayList<Integer> waters, int m, int n) {

 if(previous=='L' && (position+1)%m==0)  return true;

 if(previous=='R' && position%m==0) return true;

 if(position<0) return true;

 if(position>=(n*m)) return true;

 if(time>=waters.get(position))  return true;

 return false;

}

@Override
public Collection<State> next(int m) {
Collection<State> states = new ArrayList<>();
states.add(new catState(position+m, time+1, 'D', this));
states.add(new catState(position-1, time+1, 'L', this));
states.add(new catState(position+1, time+1, 'R', this));
states.add(new catState(position-m, time+1, 'U', this));
return states;
}

@Override
public State getPrevious() {
return prevPosition;
}

@Override
public boolean equals(Object o) {
if (this == o) return true;
if (o == null || getClass() != o.getClass()) return false;
catState other = (catState) o;
return position == other.position ;
}


@Override
public int hashCode() {
return Objects.hash(position);
}

}

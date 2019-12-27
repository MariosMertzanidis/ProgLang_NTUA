import java.util.*;

public class BFSsolver implements Solver {

      @Override
      public State solve (State initial, int goal1, int goal2) {
          int a=0;
        Set<State> seen = new HashSet<>();
        Queue<State> remaining = new ArrayDeque<>();
        remaining.add(initial);
        seen.add(initial);
        while (!remaining.isEmpty()) {
          State s = remaining.remove();
          if (s.isFinal(goal1, goal2)) return s;
          if (a>1000000) return null;
          a++;
          for (State n : s.next())
            if (!seen.contains(n) && !n.isBad()){
              remaining.add(n);
              seen.add(n);
            }
        }
        return null;
      }

}

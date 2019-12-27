import java.util.*;


public class BFSolver implements Solver {
      @Override
      public State solve (State initial, ArrayList<Integer> waters, int m, int n) {
        Set<State> seen = new HashSet<>();
        State best = initial;
        Queue<State> remaining = new ArrayDeque<>();
        remaining.add(initial);
        seen.add(initial);
        while (!remaining.isEmpty()) {
          State s = remaining.remove();
          for (State j : s.next(m))
            if (!seen.contains(j) && !j.isBad(waters, m, n)){
              remaining.add(j);
              seen.add(j);
              if (j.getTime(waters)>best.getTime(waters)) {
            	  best=j;
              }else if(j.getTime(waters)==best.getTime(waters) && j.getPosition()<best.getPosition()) {
            	  best=j;
              }
            }
        }
        return best;
      }
    }

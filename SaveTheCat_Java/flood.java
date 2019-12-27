import java.util.*;

public class flood {

    public ArrayList<Integer> fill (ArrayList<Integer> waters, Queue<Integer> remaining, int m, int n){
        while(!remaining.isEmpty()) {
            int curr = remaining.remove();
            int num = waters.get(curr);
            if (curr+m <= n*m-1) {
                if (waters.get(curr+m)==n*m) {
                    waters.set(curr+m, num+1);
                    remaining.add(curr+m);
                }
            }
            if (curr%m != m-1) {
                if (waters.get(curr+1)==n*m) {
                    waters.set(curr+1, num+1);
                    remaining.add(curr+1);
                }
            }
            if (curr-m >= 0 ) {
                if (waters.get(curr-m)==n*m) {
                    waters.set(curr-m, num+1);
                    remaining.add(curr-m);
                }
            }
            if (curr%m != 0) {
                if (waters.get(curr-1)==n*m) {
                    waters.set(curr-1, num+1);
                    remaining.add(curr-1);
                }
            }
        }
        return waters;
    }

}

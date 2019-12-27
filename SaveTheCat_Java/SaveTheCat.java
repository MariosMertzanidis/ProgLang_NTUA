import java.util.*;
import java.io.*;
import java.nio.charset.*;


public class SaveTheCat {

    public static void main(String args[]) throws FileNotFoundException, IOException{

        File file = new File(args[0]);
        BufferedReader reader = new BufferedReader( // From-> https://stackoverflow.com/questions/811851/how-do-i-read-input-character-by-character-in-java
                new InputStreamReader(
                    new FileInputStream(file),
                    Charset.forName("UTF-8")));


        char temp = (char) reader.read();
        ArrayList<Character> basement = new ArrayList<>() ;
        ArrayList<Integer> waters = new ArrayList<>() ;
        Queue<Integer> remaining = new ArrayDeque<>();
        basement.add(temp);
        int total=0;
        int n=0;
        int index;

        while((index = reader.read()) != -1) {
            temp = (char) index;
            if(temp=='\n') {
                n++;
            }else {
                basement.add(temp);
                total++;
            }
        }
        int m=(total+1)/n;
        int cat=0;

        for(int i=0; i<=total; i++) {
            temp=basement.get(i);
            if(temp == 'X' || temp == 'W' ) {
                waters.add(0);
            }else {
                waters.add(n*m);
            }
            if(temp=='A') { cat=i;}
            if(temp=='W') { remaining.add(i);}
        }
        basement=null;

        flood fl = new flood();
        waters= fl.fill(waters, remaining, m, n);

        Solver solver = new BFSolver();
        State initial = new catState(cat, 0, '\n', null);
        State result = solver.solve(initial, waters, m, n);
        if(result.getTime(waters)==n*m) {
        	System.out.println("infinity");
        }else {
        	System.out.println(result.getTime(waters)-1);
        }
        if (result == initial) {
          System.out.println("stay");
        } else {
          printSolution(result);
        }

        reader.close();
      }


      private static void printSolution(State s) {
        if (s.getPrevious().getPrevious() != null) {
          printSolution(s.getPrevious());
        }
        System.out.print(s.getChar());
      }

}

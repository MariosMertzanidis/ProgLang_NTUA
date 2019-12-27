import java.util.Scanner;
import java.io.*;

public class Ztalloc  {

    public static void main(String args[]) throws FileNotFoundException{

        File file = new File(args[0]);
        Scanner obj = new Scanner(file);


        int a = obj.nextInt();

        for(int i=0; i<a; i++) {


            Solver solver = new BFSsolver();
            int Lin= obj.nextInt();
            int Rin= obj.nextInt();
            int Lout= obj.nextInt();
            int Rout= obj.nextInt();

            if(Lin<Lout || Rin>Rout) {
                State initial = new ZtalocState('0', Lin, Rin, null);
                State result = solver.solve(initial, Lout, Rout);
                if (result == null) {
                  System.out.print("IMPOSSIBLE");
                } else {
                  printSolution(result);
                }
            }else {
            	System.out.print("EMPTY");
            }
            System.out.print('\n');
        }

        obj.close();
    }

      private static void printSolution(State s) {
        if (s.getPrevious().getPrevious() != null) {
          printSolution(s.getPrevious());
        }
        System.out.print(s.getChar());
      }


}

datatype Mtree = Empty | Node of int*Mtree*Mtree*Mtree*Mtree*Mtree*Mtree*Mtree*Mtree*Mtree*Mtree;

fun update(Empty) = Node(1,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty)
  | update(Node(n,a,b,c,d,e,f,g,h,i,j))=Node(n+1,a,b,c,d,e,f,g,h,i,j)

 fun insert(tr,num,0)=tr
      | insert(Node(n,a,b,c,d,e,f,g,h,i,j),num,k)= case (num mod Int.toLarge(10)) of
                                                  0 => Node(n,insert(update(a),num div Int.toLarge(10),k-1),b,c,d,e,f,g,h,i,j)
                                                  |1=> Node(n,a,insert(update(b),num div Int.toLarge(10),k-1),c,d,e,f,g,h,i,j)
                                                  |2=> Node(n,a,b,insert(update(c),num div Int.toLarge(10),k-1),d,e,f,g,h,i,j)
                                                  |3=> Node(n,a,b,c,insert(update(d),num div Int.toLarge(10),k-1),e,f,g,h,i,j)
                                                  |4=> Node(n,a,b,c,d,insert(update(e),num div Int.toLarge(10),k-1),f,g,h,i,j)
                                                  |5=> Node(n,a,b,c,d,e,insert(update(f),num div Int.toLarge(10),k-1),g,h,i,j)
                                                  |6=> Node(n,a,b,c,d,e,f,insert(update(g),num div Int.toLarge(10),k-1),h,i,j)
                                                  |7=> Node(n,a,b,c,d,e,f,g,insert(update(h),num div Int.toLarge(10),k-1),i,j)
                                                  |8=> Node(n,a,b,c,d,e,f,g,h,insert(update(i),num div Int.toLarge(10),k-1),j)
                                                  |9=> Node(n,a,b,c,d,e,f,g,h,i,insert(update(j),num div Int.toLarge(10),k-1));

fun numb(Empty)=Int.toLarge(0)|numb(Node(n,a,b,c,d,e,f,g,h,i,j))=Int.toLarge(n);

fun numWin(Node(n,a,b,c,d,e,f,g,h,i,j),num)=  case Int.fromLarge(num) of
                                            0 => numb(a)
                                            |1=> numb(b)
                                            |2=> numb(c)
                                            |3=> numb(d)
                                            |4=> numb(e)
                                            |5=> numb(f)
                                            |6=> numb(g)
                                            |7=> numb(h)
                                            |8=> numb(i)
                                            |9=> numb(j);

                                            fun totalWins(Node(n,a,b,c,d,e,f,g,h,i,j),num,k,priv,total)= case (num mod Int.toLarge(10)) of
                                                                                         0=> if numb(a)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                            else totalWins(a,num div Int.toLarge(10),k+1,numb(a),(total+(priv-numb(a))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |1=> if numb(b)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(b,num div Int.toLarge(10),k+1,numb(b),(total+(priv-numb(b))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |2=> if numb(c)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(c,num div Int.toLarge(10),k+1,numb(c),(total+(priv-numb(c))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |3=> if numb(d)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(d,num div Int.toLarge(10),k+1,numb(d),(total+(priv-numb(d))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |4=> if numb(e)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(e,num div Int.toLarge(10),k+1,numb(e),(total+(priv-numb(e))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |5=> if numb(f)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(f,num div Int.toLarge(10),k+1,numb(f),(total+(priv-numb(f))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |6=> if numb(g)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(g,num div Int.toLarge(10),k+1,numb(g),(total+(priv-numb(g))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |7=> if numb(h)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(h,num div Int.toLarge(10),k+1,numb(h),(total+(priv-numb(h))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |8=> if numb(i)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(i,num div Int.toLarge(10),k+1,numb(i),(total+(priv-numb(i))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7))
                                                                                        |9=> if numb(j)=0 then (total+priv*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7)
                                                                                           else totalWins(j,num div Int.toLarge(10),k+1,numb(j),(total+(priv-numb(j))*(IntInf.pow(2,k)-1)) mod (IntInf.pow(Int.toLarge(10),9)+7));


                                               fun readint(infile : string) = let
                                                       val ins = TextIO.openIn infile

                                                   fun helper(ins,tr,K,N,Q,counter)  =
                                                       case TextIO.scanStream( IntInf.scan StringCvt.DEC) ins of
                                                   SOME input => if counter>2 andalso counter<N+3 then helper(ins,insert(tr,input,K),K,N,Q,counter+1)
                                                              else (print(IntInf.toString(numWin(tr,(input mod 10)))^" "^IntInf.toString(totalWins(tr,input,0,0,0))^"\n");helper(ins,tr,K,N,Q,counter+1))
                                                   | NONE => TextIO.closeIn ins

                                                   fun help(ins,tr,K,N,Q,counter)=
                                                   case TextIO.scanStream( Int.scan StringCvt.DEC) ins of
                                                   SOME input=>  if counter=0 then help(ins,tr,input,N,Q,1)
                                                                else if counter=1 then help(ins,tr,K,input,Q,2)
                                                                  else helper(ins,tr,K,N,input,3)

                                                   |NONE => print("File error");
                                                         in
                                                help(ins,Node(~1,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty),0,0,0,0)
                                                 end;

                                                 fun lottery a= readint(a);
        

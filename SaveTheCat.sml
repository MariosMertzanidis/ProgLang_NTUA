local

fun dsm (m,x,y)= x*m+y

fun msd(m,w)= (w div m, w mod m)

fun first (a,b) = a

fun second (a,b) = b

structure M = RedBlackMapFn(struct
        type ord_key = int
    	val compare = Int.compare
  	end)

fun move((map,map_num,que),mo,counter)=
    if ((valOf(M.find(map,(Queue.head que)+mo)) = ".")  orelse  (valOf(M.find(map,(Queue.head que)+mo)) = "A")) then
        if  Queue.enqueue(que,(Queue.head que)+mo)=() then (M.insert(map, (Queue.head que)+mo,"W"),M.insert(map_num, (Queue.head que)+mo,counter),que)
        else (map,M.insert(map_num,(Queue.head que)+ mo, 0),que)
    else if (valOf(M.find(map,(Queue.head que)+mo)) = "W") then (map,map_num,que)
    else (map,M.insert(map_num,(Queue.head que)+ mo, 0),que)

fun rm(map,map_num,que)=if Queue.dequeue que > ~1 then
             if Queue.isEmpty que then (map,map_num,que,1)
             else (map,map_num,que,valOf(M.find(map_num,Queue.head(que)))+1)
            else rm(map,map_num,que)



fun flood((map,map_num,que,counter),m,n)=if Queue.isEmpty que then map_num
                    else
                        if (first(msd(m,Queue.head que))=0  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0)   then flood(rm(move(move(move((map,map_num,que),1,counter),m,counter),~1,counter)),m,n)
                        else if (first(msd(m,Queue.head que))=n-1  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0) then  flood(rm(move(move(move((map,map_num,que),1,counter),~m,counter),~1,counter)),m,n)
                        else if (second(msd(m,Queue.head que))=0 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  flood(rm(move(move(move((map,map_num,que),1,counter),m,counter),~m,counter)),m,n)
                        else if (second(msd(m,Queue.head que))=m-1 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  flood(rm(move(move(move((map,map_num,que),~m,counter),m,counter),~1,counter)),m,n)
                        else if (first(msd(m,Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=m-1) then  flood(rm(move(move((map,map_num,que),~m,counter),~1,counter)),m,n)
                        else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=m-1) then  flood(rm(move(move((map,map_num,que),m,counter),~1,counter)),m,n)
                        else if (first(msd(m, Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=0) then  flood(rm(move(move((map,map_num,que),~m,counter),1,counter)),m,n)
                        else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=0) then  flood(rm(move(move((map,map_num,que),m,counter),1,counter)),m,n)
                        else  flood(rm(move(move(move(move((map,map_num,que),~m,counter),1,counter),m,counter),~1,counter)),m,n)


fun move_g((map,map_num,gnum,map_string, que,max,thesi_max),mo,counter,m)=
let
val water_time=valOf(M.find(map_num,(Queue.head que)+mo))
val cur_str=valOf(M.find(map,(Queue.head que)+mo))
in
    if (cur_str<> "X" andalso cur_str<>"A") then
        if (counter<water_time) then
            if (Queue.enqueue(que,(Queue.head que)+mo)=() andalso (water_time-1>max)) then
                if mo=1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"R"),que,water_time-1,(Queue.head que)+mo)
                else if mo=(~1) then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"L"),que,water_time-1,(Queue.head que)+mo)
                else if mo>1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"D"),que,water_time-1,(Queue.head que)+mo)
                else (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"U"),que,water_time-1,(Queue.head que)+mo)
            else
                if (water_time-1=max andalso Queue.head que+mo<thesi_max) then
                    if mo=1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"R"),que,max,(Queue.head que)+mo)
                    else if mo=(~1) then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"L"),que,max,(Queue.head que)+mo)
                    else if mo>1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"D"),que,max,(Queue.head que)+mo)
                    else (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"U"),que,max,(Queue.head que)+mo)
                else
                    if mo=1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"R"),que,max,thesi_max)
                    else if mo=(~1) then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"L"),que,max,thesi_max)
                    else if mo>1 then (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"D"),que,max,thesi_max)
                    else (M.insert(map,(Queue.head que)+mo,"A"),map_num,M.insert(gnum,(Queue.head que)+mo,counter),M.insert(map_string,(Queue.head que)+mo,"U"),que,max,thesi_max)
        else (map,map_num,gnum,map_string, que,max,thesi_max)
    else (map,map_num,gnum,map_string, que,max,thesi_max)
    end


fun rm_g  (map,map_num,gnum,map_string, que,max,thesi_max) =if (Queue.dequeue que > ~10)  then
                         if Queue.isEmpty que then (map,map_num,gnum,map_string, que,max,thesi_max,1)
             			 else (map,map_num,gnum, map_string, que, max,thesi_max,valOf(M.find(gnum,Queue.head que))+1)
                             else (map,map_num,gnum,map_string, que,max,thesi_max,1)

fun gatez ((map,map_num,gnum,map_string,que,max,thesi_max,counter),m,n)= if Queue.isEmpty que then (max,thesi_max,map_string)
                               else
                                if (first(msd(m,Queue.head que))=0  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0)   then gatez(rm_g(move_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),~1,counter,m),1,counter,m)),m,n)
                                else if (first(msd(m,Queue.head que))=n-1  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0) then  gatez(rm_g(move_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),~1,counter,m),1,counter,m),~m,counter,m)),m,n)
                                else if (second(msd(m,Queue.head que))=0 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  gatez(rm_g(move_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),1,counter,m),~m,counter,m)),m,n)
                                else if (second(msd(m,Queue.head que))=m-1 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  gatez(rm_g(move_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),~1,counter,m),~m,counter,m)),m,n)
                                else if (first(msd(m,Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=m-1) then  gatez(rm_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),~1,counter,m),~m,counter,m)),m,n)
                                else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=m-1) then  gatez(rm_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),~1,counter,m)),m,n)
                                else if (first(msd(m, Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=0) then  gatez(rm_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),1,counter,m),~m,counter,m)),m,n)
                                else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=0) then  gatez(rm_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),1,counter,m)),m,n)
                                else  gatez(rm_g(move_g(move_g(move_g(move_g((map,map_num,gnum,map_string, que,max,thesi_max),m,counter,m),~1,counter,m),1,counter,m),~m,counter,m)),m,n)


                                fun move_gs((map,map_string, que,thesi_max),mo,m)=
                                let
                                val cur_str=valOf(M.find(map,(Queue.head que)+mo))
                                in
                                    if (cur_str<> "X" andalso cur_str<>"A") then
                                            if (Queue.enqueue(que,(Queue.head que)+mo)=() andalso Queue.head que+mo<thesi_max) then
                                                if mo=1 then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"R"),que,(Queue.head que)+mo)
                                                else if mo=(~1) then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"L"),que,(Queue.head que)+mo)
                                                else if mo>1 then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"D"),que,(Queue.head que)+mo)
                                                else (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"U"),que,(Queue.head que)+mo)
                                            else
                                                    if mo=1 then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"R"),que,thesi_max)
                                                    else if mo=(~1) then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"L"),que,thesi_max)
                                                    else if mo>1 then (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"D"),que,thesi_max)
                                                    else (M.insert(map,(Queue.head que)+mo,"A"),M.insert(map_string,(Queue.head que)+mo,"U"),que,thesi_max)
                                    else (map,map_string, que,thesi_max)
                                    end


                                fun rm_gs  (map,map_string, que,thesi_max) =if (Queue.dequeue que > ~10)  then
                                                         if Queue.isEmpty que then (map,map_string, que,thesi_max)
                                             			 else (map, map_string, que,thesi_max)
                                                             else (map,map_string, que,thesi_max)

                                fun gates ((map,map_string,que,thesi_max),m,n)= if Queue.isEmpty que then (n*m+1,thesi_max,map_string)
                                                               else
                                                                if (first(msd(m,Queue.head que))=0  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0)   then gates(rm_gs(move_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),~1,m),1,m)),m,n)
                                                                else if (first(msd(m,Queue.head que))=n-1  andalso second(msd(m,Queue.head que))<>m-1 andalso second(msd(m,Queue.head que))<>0) then  gates(rm_gs(move_gs(move_gs(move_gs((map,map_string, que,thesi_max),~1,m),1,m),~m,m)),m,n)
                                                                else if (second(msd(m,Queue.head que))=0 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  gates(rm_gs(move_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),1,m),~m,m)),m,n)
                                                                else if (second(msd(m,Queue.head que))=m-1 andalso first(msd(m,Queue.head que))<>n-1 andalso first(msd(m,Queue.head que))<>0) then  gates(rm_gs(move_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),~1,m),~m,m)),m,n)
                                                                else if (first(msd(m,Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=m-1) then  gates(rm_gs(move_gs(move_gs((map,map_string, que,thesi_max),~1,m),~m,m)),m,n)
                                                                else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=m-1) then  gates(rm_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),~1,m)),m,n)
                                                                else if (first(msd(m, Queue.head que))=n-1 andalso second(msd(m,Queue.head que))=0) then  gates(rm_gs(move_gs(move_gs((map,map_string, que,thesi_max),1,m),~m,m)),m,n)
                                                                else if (first(msd(m,Queue.head que))=0 andalso second(msd(m,Queue.head que))=0) then  gates(rm_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),1,m)),m,n)
                                                                else  gates(rm_gs(move_gs(move_gs(move_gs(move_gs((map,map_string, que,thesi_max),m,m),~1,m),1,m),~m,m)),m,n)

local

fun str((thesi,map_string),ap,m) =
let
val temp_string=valOf(M.find(map_string,thesi))
in
        if temp_string="U" then str((thesi+m,map_string),"U"^ap,m)
        else if temp_string="D" then str((thesi-m,map_string),"D"^ap,m)
        else if temp_string="R" then str((thesi-1,map_string),"R"^ap,m)
        else if temp_string="L" then str((thesi+1,map_string),"L"^ap,m)
        else ap
        end
in
fun string((thesi,map_string),ap,m)=
    if valOf(M.find(map_string,thesi))="S" then "stay"
    else str((thesi,map_string),ap,m)
end

fun arxika_nera(map,que) =
        if Queue.isEmpty que then map
        else arxika_nera (M.insert(map,Queue.dequeue que, 0),que)




fun dt(a,b,c) = (b,c)

fun a((k,l,j),m,n) =
    if k=m*n+1 then "infinity"
    else Int.toString(k)

  fun lq (q,[]) = q
  	| lq(q,l) = if (Queue.enqueue (q,hd l) = () ) then lq(q,tl l)
  		else q

fun tel(map,n_que,g_que,m,n) =
    let
    val inf = Queue.isEmpty n_que
    val n_queb=lq(Queue.mkQueue() : int Queue.queue,Queue.contents n_que)
    in
        let
        val fl = flood((map,arxika_nera(M.empty,n_que),n_queb,1),m,n)
        in
        if M.find(fl,Queue.head g_que)=NONE then gates((map,M.insert(M.empty,Queue.head g_que,"S"),g_que,Queue.head g_que),m,n)
        else gatez((map,fl,M.insert(M.empty,Queue.head g_que,0),M.insert(M.empty,Queue.head g_que,"S"),g_que,valOf(M.find(fl,Queue.head g_que))-1,Queue.head g_que,1),m,n)
        end
    end

  fun readfile(infile : string) = let
    val ins = TextIO.openIn infile
    fun helper(copt: char option, map, n_que, g_que, n, counter) =
      let
      val next = TextIO.input1 ins
      in
          if (copt = SOME #".") then helper(next, M.insert(map,counter,"."), n_que, g_que, n, counter+1)
          else if (copt = SOME #"X") then helper(next, M.insert(map,counter,"X"), n_que, g_que, n, counter+1)
          else if (copt = SOME #"A") then
                if Queue.enqueue(g_que,counter)=() then helper(next, M.insert(map,counter, "A" ), n_que, g_que, n, counter+1)
                else helper(next, M.insert(map,counter, "A" ), n_que, g_que, n, counter+1)
          else if (copt = SOME #"W") then
                if Queue.enqueue(n_que,counter)=() then helper(next, M.insert(map,counter, "W" ), n_que, g_que, n, counter+1)
                else helper(next, M.insert(map,counter, "W" ), n_que, g_que, n, counter+1)
          else if (copt = SOME #"\n") then helper(next, map, n_que, g_que, n+1, counter)
          else (map, n_que, g_que, counter div n, n)
      end
    in
      helper(TextIO.input1 ins,M.empty, Queue.mkQueue() : int Queue.queue,Queue.mkQueue() : int Queue.queue, 0, 0)
  end

  fun apantisi(map,n_que,g_que,m,n)=
  	let
  	val teliko = tel(map,n_que,g_que,m,n)
  	in
  	a(teliko,m,n)^"\n"^string(dt(teliko),"",m)^"\n"
  	end

    in

fun savethecat a = print(apantisi(readfile(a)))

end;

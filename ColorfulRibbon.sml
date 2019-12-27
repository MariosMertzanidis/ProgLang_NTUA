local

structure M = BinaryMapFn(struct
        type ord_key = int
    	val compare = Int.compare
  	end);

fun s (SOME a)= a

fun ena (a,b)= a

fun ask (colors,map, num, blist, [], a, b, ap) =
        if colors=num then
            if s(M.find(map,hd blist))=1 then
                if (b-a)<ap then (b-a)
                else ap
            else ask(colors,M.insert(map, hd blist, s(M.find(map,hd blist))-1), num, tl blist, [], a+1, b, ap)
        else ap
    | ask (colors,map, num, blist, alist, a, b, ap)=
        if colors=num then
            if s(M.find(map, hd blist))=1 then
                if (b-a)<ap then ask(colors, ena(M.remove(map,hd blist)), num-1, tl blist, alist, a+1, b, b-a)
                else ask(colors, ena(M.remove(map,hd blist)), num-1, tl blist, alist, a+1, b, ap)
            else ask(colors, M.insert(map, hd blist, s(M.find(map,hd blist))-1), num, tl blist, alist, a+1, b, ap)
        else
            if M.find(map, hd alist)= NONE then ask(colors, M.insert(map, hd alist, 1), num+1, blist, tl alist, a, b+1, ap)
            else ask(colors, M.insert(map, hd alist, s(M.find(map, hd alist))+1), num, blist, tl alist, a, b+1, ap)


(*https://stackoverflow.com/questions/29809722/reading-an-integer-file-to-an-integer-list-in-sml*)
    fun readint(infile : string) = let
         val ins = TextIO.openIn infile
         fun loop ins =
            case TextIO.scanStream( Int.scan StringCvt.DEC) ins of
                 SOME int => int :: loop ins
                 | NONE => []
     in
 	loop ins before TextIO.closeIn ins
  	end
(**************************************************************************************************)



    fun teliko (num::colors::list) =
    let
    val apantisi = ask(colors,M.empty, 0, list, list, 1, 1, num+1)
    in
    if apantisi=num+1 then 0
    else apantisi
    end
in
    fun colors a=print(Int.toString(teliko(readint(a)))^"\n")

end;

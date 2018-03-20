import java.util.*;

%%

%class Flexer
%standalone
/*%debug*/
%int
%line
%column


%{
	TuringM loopi ;
	TuringM loopi1 ;
	TuringColection colectie = new TuringColection();
	TuringM aux = new MixTuringM();
	String name ;
	Character curentSimb ;
	Character curentSimb1;
	String loop;
	int contor = 0;
	String car ;
	int place = 0;
	 
%}

%eof{

 if(Banda.banda.equals("#>#")){
 	System.out.println(Banda.banda);
 }else{
	
 Banda.banda = colectie.getElem(Main.NumeMasina).run(Banda.banda);
 
 if(Banda.banda.startsWith("##")) {
			while(Banda.banda.charAt(contor) == '#') {
				contor = contor + 1;
			}		
 }
 
 Banda.banda = Banda.banda.substring(contor);
 
 if(Banda.banda.startsWith(">")) {
 	Banda.banda = "#" + Banda.banda;
 
 }
 

 //System.out.println(colectie.getElem(name).secventa.get(1).afterLoop.get(1).custom.get('1').get(2).custom.get('#').get(2).custom.get('1').get(1).symbol);
 
 
 
 System.out.println(Banda.banda);
 }
 
 

%eof}

digit = [0-9]
letter = [A-Z] | [a-z] |[0-9]
word = ({letter})+
LineTerminator = \r|\n|\r\n|\t
WS = {LineTerminator} | [ \t\f]
special =  "!"|"#"|"$"|"%"|"&"|"-"|"."|"/"|":"|";"|"<"|">"|"="|"@"|"["|"]"|"^"|"`"|"~"|"{"|"}"|"("|")"
symbol  = {letter} | "#" | "!"{letter} | "!#" | "!" | "!"{digit} | {digit}

%state S1 normalM completeNormalM insideNormal S2 COMM  completeLoopM complAfterLoop insideLoop complinsideLoop  insideMix completeMix auxi extended completeLoopM1 complAfterLoop1 insideLoop1 normalM1 complinsideLoop1 COMM1


%%
<YYINITIAL> { 
	"alphabet ::" {}
	[a-z] {Alphabet.alphabet.add(yytext());}
	"#"	{Alphabet.alphabet.add(yytext());}
	[0-9] {Alphabet.alphabet.add(yytext());}
	";" {}
	"\n" {yybegin(S1);}
	"," {}
	" " {}
	

}

<S1> {
	";"  {if(yycolumn == 0) {yybegin(COMM);}}
	{WS} {if(yycolumn == 0) {yybegin(S1);}}
	{word} {name = yytext() ; colectie.addElem(name ,new MachineFromFile()) ;}
	"::=" {yybegin(S1);}
	{word}"@" {colectie.getElem(name).secventa.add(new LoopTuring(yytext())); yybegin(completeLoopM);}
	"[" {yybegin(normalM);}
	";" {}
	")" {}
	"(" {colectie.getElem(name).secventa.add(new MixTuringM()); yybegin(insideNormal);}
	"{" {yybegin(auxi);}
	
}

<normalM> {
	"R]" { colectie.getElem(name).secventa.add(new RightM()); yybegin(S1);}
	"L]" { colectie.getElem(name).secventa.add(new LeftM()); yybegin(S1);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.add(new LeftUntilM("#")) ;yybegin(S1); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.add(new RightUntilM("#")) ;yybegin(S1); }
	"L("{symbol}")]" {colectie.getElem(name).secventa.add(new LeftUntilM(yytext())) ;yybegin(S1); }
	"R("{symbol}")]" {colectie.getElem(name).secventa.add(new RightUntilM(yytext())) ;yybegin(S1); }
	{word} { colectie.getElem(name).secventa.add(colectie.getElem(yytext())); }
	{symbol} { colectie.getElem(name).secventa.add(new WriteM(yytext())) ;yybegin(S1);}
	"]" { yybegin(S1);}
}



<insideNormal> {
	{WS} {}
	";" {}
	"{"{symbol}", "{symbol}"}" {curentSimb = yytext().charAt(1) ; colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).
	custom.put(yytext().charAt(1) , new ArrayList<TuringM>()); curentSimb = yytext().charAt(4) ; colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).
	custom.put(curentSimb , colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).
	custom.get(yytext().charAt(1)));}
	"{"{symbol}"}" {curentSimb = yytext().charAt(1) ;colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).
	custom.put(yytext().charAt(1) , new ArrayList<TuringM>());}
	"-" {}
	">" {}
	"[" {yybegin(completeNormalM);}
	"(" {colectie.getElem(name).secventa.add(new MixTuringM()); yybegin(insideNormal);}
	")" { yybegin(S1);}
		
}

<completeNormalM> {
	"R]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(new RightM()); yybegin(insideNormal);}
	"L]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(new LeftM()); yybegin(insideNormal);}
	"L("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(new LeftUntilM(yytext())) ;yybegin(insideNormal); }
	"R("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(new RightUntilM(yytext())) ;yybegin(insideNormal); }
	{word} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(colectie.getElem(yytext())); }
	{symbol}"]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).custom.get(curentSimb).add(new WriteM(yytext())) ;yybegin(insideNormal); }
	"]" { yybegin(insideNormal);}
}




<completeLoopM> {
	{WS} {}
	"[" {yybegin(complAfterLoop);}
	"(" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new MixTuringM()) ; 
	aux = colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(
	colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1);yybegin(insideLoop);}
	
}

<complAfterLoop> {
	"R]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new RightM()); yybegin(completeLoopM);}
	"L]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new LeftM()); yybegin(completeLoopM);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new LeftUntilM("#")) ;yybegin(completeLoopM); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new RightUntilM("#")) ;yybegin(completeLoopM); }
	"L("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new LeftUntilM(yytext())) ;yybegin(completeLoopM); }
	"R("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new RightUntilM(yytext())) ;yybegin(completeLoopM); }
	{word} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(colectie.getElem(yytext())); }
	{symbol} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new WriteM(yytext())) ;yybegin(completeLoopM);}
	"]" { yybegin(completeLoopM);}
}


<insideLoop> {
	{WS} {}
	";" {}
	
	"!""{"{symbol}"}" {curentSimb = yytext().charAt(1) ;
	ArrayList<TuringM> tur = new ArrayList<TuringM>(); 
	
	colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put( '0'  , tur); colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put( '#'  , tur);}
	
	"{"{symbol}"}" {curentSimb = yytext().charAt(1) ;colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put(yytext().charAt(1) , new ArrayList<TuringM>());}
	
	"{"{symbol}", "{symbol}"}" { curentSimb = yytext().charAt(1); colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put(yytext().charAt(1) , new ArrayList<TuringM>()); curentSimb = yytext().charAt(4); 
	colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put(yytext().charAt(4) , colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.get(yytext().charAt(1)));}
	
	"-" {}
	">" {}
	"[" {yybegin(complinsideLoop);}
	"&"{word} {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1));}
	"(" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.get(curentSimb).add(new MixTuringM()); 	
	aux = colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.get(curentSimb).get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.get(curentSimb).size() - 1); yybegin(insideMix);}
	")" { yybegin(S1);}
	
	
}

<insideMix> {
	{WS} {}
	";" {}
	"(" {aux.custom.get(curentSimb).add(new MixTuringM()) ; aux = aux.custom.get(curentSimb).get(aux.custom.get(curentSimb).size() - 1); yybegin(insideMix);}
	"{"{symbol}"}" {curentSimb = yytext().charAt(1) ;aux.custom.put(curentSimb , new ArrayList<TuringM>());}
	"{"{symbol}", "{symbol}"}" { curentSimb = yytext().charAt(1); aux.custom.put(yytext().charAt(1) , new ArrayList<TuringM>());
								curentSimb = yytext().charAt(4); aux.custom.put(curentSimb , aux.custom.get(yytext().charAt(1)));}
	
	
	"-" {}
	">" {}
	"[" {yybegin(completeMix);}
	"&"{word} {aux.custom.get(curentSimb).add(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1));}
	
	")" { yybegin(S1);}

}


<completeMix> {
	"L]" { aux.custom.get(curentSimb).add(new LeftM()); yybegin(insideMix);}
	"R]" {aux.custom.get(curentSimb).add(new RightM()); yybegin(insideMix);}
	"L("{symbol}")]" {aux.custom.get(curentSimb).add(new LeftUntilM(yytext())) ;yybegin(insideMix); }
	"R("{symbol}")]" {aux.custom.get(curentSimb).add(new RightUntilM(yytext())) ;yybegin(insideMix); }
	{symbol}"]" {aux.custom.get(curentSimb).add(new WriteM(yytext())) ;yybegin(insideMix); }
	{word} { aux.custom.get(curentSimb).add(colectie.getElem(yytext())); }
	"]" { yybegin(insideMix);}
}



<complinsideLoop> {
	"L]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new LeftM()); yybegin(insideLoop);}
	"R]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new RightM()); yybegin(insideLoop);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new LeftUntilM("#")) ;yybegin(insideLoop); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new RightUntilM("#")) ;yybegin(insideLoop); }
	"L("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new LeftUntilM(yytext())) ;yybegin(insideLoop); }
	"R("{symbol}")]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new RightUntilM(yytext())) ;yybegin(insideLoop); }
	{word} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(colectie.getElem(yytext())); }
	{symbol}"]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new WriteM(yytext())) ;yybegin(insideLoop); }
	"]" { yybegin(insideLoop);}
}

<auxi> {
	{WS} {}
	[a-zA-Z] {}
	{symbol} {}
	{special} {}
	" " {}
	"#" {}
	">" {}
	"-" {}
	"+" {}
	"*" {}
	"," {}
	"^" {}
}


<COMM> {
	"\n" { yybegin(S1);}
	[a-zA-Z] {}
	{symbol} {}
	" " {}
	"#" {}
	">" {}
	"-" {}
	"+" {}
	"*" {}
	"," {}
	"^" {}
}


<extended> { 
	";"  {if(yycolumn == 0) {yybegin(COMM1);}}
	{WS} {if(yycolumn == 0) {yybegin(extended);}}
	{word} {name = yytext() ; colectie.addElem(name ,new MachineFromFile()) ;}
	"::=" {yybegin(extended);}
	{word}"@" {colectie.getElem(name).secventa.add(new LoopTuring(yytext())); yybegin(completeLoopM1);}
	"[" {yybegin(normalM1);}
	";" {}
	")" {}
	":=" {}
	"digit" {System.out.println("ajdajdja");yybegin(COMM1);}
	"#" {} 
	"{" {}
	"," {}
	"}" {}
	"=" {}
	
		
}


<normalM1> {
	"R]" { colectie.getElem(name).secventa.add(new RightM()); yybegin(extended);}
	"L]" { colectie.getElem(name).secventa.add(new LeftM()); yybegin(extended);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.add(new LeftUntilM("#")) ;yybegin(extended); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.add(new RightUntilM("#")) ;yybegin(extended); }
	{word} { colectie.getElem(name).secventa.add(colectie.getElem(yytext())); }
	{symbol} { colectie.getElem(name).secventa.add(new WriteM(yytext())) ;yybegin(extended);}
	"]" { yybegin(extended);}
}


<completeLoopM1> {
	{WS} {}
	"[" {yybegin(complAfterLoop1);}
	"(" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new MixTuringM()) ; yybegin(insideLoop1);}
}

<complAfterLoop1> {
	"R]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new RightM()); yybegin(completeLoopM1);}
	"L]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new LeftM()); yybegin(completeLoopM1);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new LeftUntilM("#")) ;yybegin(completeLoopM1); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new RightUntilM("#")) ;yybegin(completeLoopM1); }
	{word} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(colectie.getElem(yytext())); }
	{symbol} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.add(new WriteM(yytext())) ;yybegin(completeLoopM1);}
	"]" { yybegin(completeLoopM1);}

}


<insideLoop1> {
	{WS} {}
	";" {}
	"!""{"{symbol}"}" {curentSimb = yytext().charAt(1) ;
	ArrayList<TuringM> tur = new ArrayList<TuringM>(); 
	
	colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put( '0'  , tur); colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put( '#'  , tur);}
	
	
	"{"{symbol}"}" {curentSimb = yytext().charAt(1) ;colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.
	get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).
	custom.put(yytext().charAt(1) , new ArrayList<TuringM>());}
	
	
	"-" {}
	">" {}
	"[" {yybegin(complinsideLoop1);}
	"&"{word} {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1));}
	")" { yybegin(extended);}
	
	
}


<complinsideLoop1> {
	"L]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new LeftM()); yybegin(insideLoop1);}
	"R]" { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new RightM()); yybegin(insideLoop1);}
	"L(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new LeftUntilM("#")) ;yybegin(insideLoop1); }
	"R(<"{word}">)]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new RightUntilM("#")) ;yybegin(insideLoop1); }
	{word} { colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(colectie.getElem(yytext())); }
	{symbol}"]" {colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.get(colectie.getElem(name).secventa.get(colectie.getElem(name).secventa.size() - 1).afterLoop.size() - 1).custom.get(curentSimb).add(new WriteM(yytext())) ;yybegin(insideLoop1); }
	"]" { yybegin(insideLoop1);}

}

<COMM1> {
	"\n" { yybegin(extended);}
	[a-zA-Z] {}
	{symbol} {}
	{special} {}
	" " {}
	"#" {}
	">" {}
	"-" {}
	"+" {}
	"*" {}
	"," {}
	"^" {}
}




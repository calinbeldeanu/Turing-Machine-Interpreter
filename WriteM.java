
public class WriteM extends TuringM{
	
	int arrowPos ;
	char symbol;
	char[] banda ;

	 public WriteM(String symb) {
		this.symbol = symb.charAt(0);
	}

	@Override
	String run(String band) {
		banda = band.toCharArray();
		arrowPos = 0;
		for(int i = 0 ; i < banda.length; i++) {
			if(banda[i] == '>') {
				arrowPos = i;
			}
		}
	if(arrowPos <= band.length() - 3) {	
		banda[arrowPos + 1 ] = symbol;
		band = String.valueOf(banda);
	}else if(arrowPos == band.length() - 2) {
		banda[arrowPos + 1] = symbol;
		band = String.valueOf(banda) + "#";
	}else if(arrowPos == band.length()- 1) {
		band = String.valueOf(banda) + symbol + "#";
	}
	
	return band;
	
	}

	

}


public class LeftM extends TuringM {
	
	int arrowPos ;
	char helper;
	char[] banda ;


	@Override
	String run(String band) {

		banda = band.toCharArray();
		arrowPos = 0;//
		for(int i = 0 ; i < banda.length ; i++) {
			if(banda[i] == '>') {
				arrowPos = i;
			}
		}
	
	if(arrowPos != 0) {
		helper	= banda[arrowPos -1];
		banda[arrowPos] = helper;
		banda[arrowPos - 1] = '>';
		band = String.valueOf(banda);
	}else if(arrowPos == 0){
		
		band = "#>"+ String.valueOf(banda);
	}
	return band;
	}
	
}

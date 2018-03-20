
public class RightM extends TuringM {

	int arrowPos ;
	char helper;
	char[] banda ;


	@Override
	String run(String band) {
		banda = band.toCharArray();
		arrowPos = 0;
		for(int i = 0 ; i < banda.length; i++) {
			if(banda[i] == '>') {
				arrowPos = i;
			}
		}
	if(arrowPos != band.length() - 1 ) {
		helper	= banda[arrowPos +1];
		banda[arrowPos] = helper;
		banda[arrowPos + 1] = '>';
		band = String.valueOf(banda);
		
	}else {
		band = String.valueOf(banda) + "#";
		
	}
	
	return band;
	
	}

}

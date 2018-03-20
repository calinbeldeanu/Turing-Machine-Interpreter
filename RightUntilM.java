
public class RightUntilM extends TuringM {


	int arrowPos ;
	char[] banda ;
	boolean not = false ;
	char symbol;
	RightM right = new RightM();

	String helper;
	
	public RightUntilM(String ceva) {
		this.helper = ceva;
	}

	@Override
	String run(String band) {
		
		
		
		
		if(helper.charAt(2) == '!') {
			not = true;
			symbol = helper.charAt(3);
		}else {
			not = false;
			symbol = helper.charAt(2);
		}
		
		while(true) {	
			band = right.run(band);
			banda = band.toCharArray();
			arrowPos = 0;
			for(int i = 0 ; i < banda.length ; i++) {
				if(banda[i] == '>') {
					arrowPos = i;
				}
			}
			if(arrowPos + 1 != band.length()) {
				if(banda[arrowPos+1] == symbol && not == false) {
					return band;
				}else if(banda[arrowPos+1] != symbol && not == true) {
					return band;
				}
			}
							
		}		
	}

}

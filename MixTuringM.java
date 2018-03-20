import java.util.ArrayList;

public class MixTuringM extends TuringM{
	
	int arrowPos ;
	char[] banda ;
	
	
	@Override
	String run(String band) {
		
		
		banda = band.toCharArray();
		arrowPos = 0;
		for(int i = 0 ; i < banda.length - 1; i++) {
			if(banda[i] == '>') {
				arrowPos = i;
			}
		}
		
		custom.putIfAbsent(banda[arrowPos+1], new ArrayList<TuringM>());

			for(int i = 0 ; i< custom.get(banda[arrowPos+1]).size() ; i++) {
				band = custom.get(banda[arrowPos+1]).get(i).run(band);
			}
		
		
		
		return band;
	}

}

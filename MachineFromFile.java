

public class MachineFromFile extends TuringM {

	
	
	@Override
	String run(String band) {

		for(int i = 0 ; i < secventa.size(); i++) {
			band = secventa.get(i).run(band);			
		}
	
		int contor = 0;
		int contor1 = band.length() - 1;
		
		
		
		if(band.endsWith("##")) {
			while(band.charAt(contor1) == '#') {
				contor1 = contor1 - 1;
			}		
		}
		if(contor1 != band.length()) {
			contor1= contor1 + 1;
		}
		
		
		band = band.substring(contor, contor1);
		if(!band.endsWith("#")) {
			band = band.concat("#");
		}
		
		if(!band.startsWith("#")) {
			band = "#" + band;
		}
		
		
		
		return band;
	}
	

}

public class LoopTuring extends TuringM{

	String nameLoop ;
	
	public LoopTuring(String name) {
		// TODO Auto-generated constructor stub
		if(name.charAt(name.length() - 1) == '@') {
			this.nameLoop = name.substring(0, name.length() - 2);
		}else {
			this.nameLoop = name.substring(1, name.length() - 1);
		}
	}
	
	
	@Override
	String run(String band) {

		
		for(int i = 0 ; i < afterLoop.size() ; i++) {
			band = afterLoop.get(i).run(band);
			
		}

		
			
		return band;
	}

}

import java.util.HashMap;


public class TuringColection {
	public  HashMap<String, TuringM> turingC;
	
	
	
	
	public TuringColection() {
		turingC = new HashMap<String, TuringM>();
	}

	public void addElem(String name , TuringM machine) {
		turingC.put(name, machine);

	}
	
	public TuringM getElem(String name ) {
		return turingC.get(name);
		
	}
	
	public void size1() {
		System.out.println(turingC.size());
	}
	
}

import java.util.ArrayList;
import java.util.HashMap;

public abstract class TuringM {
	
	
	 
	
	ArrayList<TuringM> secventa = new ArrayList<TuringM>() ;
	HashMap<Character, ArrayList<TuringM>> custom = new HashMap<Character, ArrayList<TuringM>>();
	public char symbol;
	ArrayList<TuringM> afterLoop = new ArrayList<TuringM>();


	abstract String run(String band) ;
}

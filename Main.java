
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;


public class Main {

	static String NumeMasina;
	
	public static void main(String[] args) {
		BufferedReader br;
		try {
			br = new BufferedReader(new FileReader(args[0]));
			NumeMasina = args[1];
			Banda.banda = args[2];
			
			//System.out.println(Banda.banda);
			Flexer scanner = new Flexer(br);
			scanner.yylex();
			
				
			//String lal = "aa";
			///System.out.println(lal.length());

			//RightM right = new RightM();
			//LeftUntilM lu = new LeftUntilM("L(#)");

			//Banda.banda = right.run(Banda.banda);
			//Banda.banda = right.run(Banda.banda);
			//Banda.banda = right.run(Banda.banda);
			
			//System.out.println(Banda.banda);
			//Banda.banda = lu.run(Banda.banda);
			//System.out.println(Banda.banda); // rezultat final 
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
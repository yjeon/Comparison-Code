public class Mandelbrot extends Fractal{
  
  //Constructor to initialize the the data
  //Mandelbrot has c = 0
  //so set c as 0 complex
  public Mandelbrot(Complex low, Complex high, int nrows, int ncols, int maxIters){
    this.low = low;
    this.high = high;
    this.nrows = nrows;
    this.ncols = ncols;
    this.maxIters = maxIters;
    this.c = new Complex(0,0);
    this.escapeVals = escapes();
  }
  
  //implement abstract method from Fractal
  //Z_0 = 0 and c=p
  //Z_n+1 = (Z_n)^2 + c
  //if the absoult value of z is larger than 2, then the point c is the set
  public int escapeCount(Complex p){
    
    //base case
    double tempR = this.c.r;
    double tempI = this.c.i;
    //iterate loop until the max
    for(int i = 0; i< this.maxIters; i++){
      //Z_0 = 0 and c=p
      //Z_n+1 = (Z_n)^2 + c
      double tempRR = Math.pow(tempR,2) - Math.pow(tempI,2);
      double tempII = (tempR*tempI)*2;
      tempRR+=p.r;
      tempII+=p.i;
      //checking the absoulte value
      if(Math.abs(Math.sqrt(Math.pow(tempRR,2)+Math.pow(tempII,2))) > 2){
        return i;
      }
      //update the value
      tempI = tempII;
      tempR = tempRR;
    }
    
    return this.maxIters;
  }
  
  //toString as the method write from Fractal
  @Override public String toString(){
    String s = "";
    String s1 = Integer.toString(this.nrows)+" "+Integer.toString(this.ncols)+" "+
      Integer.toString(this.maxIters)+"\n";
    String s2 = Double.toString(this.low.r)+" "+Double.toString(this.high.r)+" "+
      Double.toString(this.low.i)+" "+Double.toString(this.high.i)+"\n";
    String s3 = Double.toString(this.c.r)+" "+Double.toString(this.c.i)+"\n\n";
    s += s1;
    s += s2;
    s += s3;
    for (int i = 0; i < this.nrows; i++){
      for (int j = 0; j < this.ncols; j++){
 
        if (this.escapeVals[i][j]<10){
          s += "  ";
        }
        else{
          s += " ";
        }
        s += Integer.toString(this.escapeVals[i][j]);
      }
      s += "\n";
    }
    return s;
  }
  
  //main
  //accept eight command line arguments
  //lowR, highR lowI, highI, nrows, ncols, maxIters, filename
  public static void main(String[] args){
    double lowR= Double.parseDouble(args[0]);
    double highR = Double.parseDouble(args[1]);
    double lowI= Double.parseDouble(args[2]);
    double highI = Double.parseDouble(args[3]);
    int nrows = Integer.parseInt(args[4]);
    int ncols = Integer.parseInt(args[5]);
    int maxIters = Integer.parseInt(args[6]);
    
    Complex low=new Complex(lowR,lowI); 
    Complex high= new Complex(highR,highI);
    
    String filename= args[7];
    
    //set the mandelbrot
    Mandelbrot m= new Mandelbrot(low, high, nrows, ncols, maxIters);
    
    //make the file 
    m.write(filename);
    //print the m toString
    System.out.println(m);
  }
  
  
}
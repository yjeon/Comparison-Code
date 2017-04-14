import java.io.*;
public abstract class Fractal{
  
  //fields
  Complex low;        //lower-left coordinates
  Complex high;       //upper-right coordinates
  int nrows;          //pixel counting - how many pixels in each direction
  int ncols;          //pixel counting - how many pixels in each direction 
  int maxIters;       //how many iteration to consider for set inclusion
  int[][] escapeVals; //cached answers for each point's iteration to escape
  Complex c;          //what is the c value of the iteration function? 
                      //(boring for Mandelbrot)
  
  //abstract method
  //Given one point p, how many iterations can you follow, 
  //up to maxIters, before it escapes? 
  //This means all points in the set will return maxIters.
  public abstract int escapeCount(Complex p);
  
  //calculate escape counts for each point indicated by current instance variables
  //return the array of escape counts.
  public int[][] escapes(){
    
    //set the length of the array.
    this.escapeVals = new int[this.nrows][this.ncols];
    
    //check the current values
    double tempLR = this.low.r;
    double tempLI = this.low.i;
    double tempHR = this.high.r;
    double tempHI = this.high.i;
    
    //current range of the values
    double gapR = (this.high.r - this.low.r) / (this.ncols-1);
    double gapI = (this.high.i - this.low.i) / (this.nrows-1);
    
    //using for two loops, set the each of the escape counts for each point
    //and update the current instance variables.
    for(int i = 0; i < this.nrows; i++){
      //set the basic value
      tempLR = this.low.r;
      for(int j = 0; j < this.ncols; j++){
        //make a new complex
        //and apply it into escapeCount method
        Complex p = new Complex(tempLR,tempHI);
        this.escapeVals[i][j] = escapeCount(p);
        
        //update values
        tempLR += gapR;
      }
      tempHI -= gapI;
    }
    
    //System.out.println("here\n");
    return this.escapeVals;
  }
  
  //create a file
  public void write(String filename){
    //try-catch block
    try{
      //System.out.println("running\n");
      //make a file with using given filename
      File file = new File(filename);
      //using befferedwriter write the values
      BufferedWriter b = new BufferedWriter(new FileWriter(file));
      
      //nrows ncols maxIters
      b.write(Integer.toString(this.nrows)+" "+Integer.toString(this.ncols)+" "+
              Integer.toString(this.maxIters)+"\n");
      //lowRealVal, highRealVal, lowImaginaryVal, highImaginaryVal
      b.write(Double.toString(this.low.r)+" "+Double.toString(this.high.r)+" "+
              Double.toString(this.low.i)+" "+Double.toString(this.high.i)+"\n");
      //realC imaginary and blank line
      b.write(Double.toString(this.c.r)+" "+Double.toString(this.c.i)+"\n\n");
      
      //each row from escapeVals
      for (int i = 0; i < this.nrows; i++){
        for (int j = 0; j < this.ncols; j++){
          if (this.escapeVals[i][j]<10){
            //if there is one digit, has 2 whitespaces
            b.write("  ");
          }
          else{
            //if there are two digits, have 1 whitespace
            b.write(" ");
          }
          b.write(Integer.toString(this.escapeVals[i][j]));
        }
        //newline
        b.write("\n");
      }
      
      b.close();
    }
    catch(IOException e){
      System.out.println("Error- "+e);
      
    }
  }
  
  //zoom
  public void zoom(double factor){
    //if factor is odd number
    //find a gap between
    //and plus minus from the values
    if(factor%2 == 1){
      double tempI = (this.high.i - this.low.i)/factor;
      double tempR = (this.high.r - this.low.r)/factor;
      this.low.i += tempI;
      this.low.r += tempR;
      this.high.i -= tempI;
      this.high.r -= tempR;
    }
    else{
      //if factor is even number
      //divide by factor.
      this.low.i /= factor;
      this.low.r /= factor;
      this.high.i /= factor;
      this.high.r /= factor;
      
    }
  }
  
  //update the values.
  public void updateDimensions(Complex low, Complex high){
    //update the low and high
    //also recalculate other stale state
    this.low = low;
    this.high = high;
    this.escapeVals = escapes();
  }
  
  //toString as write function
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
  
}
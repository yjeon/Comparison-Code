public class Complex{
  
  //Fields
  double r;
  double i;
  
  //Constructor to initialize the the data 
  public Complex(double r, double i){
    this.r = r;
    this.i = i;
  }
  
  //method complex add
  public static Complex add(Complex a, Complex b){
    return new Complex((a.r+b.r),(a.i+b.i));
  }
  
  //method complex sub
  public static Complex sub(Complex a, Complex b){
    return new Complex((a.r-b.r),(a.i-b.i));
  }
 
  //method complex multiply
  //(2+i)(3+i) = 5+5i
  public static Complex mul(Complex a, Complex b){
    double c = (a.r*b.r)-(a.i*b.i);
    double d = (a.i*b.r)+(a.r*b.i);
    return new Complex(c,d);
  }
  
  //method absolute value of complex
  public static double abs(Complex c){
    double result = Math.sqrt(Math.pow(c.r,2) + Math.pow(c.i,2));
    return result;
  }
  
  //method toString
  @Override public String toString(){
    return this.r+"+"+this.i+"*i";
  }
  
  //method Complex copy
  public Complex copy(){
    return new Complex(this.r,this.i);
  }
  
}
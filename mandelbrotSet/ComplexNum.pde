public class ComplexNum {

  private double real, imag;
  private ComplexNum conj;

  public ComplexNum() {
  }

  public ComplexNum(double real, double imag) {
    this.real = real;
    this.imag = imag;
    
    // create conjugate
    conj = new ComplexNum();
    conj.real = real;
    conj.imag = -imag;
  }

   public void setReal(double real) {
    this.real = real;
  }

  public double getReal() {
    return real;
  }
  
  public void setImag(double imag) {
    this.imag = imag;
  }

  public double getImag() {
    return imag;
  }
  
  public ComplexNum getConj() {
    return conj;
  }

  public void add(ComplexNum cn) {
    real += cn.real;
    imag += cn.imag;
  }

  public void mult(ComplexNum cn) {
    double re, im;
    re = -imag*cn.imag + real*cn.real;
    im = imag*cn.real + real*cn.imag;
    real = re;
    imag = im;
  }

  public void div(ComplexNum cn) {
    // implement eventually
    // mult num and denom by conjugate of denom, then simplify
  }

  public void sub(ComplexNum cn) {
    real -= cn.real;
    imag -= cn.imag;
  }
  
  public void set(ComplexNum cn){
    real = cn.real;
    imag = cn.imag;
  }
}


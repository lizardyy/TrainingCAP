public class Main { 
    int x = 5;

    public static void main(String[] args){
        Main myObj = new Main();
        System.out.println(myObj.x);

        myMethod();
        myMethod();
        myMethod();

    }

    static void myMethod(){
        System.out.println("I just got executed!");
    }
    
}


package Classes;


public class My_functions {
    public static boolean passwordCheck(String password,String con_password){
        if(password.equals(con_password)){
            return true;
        }else{
            return false;
        }
    }
}

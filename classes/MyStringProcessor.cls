/**
 * Created by User on 01.04.2019.
 */

public class MyStringProcessor implements StringProcessor{

    public static String addPrefix (String str) {
        return  '-PRE-'+str;
    }
    public static String addPostfix (String str) {
        return  str+'-POST-';
    }
    public static String removeWhitespaces (String str) {
        return str.deleteWhitespace();
    }

    public static void updateList (List<String> firstList,List<String> secondList){
        for (String item: firstList) {
            item = MyStringProcessor.addPrefix(item);
            item = MyStringProcessor.addPostfix(item);
            item = MyStringProcessor.removeWhitespaces(item);
            secondList.add(item);
        }
    }
}
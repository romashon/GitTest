
public with sharing class StringTasks {

    /**
 * Returns the result of concatenation of two strings.
 *
 * @param {string} value1
 * @param {string} value2
 * @return {string}
 *
 * @example
 *   'aa', 'bb' => 'aabb'
 *   'aa',''    => 'aa'
 *   '',  'bb'  => 'bb'
 */
    public static String concatenateStrings(String value1, String value2) {
        return value1+value2;
    }

    /**
 * Returns the length of given string.
 *
 * @param {string} value
 * @return {number}
 *
 * @example
 *   'aaaaa' => 5
 *   'b'     => 1
 *   ''      => 0
 */
    public static Integer getStringLength(String value) {
        return value.length();
    }

    /**
 * Returns the result of string template and given parameters firstName and lastName.
 * Please do not use concatenation, use template string :
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/template_strings
 *
 * @param {string} firstName
 * @param {string} lastName
 * @return {string}
 *
 * @example
 *   'John','Doe'      => 'Hello, John Doe!'
 *   'Chuck','Norris'  => 'Hello, Chuck Norris!'
 */
    public static String getStringFromTemplate(String firstName, String lastName) {
        return 'Hello, '+firstName + ' '+ lastName;
    }

    /**
 * Extracts a name from template string 'Hello, First_Name Last_Name!'.
 *
 * @param {string} value
 * @return {string}
 *
 * @example
 *   'Hello, John Doe!' => 'John Doe'
 *   'Hello, Chuck Norris!' => 'Chuck Norris'
 */
    public static String extractNameFromTemplate(String value) {
        value = value.replaceFirst('Hello, ', '');
        return value.replaceFirst('!', '');
    }

    /**
 * Returns a first char of the given string.
 *
 * @param {string} value
 * @return {string}
 *
 * @example
 *   'John Doe'  => 'J'
 *   'cat'       => 'c'
 */
    public static String getFirstChar(String value) {
        return value.left(1);
    }

    /**
 * Removes a leading and trailing whitespace characters from string.
 *
 * @param {string} value
 * @return {string}
 *
 * @example
 *   '  Abracadabra'    => 'Abracadabra'
 *   'cat'              => 'cat'
 *   '\tHello, World! ' => 'Hello, World!'
 */
    public static String removeLeadingAndTrailingWhitespaces(String value) {
        return value.trim();
    }

    /**
 * Returns a string that repeated the specified number of times.
 *
 * @param {string} value
 * @param {string} count
 * @return {string}
 *
 * @example
 *   'A', 5  => 'AAAAA'
 *   'cat', 3 => 'catcatcat'
 */
    public static String repeatString(String value, Integer count) {
        String result = '';
        for (integer i = 0; i<count; i++) {
            result += value;
        }
        return result;
    }

    /**
 * Remove the first occurrence of string inside another string
 *
 * @param {string} str
 * @param {string} value
 * @return {string}
 *
 * @example
 *   'To be or not to be', 'not'  => 'To be or to be'
 *   'I like legends', 'end' => 'I like legs',
 *   'ABABAB','BA' => 'ABAB'
 */
    public static String removeFirstOccurrences(String str, String value) {
        return  str.replaceFirst(value, '');
    }

    /**
 * Remove the first and last angle brackets from tag string
 *
 * @param {string} str
 * @return {string}
 *
 * @example
 *   '<div>' => 'div'
 *   '<span>' => 'span'
 *   '<a>' => 'a'
 */
    public static String unbracketTag(String str) {
        str = str.removeStart('<');
        return str.removeEnd('>');
    }

    /**
 * Converts all characters of the specified string into the upper case
 *
 * @param {string} str
 * @return {string}
 *
 * @example
 *   'Thunderstruck' => 'THUNDERSTRUCK'
 *  'abcdefghijklmnopqrstuvwxyz' => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
 */
    public static String convertToUpperCase(String str) {
        return str.toUpperCase();
    }

    /**
 * Extracts e-mails from single string with e-mails list delimeted by semicolons
 *
 * @param {string} str
 * @return {array}
 *
 * @example
 *   'angus.young@gmail.com;brian.johnson@hotmail.com;bon.scott@yahoo.com' => ['angus.young@gmail.com', 'brian.johnson@hotmail.com', 'bon.scott@yahoo.com']
 *   'info@gmail.com' => ['info@gmail.com']
 */
    public static List<String> extractEmails(String str) {
        List<String> X = str.split(';');
        return X;
    }

    /**
 * Returns the string representation of rectangle with specified width and height
 * using pseudograhic chars
 *
 * @param {number} width
 * @param {number} height
 * @return {string}
 *
 * @example
 *
 *            '┌────┐\n'+
 *  (6,4) =>  '│    │\n'+
 *            '│    │\n'+
 *            '└────┘\n'
 *
 *  (2,2) =>  '┌┐\n'+
 *            '└┘\n'
 *
 *             '┌──────────┐\n'+
 *  (12,3) =>  '│          │\n'+
 *             '└──────────┘\n'
 *
 */
    public static String getRectangleString(Integer width, Integer height) {
        String result = '';
        Integer j;
        for (Integer i = 0; i< height;){
            for (j = 0; j< width; j){
                if (i==0 && j == 0) {
                    result += '┌';
                } else if (i==0 && j == height-1) {
                    result += '└';
                } else if (i==width-1 && j == 0) {
                    result += '┐\n';
                } else if (i==width-1 && j == height -1) {
                    result += '┘\n';
                } else if ((i>0 || i<(width-1)) && (j==0 || j == (height-1))){
                    result += '─';
                } else if ((i==0) && (j>0 || j < (height-1))) {
                    result += '│';
                } else if ((i==width-1) && (j>0 || j < (height-1))) {
                    result += '│\n';
                } else {
                    result += ' ';
                }
                i++;

            }
            j++;
        }
        return result;
    }

    /**
 * Returns playid card id.
 *
 * Playing cards inittial deck inclides the cards in the following order:
 *
 *  'A♣','2♣','3♣','4♣','5♣','6♣','7♣','8♣','9♣','10♣','J♣','Q♣','K♣',
 *  'A♦','2♦','3♦','4♦','5♦','6♦','7♦','8♦','9♦','10♦','J♦','Q♦','K♦',
 *  'A♥','2♥','3♥','4♥','5♥','6♥','7♥','8♥','9♥','10♥','J♥','Q♥','K♥',
 *  'A♠','2♠','3♠','4♠','5♠','6♠','7♠','8♠','9♠','10♠','J♠','Q♠','K♠'
 *
 * (see https://en.wikipedia.org/wiki/Standard_52-card_deck)
 * Function returns the zero-based index of specified card in the initial deck above.
 *
 * @param {string} value
 * @return {number}
 *
 * @example
 *   'A♣' => 0
 *   '2♣' => 1
 *   '3♣' => 2
 *     ...
 *   'Q♠' => 50
 *   'K♠' => 51
 */
    public static Integer getCardId(String value) {
        return null;
    }

}
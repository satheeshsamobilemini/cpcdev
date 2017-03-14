public class Metaphone {

    /**
     * Five values in the English language 
     */
    private static final String VOWELS = 'AEIOU';

    /**
     * Variable used in Metaphone algorithm
     */
    private static final String FRONTV = 'EIY';

    /**
     * Variable used in Metaphone algorithm
     */
    private static final String VARSON = 'CSPTG';

    /**
     * The max code length any metaphoned word
     */
    private Integer maxCodeLen = 255;

    /**
     * Find the metaphone value of a String. This is similar to the
     * soundex algorithm, but better at finding similar sounding words.
     * All input is converted to upper case.
     * Limitations: Input format is expected to be a single ASCII word
     * with only characters in the A - Z range, no punctuation or numbers.
     *
     * @param txt String to find the metaphone code for
     * @return A metaphone code corresponding to the String supplied
     */
    public String getMetaphone(String txt) {
        boolean hard = false;
        if ((txt == null) || (txt.length() == 0)) {
            return '';
        }
        // single character is itself
        if (txt.length() == 1) {
            return txt.toUpperCase();
        }
      
        String inwd = txt.toUpperCase();
      
        String local = ''; // manipulate
        String code = '';  //   output
        // handle initial 2 characters exceptions
        String firstChar = inwd.substring(0, 1);
        if(firstChar=='G'||firstChar=='K'||firstChar=='P'){ /* looking for KN, etc*/
            if (inwd.substring(1,2) == 'N') {
                local = local + inwd.substring(1);
            } else {
                local = local + inwd;
            }
        }
        if(firstChar=='A'){ /* looking for AE */
            if (inwd.substring(1,2) == 'E') {
                local = local + inwd.substring(1);
            } else {
                local = local + inwd;
            }
        }
        if(firstChar=='W'){ /* looking for WR or WH */
            if (inwd.substring(1,2) == 'R') {   // WR -> R
                local = local + inwd.substring(1); 
            }
            if (inwd.substring(1,2) == 'H') {
                local = local + inwd.substring(1);
                local = 'W' + local.substring(1); // WH -> W
            } else {
                local = local + inwd;
            }
        }
        if(firstChar=='X'){ /* initial X becomes S */
            inwd = 'S' + inwd.substring(1);
            local = local + inwd;
        }
        if(firstChar!='A'&&firstChar!='G'&&firstChar!='K'&&firstChar!='P'&&
            firstChar!='W'&&firstChar!='X'){
            local = local + inwd;
        } // now local has working string with initials fixed

        Integer wdsz = local.length();
        Integer n = 0;

        while ((code.length() < this.getMaxCodeLen()) && 
               (n < wdsz)) { // max code size of 4 works well
            String symb = local.substring(n, n+1);
            // remove duplicate letters except C
            if ((symb != 'C') && (isPreviousChar(local, n, symb))) {
                n++;
            } else { // not dup
                if(symb=='A'||symb=='E'||symb=='I'||symb=='O'||symb=='U'){
                    if (n == 0) { 
                        code = code + symb;
                    }
                } // only use vowel if leading char
                if(symb=='B'){
                    if (isPreviousChar(local, n, 'M') && 
                         isLastChar(wdsz, n)) { // B is silent if word ends in MB
                        n++;
                        continue;
                    }
                    code = code + symb;
                }
                if(symb=='C'){ // lots of C special cases
                    /* discard if SCI, SCE or SCY */
                    if (isPreviousChar(local, n, 'S') && 
                         !isLastChar(wdsz, n) && 
                         (FRONTV.indexOf(local.substring(n+1, n+2)) >= 0)) { 
                        n++;
                        continue;
                    }
                    if (regionMatch(local, n, 'CIA')) { // 'CIA' -> X
                        code = code + 'X'; 
                        n++;
                        continue;
                    }
                    if (!isLastChar(wdsz, n) && 
                        (FRONTV.indexOf(local.substring(n+1, n+2)) >= 0)) {
                        code = code + 'S';
                        n++;
                        continue; // CI,CE,CY -> S
                    }
                    if (isPreviousChar(local, n, 'S') &&
                        isNextChar(local, n, 'H')) { // SCH->sk
                        code = code + 'K'; 
                        n++;
                        continue;
                    }
                    if (isNextChar(local, n, 'H')) { // detect CH
                        if ((n == 0) && 
                            (wdsz >= 3) && 
                            isVowel(local,2)) { // CH consonant -> K consonant
                            code = code + 'K';
                        } else { 
                            code = code + 'X'; // CHvowel -> X
                        }
                    } else { 
                        code = code + 'K';
                    }
                }
                if(symb=='D'){
                    if (!isLastChar(wdsz, n + 1) && 
                        isNextChar(local, n, 'G') && 
                        (FRONTV.indexOf(local.substring(n+2, n+3)) >= 0)) { // DGE DGI DGY -> J 
                        code = code + 'J'; n += 2;
                    } else { 
                        code = code + 'T';
                    }
                }
                if(symb=='G'){ // GH silent at end or before consonant
                    if (isLastChar(wdsz, n + 1) && 
                        isNextChar(local, n, 'H')) {
                        n++;
                        continue;
                    }
                    if (!isLastChar(wdsz, n + 1) &&  
                        isNextChar(local,n,'H') && 
                        !isVowel(local,n+2)) {
                        n++;
                        continue;
                    }
                    if ((n > 0) && 
                        (regionMatch(local, n, 'GN') ||
                          regionMatch(local, n, 'GNED'))) {
                        n++;
                        continue; // silent G
                    }
                    if (isPreviousChar(local, n, 'G')) {
                        // NOTE: Given that duplicated chars are removed, 
                        // I don't see how this can ever be true
                        hard = true;
                    } else {
                        hard = false;
                    }
                    if (!isLastChar(wdsz, n) && 
                        (FRONTV.indexOf(local.substring(n+1, n+2)) >= 0) && 
                        (!hard)) {
                        code = code + 'J';
                    } else {
                        code = code + 'K';
                    }
                }
                if(symb=='H'){
                    if (isLastChar(wdsz, n)) {
                        n++;
                        continue; // terminal H
                    }
                    if ((n > 0) && 
                        (VARSON.indexOf(local.substring(n-1, n)) >= 0)) {
                        n++;
                        continue;
                    }
                    if (isVowel(local,n+1)) {
                        code = code + 'H'; // Hvowel
                    }
                }
                if(symb=='F'||symb=='J'||symb=='L'||symb=='M'||symb=='N'||symb=='R'){
                    code = code + symb; 
                }
                if(symb=='K'){
                    if (n > 0) { // not initial
                        if (!isPreviousChar(local, n, 'C')) {
                            code = code + symb;
                        }
                    } else {
                        code = code + symb; // initial K
                    }
                }
                if(symb=='P'){
                    if (isNextChar(local,n,'H')) {
                        // PH -> F
                        code = code + 'F';
                    } else {
                        code = code + symb;
                    }
                }
                if(symb=='Q'){
                    code = code + 'K';
                }
                if(symb=='S'){
                    if (regionMatch(local,n,'SH') || 
                        regionMatch(local,n,'SIO') || 
                        regionMatch(local,n,'SIA')) {
                        code = code + 'X';
                    } else {
                        code = code + 'S';
                    }
                }
                if(symb=='T'){
                    if (regionMatch(local,n,'TIA') || 
                        regionMatch(local,n,'TIO')) {
                        code = code + 'X'; 
                        n++;
                        continue;
                    }
                    if (regionMatch(local,n,'TCH')) {
                        // Silent if in 'TCH'
                        n++;
                        continue;
                    }
                    // substitute numeral 0 for TH (resembles theta after all)
                    if (regionMatch(local,n,'TH')) {
                        code = code + '0';
                    } else {
                        code = code + 'T';
                    }
                }
                if(symb=='V'){
                    code = code + 'F';
                }
                if(symb=='W'||symb=='Y'){ // silent if not followed by vowel
                    if (!isLastChar(wdsz,n) && 
                        isVowel(local,n+1)) {
                        code = code + symb;
                    }
                }
                if(symb=='X'){
                    code = code + 'K'; code = code + 'S';
                }
                if(symb=='Z'){
                    code = code + 'S';
                } // end switch
                n++;
            } // end else from symb != 'C'
            if (code.length() > this.getMaxCodeLen()) { 
                code = code.substring(0, this.getMaxCodeLen()); 
            }
        }
        return code;
    }

    private boolean isVowel(String str, Integer index) {
        return VOWELS.indexOf(str.substring(index, index+1)) >= 0;
    }

    private boolean isPreviousChar(String str, Integer index, String c) {
        boolean matches = false;
        if(index > 0 &&
            index < str.length()) {
            matches = str.substring(index-1, index) == c;
        }
        return matches;
    }

    private boolean isNextChar(String str, Integer index, String c) {
        boolean matches = false;
        if(index >= 0 &&
            index < str.length() - 1) {
            matches = str.substring(index+1, index+2) == c;
        }
        return matches;
    }

    private boolean regionMatch(String str, Integer index, String test) {
        boolean matches = false;
        if(index >= 0 &&
            (index + test.length() - 1) < str.length()) {
            String substring = str.substring(index, index + test.length());
            matches = substring.equals(test);
        }
        return matches;
    }

    private boolean isLastChar(Integer wdsz, Integer n) {
        return n + 1 == wdsz;
    } 
    
    /**
     * Encodes a String using the Metaphone algorithm. 
     *
     * @param pString String object to encode
     * @return The metaphone code corresponding to the String supplied
     */
    public String encode(String pString) {
        return getMetaphone(pString);   
    }

    /**
     * Tests is the metaphones of two strings are identical.
     *
     * @param str1 First of two strings to compare
     * @param str2 Second of two strings to compare
     * @return <code>true</code> if the metaphones of these strings are identical, 
     *        <code>false</code> otherwise.
     */
    public boolean isMetaphoneEqual(String str1, String str2) {
        return getMetaphone(str1).equals(getMetaphone(str2));
    }

    /**
     * Returns the maxCodeLen.
     * @return Integer
     */
    public Integer getMaxCodeLen() { return this.maxCodeLen; }

    /**
     * Sets the maxCodeLen.
     * @param maxCodeLen The maxCodeLen to set
     */
    public void setMaxCodeLen(Integer maxCodeLen) { this.maxCodeLen = maxCodeLen; }
    
    static testMethod void MetaphoneTestMethods() {
		Metaphone meta = new Metaphone();
		meta.getMetaphone('rajib');
		meta.getMetaphone('Geetha');
		meta.getMetaphone('rajeeb');
		meta.getMetaphone('Gita');
		meta.getMetaphone('Xerox');
		meta.getMetaphone('Jerox');
		meta.getMetaphone('Worry');
		meta.getMetaphone('ourry');
		meta.getMetaphone('Smith');
		meta.getMetaphone('smyth');
		
		meta.getMetaphone('earth');
		meta.getMetaphone('aspire');
		meta.getMetaphone('Tek');
		meta.getMetaphone('inspr');
		meta.getMetaphone('oval');
		meta.getMetaphone('umbrella');
		meta.getMetaphone('compare');
		meta.getMetaphone('very good');
		
	} 
}
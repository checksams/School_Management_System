/* MPL License text (see http://www.mozilla.org/MPL/) */

 
package org.icefaces.samples.showcase.example.ace.clientValidatePattern;

import java.io.Serializable;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;


@ManagedBean(name= ClientValidatePatternBean.BEAN_NAME)
@CustomScoped(value = "#{window}")

public class ClientValidatePatternBean implements Serializable {
    
    public static final String BEAN_NAME = "clientValidatePatternBean";
    public String getBeanName() { return BEAN_NAME; }
        
    private String value1;
    private String value2;
    
    public String getValue1() {
        return value1;
    }

    public void setValue1(String value1) {
        this.value1 = value1;
    }
    
    public String getValue2() {
        return value2;
    }

    public void setValue2(String value2) {
        this.value2 = value2;
    }
        
    
    

}

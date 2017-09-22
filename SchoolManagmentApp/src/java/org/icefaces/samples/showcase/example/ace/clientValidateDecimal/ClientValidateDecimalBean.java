/* MPL License text (see http://www.mozilla.org/MPL/) */

 
package org.icefaces.samples.showcase.example.ace.clientValidateDecimal;

import java.io.Serializable;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;


@ManagedBean(name= ClientValidateDecimalBean.BEAN_NAME)
@CustomScoped(value = "#{window}")

public class ClientValidateDecimalBean implements Serializable {
    
    public static final String BEAN_NAME = "clientValidateDecimalBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String value1;
    
    public String getValue1() {
        return value1;
    }

    public void setValue1(String value1) {
        this.value1 = value1;
    }
        
    
    
    

}
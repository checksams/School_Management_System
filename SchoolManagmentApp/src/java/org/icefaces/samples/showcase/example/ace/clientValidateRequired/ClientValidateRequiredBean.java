/* MPL License text (see http://www.mozilla.org/MPL/) */

 
package org.icefaces.samples.showcase.example.ace.clientValidateRequired;

import java.io.Serializable;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import java.util.ArrayList;
import java.util.List;
import javax.faces.model.SelectItem;

@ManagedBean(name= ClientValidateRequiredBean.BEAN_NAME)
@CustomScoped(value = "#{window}")

public class ClientValidateRequiredBean implements Serializable {
    
    public static final String BEAN_NAME = "clientValidateRequiredBean";
    public String getBeanName() { return BEAN_NAME; }       
    
    private String name;
    private String city;
    
    private List<String> selected = new ArrayList<String>();     

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public List<String> getSelected() {
        return selected;
    }

    public void setSelected(List<String> selected) {
        this.selected = selected;
    }
    
    

}
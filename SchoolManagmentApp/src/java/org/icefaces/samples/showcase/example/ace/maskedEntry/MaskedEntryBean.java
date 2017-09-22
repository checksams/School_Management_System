/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.maskedEntry;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= MaskedEntryBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class MaskedEntryBean implements Serializable {
    public static final String BEAN_NAME = "maskedEntryBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String dob;
    private String workPhone;
    private String mobilePhone;
    private String sin;
    
    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getSin() {
        return sin;
    }

    public void setSin(String sin) {
        this.sin = sin;
    }

    public String getWorkPhone() {
        return workPhone;
    }

    public void setWorkPhone(String workPhone) {
        this.workPhone = workPhone;
    }
}

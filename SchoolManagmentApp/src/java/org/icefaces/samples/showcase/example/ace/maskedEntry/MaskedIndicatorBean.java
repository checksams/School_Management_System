/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.maskedEntry;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ValueChangeEvent;

@ManagedBean(name= MaskedIndicatorBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class MaskedIndicatorBean implements Serializable
{
    public static final String BEAN_NAME = "maskedIndicatorBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private boolean required = true;
    private String requiredText = "This field is required.";
    private String optionalText = "Not mandatory.";
    private String position = "right";
    private String dob;
    private String workPhone;
    private String mobilePhone;
    private String sin;
    
    public boolean getRequired() {
        return required;
    }
    
    public String getRequiredText() {
        return requiredText;
    }

    public String getOptionalText() {
        return optionalText;
    }
    
    public String getPosition() {
        return position;
    }

    public String getSin() {
        return sin;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public String getWorkPhone() {
        return workPhone;
    }

    public String getDob() {
        return dob;
    }

    public boolean isRequired() {
        return required;
    }

    public void setRequired(boolean required) {
        this.required = required;
    }

    public void applyRequired(ValueChangeEvent e) {
        this.required = (Boolean) e.getNewValue();
    }
    
    public void setRequiredText(String requiredText) {
        this.requiredText = requiredText;
    }
    
    public void setOptionalText(String optionalText) {
        this.optionalText = optionalText;
    }
    
    public void setPosition(String position) {
        this.position = position;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public void setWorkPhone(String workPhone) {
        this.workPhone = workPhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public void setSin(String sin) {
        this.sin = sin;
    }
}

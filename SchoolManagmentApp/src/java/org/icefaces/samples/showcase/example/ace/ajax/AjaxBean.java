/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.ajax;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= AjaxBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AjaxBean implements Serializable 
{
    public static final String BEAN_NAME = "ajaxBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private boolean ajaxEnabled = true;
    private String textValue;
    private String selectValue;
    private int sliderValue;

    public boolean getAjaxEnabled() {
        return ajaxEnabled;
    }

    public void setAjaxEnabled(boolean ajaxEnabled) {
        this.ajaxEnabled = ajaxEnabled;
    }

    public String getTextValue() {
        return textValue;
    }

    public void setTextValue(String textValue) {
        this.textValue = textValue;
    }

    public String getSelectValue() {
        return selectValue;
    }

    public void setSelectValue(String selectValue) {
        this.selectValue = selectValue;
    }

    public int getSliderValue() {
        return sliderValue;
    }

    public void setSliderValue(int sliderValue) {
        this.sliderValue = sliderValue;
    }
}

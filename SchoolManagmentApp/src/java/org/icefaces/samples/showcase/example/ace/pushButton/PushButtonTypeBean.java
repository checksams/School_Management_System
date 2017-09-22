/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.pushButton;

import java.io.Serializable;
import java.util.Date;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= PushButtonTypeBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PushButtonTypeBean implements Serializable {

    public static final String BEAN_NAME = "pushButtonTypeBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String value1, value2;
    
    private int sliderValue;
    
    private Date selectedDate;
    
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

    public int getSliderValue() {
        return sliderValue;
    }

    public void setSliderValue(int sliderValue) {
        this.sliderValue = sliderValue;
    }

    public Date getSelectedDate() {
        return selectedDate;
    }

    public void setSelectedDate(Date selectedDate) {
        this.selectedDate = selectedDate;
    }

}
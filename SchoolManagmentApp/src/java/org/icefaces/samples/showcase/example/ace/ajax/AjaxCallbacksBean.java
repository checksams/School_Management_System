/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.ajax;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= AjaxCallbacksBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AjaxCallbacksBean implements Serializable
{
    public static final String BEAN_NAME = "ajaxCallbacksBean";
    public String getBeanName() { return BEAN_NAME; }

    private boolean value1 = true;
    private boolean value2 = true;
    private boolean value3 = true;

    public boolean getValue1() {
        return value1;
    }

    public void setValue1(boolean value1) {
        this.value1 = value1;
    }

    public boolean getValue2() {
        return value2;
    }

    public void setValue2(boolean value2) {
        this.value2 = value2;
    }

    public boolean getValue3() {
        return value3;
    }

    public void setValue3(boolean value3) {
        this.value3 = value3;
    }
}

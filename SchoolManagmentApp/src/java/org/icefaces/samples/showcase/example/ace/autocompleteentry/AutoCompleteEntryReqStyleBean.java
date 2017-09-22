/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.autocompleteentry;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= AutoCompleteEntryReqStyleBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AutoCompleteEntryReqStyleBean implements Serializable
{
    public static final String BEAN_NAME = "autoCompleteEntryReqStyleBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String selectedText1, selectedText2;
    private String reqColor = "redRS";
    private String optColor = "greenRS";

    public String getSelectedText1() { return selectedText1; }
    public String getSelectedText2() { return selectedText2; }
    
    public String getReqColor() {
        return reqColor;
    }
    
    public String getOptColor() {
        return optColor;
    }
    
    public void setSelectedText1(String selectedText1) { this.selectedText1 = selectedText1; }
    public void setSelectedText2(String selectedText2) { this.selectedText2 = selectedText2; }
    
    public void setReqColor(String reqColor) {
        this.reqColor = reqColor;
    }
    
    public void setOptColor(String optColor) {
        this.optColor = optColor;
    }
    
    private boolean useTheme = false;

    public boolean getUseTheme() {
        return useTheme;
    }

    public void setUseTheme(boolean useTheme) {
        this.useTheme = useTheme;
    }
}
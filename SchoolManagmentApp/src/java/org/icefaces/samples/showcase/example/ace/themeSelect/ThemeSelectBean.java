/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.themeSelect;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name = ThemeSelectBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ThemeSelectBean implements Serializable {
    public static final String BEAN_NAME = "themeSelectBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String theme;
    
    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }
}

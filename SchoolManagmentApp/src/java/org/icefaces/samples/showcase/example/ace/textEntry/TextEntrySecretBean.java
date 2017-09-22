/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.textEntry;

import java.io.Serializable;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

@ManagedBean(name= TextEntrySecretBean.BEAN_NAME)
@ViewScoped
public class TextEntrySecretBean implements Serializable
{
    public static final String BEAN_NAME = "textEntrySecretBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String username, password;
    private boolean showPassword;
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isShowPassword() {
        return showPassword;
    }

    public void setShowPassword(boolean showPassword) {
        this.showPassword = showPassword;
    }
}

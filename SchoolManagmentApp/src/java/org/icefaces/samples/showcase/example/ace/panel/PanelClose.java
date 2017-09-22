/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.panel;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= PanelClose.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PanelClose implements Serializable {

    public static final String BEAN_NAME = "panelClose";
    public String getBeanName() { return BEAN_NAME; }
    
    private boolean closable = true;
    private int speed = 700;
    
    public boolean getClosable() { return closable; }
    public int getSpeed() { return speed; }
    
    public void setClosable(boolean closable) { this.closable = closable; }
    public void setSpeed(int speed) { this.speed = speed; }
}

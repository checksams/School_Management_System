/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.panel;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= PanelToggle.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PanelToggle implements Serializable {

    public static final String BEAN_NAME = "panelToggle";
    public String getBeanName() { return BEAN_NAME; }

    private boolean toggleable = true;
    private int speed = 700;
    
    public boolean getToggleable() { return toggleable; }
    public int getSpeed() { return speed; }
    
    public void setToggleable(boolean toggleable) { this.toggleable = toggleable; }
    public void setSpeed(int speed) { this.speed = speed; }
}

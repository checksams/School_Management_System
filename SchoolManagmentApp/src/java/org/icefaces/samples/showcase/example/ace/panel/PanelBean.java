/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.panel;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

@ManagedBean(name= PanelBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PanelBean implements Serializable {
    public static final String BEAN_NAME = "panelBean";
    public String getBeanName() { return BEAN_NAME; }
    private boolean reOpenButton = false;
    
    private boolean collapsed = false;

    public boolean getCollapsed() { return collapsed; }
    public void setCollapsed(boolean collapsed) { this.collapsed = collapsed; }

    /**
     * use the close event of panels ace:ajax tag to make a show button visible
     * @param event
     */
    public void setButtonVisible(javax.faces.event.AjaxBehaviorEvent event){
       this.reOpenButton=true;
    }

    /**
     * use ace:ajax on the pushButton to reset it to not be rendered
     * @param event
     */
    public void buttonNotVisible(ActionEvent event){
        this.reOpenButton = false;
    }

    public boolean isReOpenButton() {
        return reOpenButton;
    }

    public void setReOpenButton(boolean reOpenButton) {
        this.reOpenButton = reOpenButton;
    }


}


/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.panel;

import java.io.Serializable;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

import org.icefaces.ace.event.CloseEvent;
import org.icefaces.ace.event.ToggleEvent;

@ManagedBean(name= PanelListener.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PanelListener implements Serializable {

    public static final String BEAN_NAME = "panelListener";
    public String getBeanName() { return BEAN_NAME; }
    private Format formatter = new SimpleDateFormat("HH:mm:ss");
    private String statusMessage = "No status yet.";
    private boolean reOpenButton = false;

    public String getStatusMessage() { return statusMessage; }
    
    public void setStatusMessage(String statusMessage) { this.statusMessage = statusMessage; }
    
    public void close(CloseEvent event) {
        statusMessage = "Close Event fired @ "+ formatter.format(new Date())+" server time";
        this.reOpenButton = true;
    }
    
    public void toggle(ToggleEvent event) {
        statusMessage = "Toggle Event fired @ "+ formatter.format(new Date())+ " server time";
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
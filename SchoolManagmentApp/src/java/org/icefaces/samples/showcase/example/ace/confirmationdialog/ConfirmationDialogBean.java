/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.confirmationdialog;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

@ManagedBean(name= ConfirmationDialogBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ConfirmationDialogBean implements Serializable {
    public static final String BEAN_NAME = "confirmationDialogBean";
    public String getBeanName() { return BEAN_NAME; }
    private String outcome = null;

    public void yes(ActionEvent actionEvent) {
            outcome = "You are sure";
    }

    public void no(ActionEvent actionEvent) { 
            outcome = "You are not sure";
    }

    public String getOutcome() {
            return outcome;
    }
}

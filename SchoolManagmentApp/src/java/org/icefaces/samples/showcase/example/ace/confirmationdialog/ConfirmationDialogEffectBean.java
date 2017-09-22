/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.confirmationdialog;

import java.io.Serializable;
import java.util.LinkedHashMap;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

@ManagedBean(name= ConfirmationDialogEffectBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ConfirmationDialogEffectBean implements Serializable {
    public static final String BEAN_NAME = "confirmationDialogEffectBean";
    public String getBeanName() { return BEAN_NAME; }
    private String showEffect;
    private String hideEffect;
    private String outcome;
    private LinkedHashMap<String, String> showEffects;
    private LinkedHashMap<String, String> hideEffects;

    public ConfirmationDialogEffectBean() {
        outcome = null;
        
        showEffects = initializeDialogShowEffects();
        hideEffects = initializeDialogHideEffects();
        showEffect = showEffects.get("Fade");
        hideEffect = hideEffects.get("Fade");
    }

        private LinkedHashMap<String, String> initializeDialogShowEffects()
        {
            LinkedHashMap<String, String> list = new LinkedHashMap<String, String>();
            list.put("Fade", "fade");
            list.put("Highlight", "highlight");
            list.put("Blind", "blind");
            list.put("Bounce", "bounce");
            list.put("Clip", "clip");
            list.put("Explode", "explode");
            list.put("Puff", "puff");
            list.put("Pulsate", "pulsate");
            list.put("Scale", "scale");
            list.put("Slide", "slide"); 
            list.put("Drop", "drop");
            list.put("Fold", "fold");
            list.put("Shake", "shake");
            return list;
    }
    
        private LinkedHashMap<String, String> initializeDialogHideEffects()
        {
            LinkedHashMap<String, String> list = new LinkedHashMap<String, String>();
            list.put("Fade", "fade");
            list.put("Highlight", "highlight");
            list.put("Blind", "blind");
            list.put("Bounce", "bounce");
            list.put("Clip", "clip");
            list.put("Explode", "explode");
            list.put("Puff", "puff");
            list.put("Scale", "scale");
            list.put("Slide", "slide");
            list.put("Drop", "drop");
            list.put("Fold", "fold");
            return list;
    }

    public void yes(ActionEvent actionEvent) { 
            outcome = "You clicked 'yes'";
    }

    public void no(ActionEvent actionEvent) { 
            outcome = "You clicked 'no'";
    }

    public String getOutcome() {
            return outcome;
    }

    public String getHideEffect() {
        return hideEffect;
    }

    public void setHideEffect(String hideEffect) {
        this.hideEffect = hideEffect;
    }

    public String getShowEffect() {
        return showEffect;
    }

    public void setShowEffect(String showEffect) {
        this.showEffect = showEffect;
    }

    public LinkedHashMap<String, String> getShowEffects() {
        return showEffects;
    }

    public void setShowEffects(LinkedHashMap<String, String> effects) {
        this.showEffects = effects;
    }
    
    public LinkedHashMap<String, String> getHideEffects() {
        return hideEffects;
    }

    public void setHideEffects(LinkedHashMap<String, String> effects) {
        this.hideEffects = effects;
    }
}


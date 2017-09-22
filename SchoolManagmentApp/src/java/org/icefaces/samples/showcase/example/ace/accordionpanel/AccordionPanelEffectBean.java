/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.accordionpanel;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= AccordionPanelEffectBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AccordionPanelEffectBean implements Serializable {
    public static final String BEAN_NAME = "accordionPanelEffectBean";
    public String getBeanName() { return BEAN_NAME; }
}
/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.richtextentry;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= RichTextEntryBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class RichTextEntryBean implements Serializable {
    public static final String BEAN_NAME = "richTextEntryBean";
    public String getBeanName() { return BEAN_NAME; }
    private String text = "";
    
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}

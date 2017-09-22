/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.textAreaEntry;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= TextAreaEntryBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class TextAreaEntryBean implements Serializable
{
    public static final String BEAN_NAME = "textAreaEntryBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private String comment1;
    private String comment2;

    public String getComment1() {
        return comment1;
    }

    public void setComment1(String comment) {
        this.comment1 = comment;
    }

    public String getComment2() {
        return comment2;
    }

    public void setComment2(String comment) {
        this.comment2 = comment;
    }
}

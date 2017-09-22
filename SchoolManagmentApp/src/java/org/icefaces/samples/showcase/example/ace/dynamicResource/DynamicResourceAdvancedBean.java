/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dynamicResource;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= DynamicResourceAdvancedBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DynamicResourceAdvancedBean implements Serializable
{
    public static final String BEAN_NAME = "dynamicResourceAdvancedBean";
    public String getBeanName() { return BEAN_NAME; }

    private String fileName = "icemobile.pdf";
    private String target = "_blank";
    private boolean attachment = true;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public boolean isAttachment() {
        return attachment;
    }

    public void setAttachment(boolean attachment) {
        this.attachment = attachment;
    }
}


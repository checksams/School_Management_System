/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.pushButton;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

import org.icefaces.samples.showcase.dataGenerators.ImageSet;
import org.icefaces.samples.showcase.dataGenerators.ImageSet.ImageInfo;

@ManagedBean(name= PushButtonBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class PushButtonBean implements Serializable {

    public static final String BEAN_NAME = "pushButton";
    public String getBeanName() { return BEAN_NAME; }
    private ImageSet.ImageInfo currentImage;
    
    public PushButtonBean() {
        currentImage = ImageSet.getNextImage(currentImage);
    }

    public String executeAction() {
        return null;
    }
    
    public void executeListener(ActionEvent event) { 
        currentImage = ImageSet.getNextImage(currentImage);
    }
    
    public ImageInfo getCurrentImage() {
        return currentImage;
    }

    public void setCurrentImage(ImageInfo currentImage) {
        this.currentImage = currentImage;
    }
}


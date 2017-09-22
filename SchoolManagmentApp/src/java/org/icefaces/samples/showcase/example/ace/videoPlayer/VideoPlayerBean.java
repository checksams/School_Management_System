/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.videoPlayer;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name = VideoPlayerBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class VideoPlayerBean implements Serializable {
    public static final String BEAN_NAME = "videoPlayerBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private boolean autoplay = false;
    private boolean newWindow = false;
    private boolean loop = false;

    private String linkLabel = null;
    private String value = "./media/penrosetriangle.mp4";

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public boolean isAutoplay() {
        return autoplay;
    }

    public void setAutoplay(boolean autoplay) {
        this.autoplay = autoplay;
    }

    public boolean isNewWindow() {
        return newWindow;
    }

    public void setNewWindow(boolean newWindow) {
        this.newWindow = newWindow;
    }

    public boolean isLoop() {
        return loop;
    }

    public void setLoop(boolean loop) {
        this.loop = loop;
    }

    public String getLinkLabel() {
        return linkLabel;
    }

    public void setLinkLabel(String linkLabel) {
        this.linkLabel = linkLabel;
    }
}


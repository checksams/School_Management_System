/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.audioPlayer;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name = AudioPlayerBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AudioPlayerBean implements Serializable {
    public static final String BEAN_NAME = "audioPlayerBean";
    public String getBeanName() { return BEAN_NAME; }

    private boolean autoplay = false;
    private boolean newWindow = false;
    private boolean loop = false;
    private boolean muted = false;

    private String linkLabel = null;
    private String value = "./media/canary.mp3";

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

    public boolean isMuted() {
        return muted;
    }

    public void setMuted(boolean muted) {
        this.muted = muted;
    }

    public String getLinkLabel() {
        return linkLabel;
    }

    public void setLinkLabel(String linkLabel) {
        this.linkLabel = linkLabel;
    }
}


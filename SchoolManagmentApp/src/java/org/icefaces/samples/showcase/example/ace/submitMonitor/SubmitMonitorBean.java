/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.submitMonitor;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ValueChangeEvent;

@ManagedBean(name= SubmitMonitorBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class SubmitMonitorBean implements Serializable {
    public static final String BEAN_NAME = "submitMonitor";
    public String getBeanName() { return BEAN_NAME; }
    
    private static final long SLEEP = 2000;

    public void sleep(long time) {
        try {
            Thread.sleep(time);
        }catch(InterruptedException ignored) { }
    }
    
    public void sleep() {
        sleep(SLEEP);
    }
    
    public void sleepLong() {
        sleep(SLEEP*2l);
    }
    
    public void sleepListener(ValueChangeEvent event) {
        sleep();
    }
}


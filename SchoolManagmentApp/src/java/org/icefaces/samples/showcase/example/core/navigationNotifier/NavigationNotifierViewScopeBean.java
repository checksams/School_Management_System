/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.core.navigationNotifier;

import java.io.Serializable;

import javax.annotation.PreDestroy;
import javax.faces.application.Application;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIViewRoot;
import javax.faces.context.FacesContext;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.PreValidateEvent;
import javax.faces.event.SystemEvent;
import javax.faces.event.SystemEventListener;

//import org.icefaces.samples.showcase.view.menu.ParamHandler;

@ManagedBean(name = NavigationNotifierViewScopeBean.BEAN_NAME)
@ViewScoped
public class NavigationNotifierViewScopeBean implements Serializable {
    public static final String BEAN_NAME = "navigationNotifierViewScopeBean";

    public NavigationNotifierViewScopeBean() {
        app = FacesContext.getCurrentInstance().getApplication();
        app.subscribeToEvent(PreValidateEvent.class, resetState);
    }

    private boolean navigationDetected;
    private Application app;
    private SystemEventListener resetState = new SystemEventListener() {
        public void processEvent(SystemEvent event) throws AbortProcessingException {
            navigationDetected = false;
        }

        public boolean isListenerForSource(Object source) {
            return source instanceof UIViewRoot;
        }
    };

    public String navigationDetectedEvent() {
        navigationDetected = true;
        
        return null;
    }

    public boolean getNavigationDetected() {
        return navigationDetected;
    }

    public void setNavigationDetected(boolean navigationDetected) {
        this.navigationDetected = navigationDetected;
    }

    public String getNavigateBackURI() {
        final FacesContext context = FacesContext.getCurrentInstance();
        return null; //context.getApplication().getViewHandler().getResourceURL(context, "/showcase.jsf?" + ParamHandler.URL_PARAM_GROUP + "=icecore:navigationNotifier&" + ParamHandler.URL_PARAM_DEMO + "=Overview");
    }

    @PreDestroy
    public void reset() {
        app.unsubscribeFromEvent(PreValidateEvent.class, resetState);
    }
}

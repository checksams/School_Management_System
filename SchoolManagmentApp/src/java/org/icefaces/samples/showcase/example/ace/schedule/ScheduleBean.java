/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.schedule;

import org.icefaces.ace.model.schedule.ScheduleEvent;
import org.icefaces.ace.model.schedule.LazyScheduleEventList;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.model.SelectItem;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;

@ManagedBean(name= ScheduleBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ScheduleBean implements Serializable {
    public static final String BEAN_NAME = "scheduleBean";
    public String getBeanName() { return BEAN_NAME; }

    private List<ScheduleEvent> events;

    public ScheduleBean() {
        events = (new DefaultDistributionEventGenerator()).getEvents();
    }

    public List<ScheduleEvent> getEvents() { return events; }
    public void setEvents(List<ScheduleEvent> events) { this.events = events; }

    private String viewMode = "month";
    public String getViewMode() { return viewMode; }
    public void setViewMode(String viewMode) { this.viewMode = viewMode; }
}

/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.schedule;

import org.icefaces.ace.model.schedule.ScheduleEvent;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * This class generates a random sample of events of various durations.
 */
public class RandomEventGenerator implements Serializable{

    private List<ScheduleEvent> events = null;

    public List<ScheduleEvent> getEvents() {

        if (events == null) {

            events = new ArrayList<ScheduleEvent>();

            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int nextYear = year + 1;
            for (--year; year <= nextYear; year++) {
                for (int i = 0; i < 12; i++) {
                    events.addAll(generateRandomEventList(year, i));
                }
            }
        }

        return events;
    }

    private List<ScheduleEvent> generateRandomEventList(int year, int month) {

        Random randomEvents = new Random();
        Random randomDays = new Random();
        Random randomHours = new Random();
        Random randomMinutes = new Random();
        Random randomDurationHours = new Random();

        ArrayList<ScheduleEvent> list = new ArrayList<ScheduleEvent>();
        int eventsNumber = randomEvents.nextInt(11) + 20; // from 20 to 30 events
        for (int i = 0; i < eventsNumber; i++) {
            ScheduleEvent event = new ScheduleEvent();
            int day = randomDays.nextInt(27) + 1;
            int startHours = randomHours.nextInt(21);
            int startMinutes = randomMinutes.nextInt(2) * 30;
            int duration = randomDurationHours.nextInt(4) + 1;
            event.setStartDate(getDate(year, month, day, startHours, startMinutes));
            event.setEndDate(getDate(year, month, day, startHours + duration, startMinutes));
            event.setTitle("Event " + i);
            event.setLocation("Some location");
            event.setNotes("Random notes...");
            list.add(event);
        }
        eventsNumber = randomEvents.nextInt(11) + 10; // from 10 to 20 events
        for (int i = 0; i < eventsNumber; i++) {
            ScheduleEvent event = new ScheduleEvent();
            int day = randomDays.nextInt(27) + 1;
            int startHours = randomHours.nextInt(21);
            int startMinutes = randomMinutes.nextInt(2) * 30;
            int duration = randomDurationHours.nextInt(4) + 1;
            event.setStartDate(getDate(year, month, day, startHours, startMinutes));
            event.setEndDate(getDate(year, month, day, startHours + duration, startMinutes));
            event.setTitle("Meeting " + i);
            event.setLocation("Some meeting room");
            event.setNotes("Meeting notes...");
            event.setStyleClass("schedule-yellow");
            list.add(event);
        }
        eventsNumber = randomEvents.nextInt(3) + 3; // from 3 to 5 events
        for (int i = 0; i < eventsNumber; i++) {
            ScheduleEvent event = new ScheduleEvent();
            int day = randomDays.nextInt(27) + 1;
            int duration = randomDurationHours.nextInt(2);
            event.setStartDate(getDate(year, month, day, 0, 0));
            event.setEndDate(getDate(year, month, day + duration, 23, 59));
            event.setTitle("Public Event " + i);
            event.setLocation("Some public location");
            event.setNotes("Public event notes...");
            event.setStyleClass("schedule-green");
            event.setAllDay(true);
            list.add(event);
        }
        return list;
    }

    private Date getDate(int year, int month, int day, int hours, int minutes) {
        Calendar cal = Calendar.getInstance();
        cal.set(year, month, day, hours, minutes);
        cal.set(Calendar.SECOND, 0);
        return cal.getTime();
    }
}

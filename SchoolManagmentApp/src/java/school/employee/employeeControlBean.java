/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package school.employee;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import org.icefaces.ace.event.SelectEvent;
import org.icefaces.ace.event.UnselectEvent;
import org.icefaces.ace.model.table.RowStateMap;

/**
 *
 * @author Samuel Nyong'a
 * @date 30-March-2017
 */

@ManagedBean(name= employeeControlBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class employeeControlBean  implements Serializable {    

    public employeeControlBean(){
        super(); 
    }
    public static final String BEAN_NAME = "employeeControlBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private static final int EVENT_SIZE = 5;
    
    private List<String> eventLog = new ArrayList<String>(EVENT_SIZE);
    private List selectedRows;
    private RowStateMap stateMap = new RowStateMap();
    private List<employee> employeeData;
    public int getEventSize() { return EVENT_SIZE; }
    
    /////////////---- EVENT LISTENERS BEGIN
    public void selectListener(SelectEvent event) {
        addEvent((employee)event.getObject(), "selected");
    }

    public void deselectListener(UnselectEvent event) {
        addEvent((employee)event.getObject(), "deselected");
    }
    /////////////---- PRIVATE METHODS BEGIN
    private void addEvent(employee employee, String action) {
        StringBuilder sb = new StringBuilder(40);
        sb.append("employee \"");
        sb.append(employee.getEmp_surname());
        sb.append("\" (id ");
        sb.append(employee.getEmp_code());
        sb.append(") was ");
        sb.append(action);
        sb.append(".");
        getEventLog().add(0, sb.toString());
            
        
        // Cap the list at the displayed row size
        if (getEventLog().size() > getEVENT_SIZE()) {
            setEventLog(getEventLog().subList(0, getEVENT_SIZE()));
            System.out.println("Emp_surname="+employee.getEmp_surname()+" "+employee.getEmp_other_names());
        }
    }
    public RowStateMap getStateMap() { return stateMap; }

    public void setStateMap(RowStateMap stateMap) {
        this.stateMap = stateMap;
    }
        
    public static int getEVENT_SIZE() {
        return EVENT_SIZE;
    }
    public List<String> getEventLog() {
        return eventLog;
    }
    public void setEventLog(List<String> eventLog) {
        this.eventLog = eventLog;
    }
    public List getSelectedRows() {
        return selectedRows;
    }
    public void setSelectedRows(List selectedRows) {
        this.selectedRows = selectedRows;
    }
    public List<employee> getEmployeeData() {
        return employeeData;
    }
    public void setEmployeeData(List<employee> employeeData) {
        this.employeeData = employeeData;
    }

}

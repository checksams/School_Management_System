/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataTable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name= DataTableColumnResizing.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataTableColumnResizing implements Serializable {
    public static final String BEAN_NAME = "dataTableColumnResizing";
    public String getBeanName() { return BEAN_NAME; }
    
    private List<Car> cars;
    /////////////---- CONSTRUCTOR BEGIN
    public DataTableColumnResizing() 
    {
        this.cars = new ArrayList<Car>(DataTableData.getDefaultData());
    }

    /////////////---- GETTERS & SETTERS BEGIN
    public List<Car> getCars() { return cars; }
    public void setCars(List<Car> cars) { this.cars = cars; }
}


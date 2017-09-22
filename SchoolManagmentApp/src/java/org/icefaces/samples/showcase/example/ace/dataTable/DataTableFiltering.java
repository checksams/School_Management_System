/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataTable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.model.SelectItem;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name= DataTableFiltering.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataTableFiltering implements Serializable {
    public static final String BEAN_NAME = "dataTableFiltering";
    public String getBeanName() { return BEAN_NAME; }
    private List<Car> carsData;
    private List<SelectItem> accelOptions = new ArrayList<SelectItem>() {{
        add(new SelectItem(""));
        add(new SelectItem(5));
        add(new SelectItem(10));
        add(new SelectItem(15));
    }};

    /////////////---- CONSTRUCTOR BEGIN
    public DataTableFiltering() {
        carsData = new ArrayList<Car>(DataTableData.getDefaultData()); 
        //carsData = new ArrayList<>(); 
        //carsData = DataTableData.getDefaultData();
    }

    /////////////---- GETTERS & SETTERS BEGIN
    public List<Car> getCarsData() { return carsData; }
    public void setCarsData(List<Car> carsData) { this.carsData = carsData; }

    public List<SelectItem> getAccelOptions() {
        return accelOptions;
    }

    public void setAccelOptions(List<SelectItem> accelOptions) {
        this.accelOptions = accelOptions;
    }
}


/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataTable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name= DataTableBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataTableBean implements Serializable {
    public static final String BEAN_NAME = "dataTableBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private List<Car> carsData;
    /////////////---- CONSTRUCTOR BEGIN
    public DataTableBean() {
        carsData = new ArrayList<Car>(DataTableData.getDefaultData());
        
        
    }

    /////////////---- GETTERS & SETTERS BEGIN
    public List<Car> getCarsData() { return carsData; }
    public void setCarsData(List<Car> carsData) { this.carsData = carsData; }
}

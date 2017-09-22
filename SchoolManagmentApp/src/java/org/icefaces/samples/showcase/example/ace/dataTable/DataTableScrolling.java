/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataTable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name= DataTableScrolling.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataTableScrolling implements Serializable {
    public static final String BEAN_NAME = "dataTableScrolling";
    public String getBeanName() { return BEAN_NAME; }
    
    private boolean scrolling = true;
    private int height = 200;
    private List<Car> carsData;
    /////////////---- CONSTRUCTOR BEGIN
    public DataTableScrolling() {
        carsData = new ArrayList<Car>(DataTableData.getDefaultData());
    }

    /////////////---- GETTERS & SETTERS BEGIN
    public List<Car> getCarsData() { return carsData; }
    public void setCarsData(List<Car> carsData) { this.carsData = carsData; }
    public boolean getScrolling() { return scrolling; }
    public int getHeight() { return height; }
    public void setScrolling(boolean scrolling) { this.scrolling = scrolling; }
    public void setHeight(int height) { this.height = height; }
}


/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.columnGroup;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
//import org.icefaces.samples.showcase.example.ace.dataTable.Car;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name = ColumnGroupBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ColumnGroupBean implements Serializable {
    public static final String BEAN_NAME = "columnGroupBean";
    public String getBeanName() { return BEAN_NAME; }

    public ColumnGroupBean() {
        this.cars = new ArrayList<Car>(DataTableData.getDefaultData());
    }
    
    private List<Car> cars;

    public List<Car> getCars() { return cars; }
    public void setCars(List<Car> cars) { this.cars = cars; }

}


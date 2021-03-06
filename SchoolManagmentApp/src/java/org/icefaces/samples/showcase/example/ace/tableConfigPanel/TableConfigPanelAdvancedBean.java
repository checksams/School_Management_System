/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.tableConfigPanel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;

import org.icefaces.samples.showcase.dataGenerators.utilityClasses.DataTableData;
//import org.icefaces.samples.showcase.example.ace.dataTable.Car;
import org.icefaces.samples.showcase.example.compat.dataTable.Car;

@ManagedBean(name= TableConfigPanelAdvancedBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class TableConfigPanelAdvancedBean implements Serializable
{
    public static final String BEAN_NAME = "tableConfigPanelAdvancedBean";
    public String getBeanName() { return BEAN_NAME; }

    public TableConfigPanelAdvancedBean() {
        carsData = new ArrayList<Car>(DataTableData.getDefaultData());
    }
    
    private List<Car> carsData;

    public List<Car> getCarsData() { return carsData; }
    public void setCarsData(List<Car> carsData) { this.carsData = carsData; }
    
    private ColumnSettings[] savedColumns = getDefaultColumns();
    private ColumnSettings[] columns = getDefaultColumns();
    private ColumnSettings[] savedHeaderColumns = getDefaultHeaderColumns();
    private ColumnSettings[] headerColumns = getDefaultHeaderColumns();
    private List<Integer> savedColumnOrder = getDefaultColumnOrder();
    private List<Integer> columnOrder = getDefaultColumnOrder();
    private List<Integer> savedColumnHeaderOrder = getDefaultColumnHeaderOrder();
    private List<Integer> columnHeaderOrder = getDefaultColumnHeaderOrder();
    
    private ColumnSettings[] getDefaultColumns() {
        return new ColumnSettings[] { new ColumnSettings(true, "ID", null, false),
            new ColumnSettings(true, "Name", null, false), new ColumnSettings(true, "Chassis", null, false), new ColumnSettings(true, "Weight", null, false),
            new ColumnSettings(true, "Accel", null, false), new ColumnSettings(true, "MPG", null, false), new ColumnSettings(true, "Cost", null, false)};
    }

    private ColumnSettings[] getDefaultHeaderColumns() {
        return new ColumnSettings[] { new ColumnSettings(true, "Car Details", null, false),
            new ColumnSettings(true, "Model", null, false), new ColumnSettings(true, "Specifications", null, false), new ColumnSettings(true, "Cost", null, false)};
    }

    private List<Integer> getDefaultColumnOrder() {
        List<Integer> order = new ArrayList<Integer>();
        order.add(0);
        order.add(1);
        order.add(2);
        order.add(3);
        order.add(4);
        order.add(5);
        order.add(6);
        return order;
    }

    private List<Integer> getDefaultColumnHeaderOrder() {
        List<Integer> order = new ArrayList<Integer>();
        order.add(0);
        order.add(1);
        order.add(2);
        order.add(3);
        order.add(4);
        order.add(5);
        order.add(6);
        order.add(7);
        order.add(8);
        order.add(9);
        order.add(10);
        return order;
    }

    public ColumnSettings[] getColumns() {
        return columns;
    }

    public ColumnSettings[] getHeaderColumns() {
        return headerColumns;
    }

    public List<Integer> getColumnOrder() {
        return columnOrder;
    }

    public void setColumnOrder(List<Integer> columnOrder) {
        this.columnOrder = columnOrder;
    }

    public List<Integer> getColumnHeaderOrder() {
        return columnHeaderOrder;
    }

    public void setColumnHeaderOrder(List<Integer> columnHeaderOrder) {
        this.columnHeaderOrder = columnHeaderOrder;
    }

    public void saveSettings(ActionEvent event) {
        savedColumns = copyColumns(columns);
        savedHeaderColumns = copyColumns(headerColumns);
        savedColumnOrder = columnOrder;
        savedColumnHeaderOrder = columnHeaderOrder;
    }

    public void restoreSavedSettings(ActionEvent event) {
        columns = copyColumns(savedColumns);
        headerColumns = copyColumns(savedHeaderColumns);
        columnOrder = savedColumnOrder;
        columnHeaderOrder = savedColumnHeaderOrder;
    }

    public void restoreDefaultSettings(ActionEvent event) {
        columns = getDefaultColumns();
        headerColumns = getDefaultHeaderColumns();
        columnOrder = getDefaultColumnOrder();
        columnHeaderOrder = getDefaultColumnHeaderOrder();
        carsData = new ArrayList<Car>(DataTableData.getDefaultData()); // for undoing sorting
    }

    private ColumnSettings[] copyColumns(ColumnSettings[] columns) {
        int length = columns.length;
        ColumnSettings[] copy = new ColumnSettings[length];
        for (int i = 0; i < length; i++) {
            ColumnSettings cs = columns[i];
            copy[i] = new ColumnSettings(cs.rendered, cs.name, cs.sortPriority, cs.sortAscending);
        }
        return copy;
    }

    public static class ColumnSettings implements Serializable {
        private boolean rendered;
        private String name;
        private Integer sortPriority;
        private boolean sortAscending;

        public ColumnSettings(boolean rendered, String name, Integer sortPriority, boolean sortAscending) {
            this.rendered = rendered;
            this.name = name;
            this.sortPriority = sortPriority;
            this.sortAscending = sortAscending;
        }

        public boolean isRendered() {
            return rendered;
        }

        public void setRendered(boolean rendered) {
            this.rendered = rendered;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Integer getSortPriority() {
            return sortPriority;
        }

        public void setSortPriority(Integer sortPriority) {
            this.sortPriority = sortPriority;
        }

        public boolean isSortAscending() {
            return sortAscending;
        }

        public void setSortAscending(boolean sortAscending) {
            this.sortAscending = sortAscending;
        }
    }
}


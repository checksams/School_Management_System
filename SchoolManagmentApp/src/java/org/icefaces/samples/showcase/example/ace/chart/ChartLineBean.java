/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.chart;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.ace.component.chart.Axis;
import org.icefaces.ace.component.chart.AxisType;
import org.icefaces.ace.model.chart.CartesianSeries;

@ManagedBean(name= ChartLineBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ChartLineBean implements Serializable {
    public static final String BEAN_NAME = "chartLineBean";
    public String getBeanName() { return BEAN_NAME; }

    private List<CartesianSeries> lineData = new ArrayList<CartesianSeries>() {{
        add(new CartesianSeries() {{
            add("Nickle", 28);
            add("Aluminum", 13);
            add("Xenon", 54);
            add("Silver", 47);
            add("Sulfur", 16);
            add("Silicon", 14);
            add("Vanadium", 23);
            setLabel("Resources / Demand");
        }});
    }};

    private Axis[] yAxes = new Axis[] {
            new Axis() {{
                setAutoscale(true);
                setTickInterval("5");
                setLabel("Tonnes");
            }}
    };

    private Axis xAxis = new Axis() {{
        setTicks(new String[] {"Nickle", "Aluminum", "Xenon", "Silver", "Sulfur", "Silicon", "Vanadium"});
        setType(AxisType.CATEGORY);
    }};


    public List<CartesianSeries> getLineData() {
        return lineData;
    }

    public void setLineData(List<CartesianSeries> lineData) {
        this.lineData = lineData;
    }

    public Axis[] getyAxes() {
        return yAxes;
    }

    public void setyAxes(Axis[] yAxes) {
        this.yAxes = yAxes;
    }

    public Axis getxAxis() {
        return xAxis;
    }

    public void setxAxis(Axis xAxis) {
        this.xAxis = xAxis;
    }
}

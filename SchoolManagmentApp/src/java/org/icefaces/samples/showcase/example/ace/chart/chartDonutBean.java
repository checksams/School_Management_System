/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.chart;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.ace.model.chart.ChartSeries;
import org.icefaces.ace.model.chart.SectorSeries;
import org.icefaces.ace.model.chart.SectorSeries.SectorType;

@ManagedBean(name= ChartDonutBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ChartDonutBean implements Serializable
{
    public static final String BEAN_NAME = "chartDonutBean";
    public String getBeanName() { return BEAN_NAME; }

    private SectorSeries model = new SectorSeries();
    
    private List<SectorSeries> donutData = new ArrayList<SectorSeries>() {{
        add(new SectorSeries() {{
            add("a", 6);
            add("b", 8);
            add("c", 14);
            add("d", 20);
        }});
        add(new SectorSeries() {{
            add("a", 8);
            add("b", 12);
            add("c", 6);
            add("d", 9);
        }});
    }};
    
    @PostConstruct
    public void init() {
        model.setType(SectorType.DONUT);
    }
    
    public List<SectorSeries> getDonutData() {
        return donutData;
    }

    public void setDonutData(List<SectorSeries> donutData) {
        this.donutData = donutData;
    }

    public ChartSeries getModel() {
        return (ChartSeries)model;
    }

}

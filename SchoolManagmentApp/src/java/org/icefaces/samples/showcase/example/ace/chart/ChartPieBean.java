/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.chart;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.ace.model.chart.SectorSeries;

@ManagedBean(name= ChartPieBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ChartPieBean implements Serializable
{
    public static final String BEAN_NAME = "chartPieBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private List<SectorSeries> pieData = new ArrayList<SectorSeries>() {{
        add(new SectorSeries() {{
            add("Heavy Industry", 12);
            add("Retail", 9);
            add("Light Industry", 14);
            add("Out of Home", 16);
            add("Commuting", 7);
            add("Orientation", 9);
            setShowDataLabels(true);
            setDataLabelFormatString("%.2f%%") ;
            setSliceMargin(4);
            setFill(false);
        }});
    }};
    
    public List<SectorSeries> getPieData() {
        return pieData;
    }

    public void setPieData(List<SectorSeries> pieData) {
        this.pieData = pieData;
    }
}

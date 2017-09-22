/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.chart;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.faces.application.Resource;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;

import org.icefaces.ace.component.chart.Axis;
import org.icefaces.ace.component.chart.AxisType;
import org.icefaces.ace.event.ChartImageExportEvent;
import org.icefaces.ace.model.chart.CartesianSeries;
import org.icefaces.ace.model.chart.DragConstraintAxis;

@ManagedBean(name= ChartCombinedBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class ChartCombinedBean implements Serializable
{
    public static final String BEAN_NAME = "chartCombinedBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private List<CartesianSeries> barData = new ArrayList<CartesianSeries>() {{
        add(new CartesianSeries() {{
            add("Nickle", 28);
            add("Aluminum", 13);
            add("Xenon", 54);
            add("Silver", 47);
            add("Sulfur", 16);
            add("Silicon", 14);
            add("Vanadium", 23);
            setDragable(true);
            setDragConstraintAxis(DragConstraintAxis.Y);
            setLabel("Resources / Demand");
            setYAxis(2);
            setXAxis(2);
        }});

        add(new CartesianSeries() {{
            setType(CartesianType.BAR);
            add("HDTV Receiver", 15);
            add("Cup Holder Pinion Bob", 7);
            add("Generic Fog Lamp", 9);
            add("8 Track Control Module", 12);
            add("Sludge Pump Fourier Modulator", 3);
            add("Transceiver Spice Rack", 6);
            add("Hair Spray Danger Indicator", 18);
            setLabel("Product / Sales");
        }});
    }};
    
    private Axis barDemoDefaultAxis = new Axis() {{
        setTickAngle(-30);
    }};

    private Axis barDemoXOneAxis = new Axis() {{
        setType(AxisType.CATEGORY);
    }};

    private Axis[] barDemoYAxes = new Axis[] {
        new Axis() {{
            setAutoscale(true);
            setTickInterval("5");
            setLabel("USD Millions");
        }},
        new Axis() {{
            setAutoscale(true);
            setTickInterval("5");
            setLabel("Tonnes");
        }}
    };

    private Axis barDemoXTwoAxis = new Axis() {{
        setTicks(new String[] {"Nickle", "Aluminum", "Xenon", "Silver", "Sulfur", "Silicon", "Vanadium"});
        setType(AxisType.CATEGORY);
    }};
    
    public List<CartesianSeries> getBarData() {
        return barData;
    }

    public void setBarData(List<CartesianSeries> barData) {
        this.barData = barData;
    }
    
    public Axis getBarDemoXOneAxis() {
        return barDemoXOneAxis;
    }

    public void setBarDemoXOneAxis(Axis barDemoXOneAxis) {
        this.barDemoXOneAxis = barDemoXOneAxis;
    }

    public Axis getBarDemoDefaultAxis() {
        return barDemoDefaultAxis;
    }

    public void setBarDemoDefaultAxis(Axis barDemoDefaultAxis) {
        this.barDemoDefaultAxis = barDemoDefaultAxis;
    }

    public Axis getBarDemoXTwoAxis() {
        return barDemoXTwoAxis;
    }

    public void setBarDemoXTwoAxis(Axis barDemoXTwoAxis) {
        this.barDemoXTwoAxis = barDemoXTwoAxis;
    }

    public Axis[] getBarDemoYAxes() {
        return barDemoYAxes;
    }

    public void setBarDemoYAxes(Axis[] barDemoYAxes) {
        this.barDemoYAxes = barDemoYAxes;
    }
    
    private byte[] image;

    public void saveImage(ChartImageExportEvent event) {
        image = event.getBytes();
    }

    public Resource getSavedImage() {
        return new Resource() {
            public InputStream getInputStream() throws IOException {
                return new ByteArrayInputStream(image);
            }

            public Map<String, String> getResponseHeaders() {
                return Collections.EMPTY_MAP;
            }

            public String getRequestPath() {
                return null;  
            }

            public URL getURL() {
                return null;  
            }

            public boolean userAgentNeedsUpdate(FacesContext context) {
                return true;
            }
        };
    }

    public boolean isImageSaved() {
        return image != null && image.length > 0;
    }
}

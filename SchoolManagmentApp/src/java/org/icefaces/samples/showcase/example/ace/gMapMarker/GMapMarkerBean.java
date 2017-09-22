/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.gMapMarker;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= GMapMarkerBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class GMapMarkerBean implements Serializable {
    public static final String BEAN_NAME = "gMapMarkerBean";
    public String getBeanName() { return BEAN_NAME; }
    private Double[] latList = {0.0,7.5,-10.0};
    private Double[] longList = {0.0,7.5,-10.0};
    private String[] optionsList = {"title:'Hover mouse over this marker to see title'","raiseOnDrag:false,draggable:true","draggable:true"};

    public Double[] getLatList() {
        return latList;
    }

    public void setLatList(Double[] latList) {
        this.latList = latList;
    }

    public Double[] getLongList() {
        return longList;
    }

    public void setLongList(Double[] longList) {
        this.longList = longList;
    }

    public String[] getOptionsList() {
        return optionsList;
    }

    public void setOptionsList(String[] optionsList) {
        this.optionsList = optionsList;
    }
}


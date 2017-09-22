/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataExporter;

import java.io.Serializable;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= DataExporterBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataExporterBean implements Serializable {
    public static final String BEAN_NAME = "dataExporterBean";
    public String getBeanName() { return BEAN_NAME; }
    private String type;

    public DataExporterBean() {
        this.type = "csv";
    }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}


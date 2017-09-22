/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.accordionpanel;

import java.io.Serializable;
import java.util.ArrayList;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

import org.icefaces.ace.event.AccordionPaneChangeEvent;
import org.icefaces.samples.showcase.dataGenerators.ImageSet;

@ManagedBean(name= AccordionPanelDynamicBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class AccordionPanelDynamicBean implements Serializable 
{
    public static final String BEAN_NAME = "accordionPanelDynamicBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private ArrayList<ImageSet.ImageInfo> imagesOfCars;
    private ArrayList<ImageSet.ImageInfo> imagesOfElectronicDevices;
    private ArrayList<ImageSet.ImageInfo> imagesOfFood;
    private String tabChangeDescriptor;
    
    public AccordionPanelDynamicBean() 
    {
        initializeInstanceVariables();
    }
    
    ////////////////////////////////////////////ON TAB CHANGE EVENT BEGIN/////////////////////////////////////////////////
    public void onPaneChange(AccordionPaneChangeEvent event)
    {  
        tabChangeDescriptor = event.getTab().getTitle();
    }
    
    /////////////////////////////////////////////////PRIVATE METHODS BEGIN//////////////////////////////////////////////////
    private void initializeInstanceVariables() 
    {
        this.imagesOfElectronicDevices = ImageSet.getImages(ImageSet.ImagesSelect.GADGETS);
        this.imagesOfCars = ImageSet.getImages(ImageSet.ImagesSelect.CARS);
        this.imagesOfFood = ImageSet.getImages(ImageSet.ImagesSelect.FOOD);
    }
    
    //////////////////////////////////////////////////GETTERS&SETTERS BEGIN////////////////////////////////////////////////
    public ArrayList<ImageSet.ImageInfo> getImagesOfCars()
    {
        return imagesOfCars;
    }

    public int getImagesOfCarsSize(){
        return imagesOfCars != null ? imagesOfCars.size():0;
    }

    public ArrayList<ImageSet.ImageInfo> getImagesOfElectronicDevices()
    {
        return imagesOfElectronicDevices;
    }

    public int getImagesOfElectronicDevicesSize(){
        return imagesOfElectronicDevices != null? imagesOfElectronicDevices.size():0;
    }

    public ArrayList<ImageSet.ImageInfo> getImagesOfFood() {
        return imagesOfFood;
    }

    public int getImagesOfFoodSize(){
        return imagesOfFood != null ? imagesOfFood.size(): 0;
    }

    public String getTabChangeDescriptor() {
        if(tabChangeDescriptor == null)
            return "Click on any pane to fire an event";
        else
            return tabChangeDescriptor;
    }

    public void setTabChangeDescriptor(String tabChangeDescriptor) {
        this.tabChangeDescriptor = tabChangeDescriptor;
    }
}


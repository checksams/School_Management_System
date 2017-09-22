/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.selectmenu;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;

@ManagedBean(name= SelectMenuFacetBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class SelectMenuFacetBean implements Serializable {

    public static final String BEAN_NAME = "selectMenuFacetBean";
    public String getBeanName() { return BEAN_NAME; }
    
    private List<Color> textColors;
    private List<Color> backgroundColors;
    
    public SelectMenuFacetBean() {
        backgroundColors = new ArrayList<Color>();
        backgroundColors.add(new Color("Alice Blue", "#F0F8FF"));
        backgroundColors.add(new Color("Beige", "#F5F5DC"));
        backgroundColors.add(new Color("Cornsilk", "#FFF8DC"));
        backgroundColors.add(new Color("Gainsboro", "#DCDCDC"));
        backgroundColors.add(new Color("Khaki", "#F0E68C"));
        backgroundColors.add(new Color("Lavender", "#E6E6FA"));
        backgroundColors.add(new Color("Lavender Blush", "#FFF0F5"));
        backgroundColors.add(new Color("Lemon Chiffon", "#FFFACD"));
        backgroundColors.add(new Color("Misty Rose", "#FFE4E1"));
        backgroundColors.add(new Color("Mint Cream", "#F5FFFA"));
        backgroundColors.add(new Color("Pale Green", "#98FB98"));
        backgroundColors.add(new Color("Papaya Whip", "#FFEFD5"));
        backgroundColors.add(new Color("Sea Shell", "#FFF5EE"));
        backgroundColors.add(new Color("White Smoke", "#F5F5F5"));
        
        textColors = new ArrayList<Color>();
        textColors.add(new Color("Aquamarine", "#7FFFD4"));
        textColors.add(new Color("Burly Wood", "#DEB887"));
        textColors.add(new Color("Cadet Blue", "#5F9EA0"));
        textColors.add(new Color("Coral", "#FF7F50"));
        textColors.add(new Color("Crimson", "#DC143C"));
        textColors.add(new Color("Fire Brick", "#B22222"));
        textColors.add(new Color("Golden Rod", "#DAA520"));
        textColors.add(new Color("Green Yellow", "#ADFF2F"));
        textColors.add(new Color("Indigo", "#4B0082"));
        textColors.add(new Color("Medium Orchid", "#BA55D3"));
        textColors.add(new Color("Midnight Blue", "#191970"));
        textColors.add(new Color("Olive Drab", "#6B8E23"));
        textColors.add(new Color("Orange", "#FFA500"));
        textColors.add(new Color("Pale Violet Red", "#DB7093"));
        textColors.add(new Color("Sandy Brown", "#F4A460"));
        textColors.add(new Color("Slate Blue", "#6A5ACD"));
    }

    private String textColor = "";
    public String getTextColor() { return textColor; }
    public void setTextColor(String textColor) { this.textColor = textColor; }

    private String backgroundColor = "";
    public String getBackgroundColor() { return backgroundColor; }
    public void setBackgroundColor(String backgroundColor) { this.backgroundColor = backgroundColor; }
    
    public List<Color> getTextColors() { return textColors; }

    public List<Color> getBackgroundColors() { return backgroundColors; }
}
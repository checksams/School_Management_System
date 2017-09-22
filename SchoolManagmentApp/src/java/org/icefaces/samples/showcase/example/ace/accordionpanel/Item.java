package org.icefaces.samples.showcase.example.ace.accordionpanel;

import java.io.Serializable;
import org.icefaces.samples.showcase.dataGenerators.ImageSet;
import org.icefaces.samples.showcase.example.compat.dragdrop.DragDropItem;

public class Item extends DragDropItem implements Serializable
{
    public Item(ImageSet.ImageInfo image) 
    {
        super(image);
    }
}
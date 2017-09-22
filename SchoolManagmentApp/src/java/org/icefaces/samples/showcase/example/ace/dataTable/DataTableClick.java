/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.dataTable;

import java.io.Serializable;

import javax.faces.application.FacesMessage;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;

import org.icefaces.ace.component.celleditor.CellEditor;
import org.icefaces.ace.event.DataTableCellClickEvent;
import org.icefaces.ace.model.table.RowState;

@ManagedBean(name= DataTableClick.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class DataTableClick implements Serializable {
    public static final String BEAN_NAME = "dataTableClick";
    public String getBeanName() { return BEAN_NAME; }
    public String stateVar = "state";

    public void toggleSelect(AjaxBehaviorEvent event) {
         RowState state = (RowState) FacesContext.getCurrentInstance()
                                                 .getExternalContext()
                                                 .getRequestMap().get(stateVar);
        state.setSelected(!state.isSelected());
    }

    public void toggleEditor(AjaxBehaviorEvent e) {
         RowState state = (RowState) FacesContext.getCurrentInstance()
                                                 .getExternalContext()
                                                 .getRequestMap().get(stateVar);
                                                 
        DataTableCellClickEvent event = (DataTableCellClickEvent) e;
        CellEditor editor = event.getColumn().getCellEditor();

        if (editor != null) {
            if (state.getActiveCellEditorIds().contains(editor.getId())) {
                state.removeActiveCellEditor(editor);
            } else {
                state.addActiveCellEditor(editor);
            }
        } else {
            FacesContext.getCurrentInstance().addMessage(event.getColumn().getClientId(),
                new FacesMessage("This column doesn't contain an ace:cellEditor to toggle.")
            );
        }
    }

    public String getStateVar() {
        return stateVar;
    }

    public void setStateVar(String stateVar) {
        this.stateVar = stateVar;
    }
}


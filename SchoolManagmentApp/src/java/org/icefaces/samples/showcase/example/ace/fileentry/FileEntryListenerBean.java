/* MPL License text (see http://www.mozilla.org/MPL/) */


package org.icefaces.samples.showcase.example.ace.fileentry;

import java.io.File;
import java.io.Serializable;

import javax.faces.application.FacesMessage;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;

import org.icefaces.ace.component.fileentry.FileEntry;
import org.icefaces.ace.component.fileentry.FileEntryEvent;
import org.icefaces.ace.component.fileentry.FileEntryResults;
import org.icefaces.ace.component.fileentry.FileEntryStatus;

@ManagedBean(name= FileEntryListenerBean.BEAN_NAME)
@CustomScoped(value = "#{window}")
public class FileEntryListenerBean implements Serializable 
{
    public static final String BEAN_NAME = "fileEntryListener";
    public String getBeanName() { return BEAN_NAME; }

    public void customValidator(FileEntryEvent entryEvent) {
        FileEntryResults results = ((FileEntry)entryEvent.getComponent()).getResults();
        for (FileEntryResults.FileInfo file : results.getFiles()) {
            if (file.isSaved()) {
                if (!file.getContentType().equals("application/pdf")){
                    File fileObject = file.getFile();
                    if (fileObject != null) (new File(fileObject.getAbsolutePath())).delete();
                    file.updateStatus(new FileEntryStatus() {
                            public boolean isSuccess() {
                                return false;
                            }
                            public FacesMessage getFacesMessage(
                                    FacesContext facesContext, UIComponent fileEntry, FileEntryResults.FileInfo fi) {
                                return new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                    "Only PDF files can be uploaded. Your upload has been cancelled.",
                                    "Only PDF files can be uploaded. Your upload has been cancelled.");
                            }
                        },
                        true, true);
                }
            }
        }
    }
}

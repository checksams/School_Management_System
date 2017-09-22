/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package school.employee;
/**
 *
 * @author Samuel Nyong'a
 * @Date 30-March-2017
 */

import java.io.Serializable;
import javax.faces.bean.CustomScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;
import javax.sql.DataSource;
import javax.naming.InitialContext;
import javax.naming.Context;

import java.math.BigDecimal;
import java.sql.CallableStatement;

import java.util.ArrayList;
import java.util.List;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSetMetaData;
import java.util.Date;

import javax.servlet.http.HttpSession;
import org.icefaces.ace.event.SelectEvent;
import org.icefaces.ace.event.UnselectEvent;
import org.icefaces.ace.model.table.RowStateMap;

@ManagedBean(name= "employeeDAO")
@CustomScoped(value = "#{window}")
public class employeeDAO  implements Serializable  {
    public employeeDAO(){
        super(); 
    }
    private static final String BEAN_NAME = "employeeDAO";
    public String getBeanName() { return BEAN_NAME; }        
    private HttpSession session =
        (HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(false);
    
    
    //Ajax related methods for handling events on the .xhtml
    private static final int EVENT_SIZE = 5;
    private List<String> eventLog = new ArrayList<String>(EVENT_SIZE);
    private List selectedRows;
    private RowStateMap stateMap = new RowStateMap();
    private List<employee> employeeData;
    public int getEventSize() { return EVENT_SIZE; }
    
    
    public DataSource ds = null; 
    private ResultSet rs = null;
    private Connection conn=null;
    private PreparedStatement statement = null;
    
    public List<employee> findEmployees() throws SQLException{
        
        List<employee> employeeData = new ArrayList<employee>();
        try{
            /********************************************
             * Stopped coz the connection pool has some drawbacks
             * It is slow and does not close the connections
            InitialContext ctx = new InitialContext();
            System.out.println("xxxxxxxxxxxxx");
            //The JDBC Data source that we just created
            Context dbContext = (Context) ctx.lookup("java:app");
                       
            if (ds == null)
            {
                ds = (DataSource) dbContext.lookup("jdbc/sereneschool");
            }
            
            System.out.println("yyyyyyyyyyyyyyyyyyyy");
            //DataSource ds = (DataSource) ctx.lookup("jdbc/sereneschoolPool");
            Connection connection = ds.getConnection();
            if (connection == null)
            {
                throw new SQLException("Error establishing connection!");
            }
            String query = null;
            //query = "begin call sereneschool.getEmployees(?,?,?,?); end;";
            query = "SELECT emp_code, emp_sht_desc, hm_surname emp_surname, hm_other_names emp_other_names,\n" +
"    hm_tel_no1 emp_tel_no1, hm_tel_no2 emp_tel_no2, hm_sms_no emp_sms_no, \n" +
"	date_format(emp_contract_date,\'%d/%m/%Y\') emp_contract_date,\n" +
"    date_format(emp_final_date,\'%d/%m/%Y\')emp_final_date, emp_org_code, org_desc emp_organization, \n" +
"    hm_gender emp_gender,\n" +
"    date_format(emp_join_date,\'%d/%m/%Y\')emp_join_date,hm_work_email emp_work_email, \n" +
"    hm_personal_email emp_personal_email, hm_id_no emp_id_no,\n" +
"    hm_nssf_no emp_nssf_no, hm_pin_no emp_pin_no, hm_nhif_no emp_nhif_no, hm_lasc_no emp_lasc_no,\n" +
"    null emp_nxt_kin_sname,null emp_nxt_kin_onames, null emp_nxt_kin_tel_no,null emp_pr_code,\n" +
"	null emp_bnk_code,\n" +
"	null emp_bbr_code,\n" +
"	null emp_bank_acc_no, hm_code emp_hm_code, emp_co_code\n" +
"FROM sereneschool.sch_employees emp \n" +
"left join serenecrmsdb.cr_humans hm on hm.hm_code = emp.emp_hm_code\n" +
"left join serenecrmsdb.cr_organizations org on org.org_code = emp.emp_org_code";

            statement = connection.prepareStatement(query);
            //statement.setString(1, "%");
            //statement.setString(2, "%");
            //statement.setString(3, "%");
            //statement.setString(4, "%");
            rs = statement.executeQuery();
*****************************************/
            
            conn=DriverManager.getConnection(  
                        "jdbc:mysql://localhost:3306/sereneschool","root","root");

            /*******
             * Use this method when you want to call a stored procedure and return results
            */
            String query = "CALL get_employees(?,?,?,?)";
            CallableStatement stmt = conn.prepareCall(query);
            //stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.setString(1, "%");        
            stmt.setString(2, "%");        
            stmt.setString(3, "%");        
            stmt.setString(4, "%");  
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.executeQuery();
            /*******/

            ResultSetMetaData meta = rs.getMetaData();

            int cols = meta.getColumnCount();
            for (int i=1; i< cols; i++){
                System.out.println(meta.getColumnLabel(i));            
                System.out.println("\t\t");

            }

            System.out.println("bbbbbbbb");
            while (rs.next())
            {
                employee emp = new employee();
            System.out.println("ccccc");
              
                emp.setEmp_code(rs.getBigDecimal("emp_code"));
                emp.setEmp_sht_desc(rs.getString("emp_sht_desc"));
                emp.setEmp_surname(rs.getString("emp_surname"));
                emp.setEmp_other_names(rs.getString("emp_other_names"));
                emp.setEmp_tel_no1(rs.getString("emp_tel_no1"));
                emp.setEmp_tel_no2(rs.getString("emp_tel_no2"));
                emp.setEmp_sms_no(rs.getString("emp_sms_no"));
                emp.setEmp_contract_date(rs.getString("emp_contract_date"));
                emp.setEmp_final_date(rs.getString("emp_final_date"));
                emp.setEmp_join_date(rs.getString("emp_join_date"));
                emp.setEmp_org_code(rs.getBigDecimal("emp_org_code"));
                emp.setEmp_organization(rs.getString("emp_organization"));
                emp.setEmp_gender(rs.getString("emp_gender"));
                emp.setEmp_work_email(rs.getString("emp_work_email"));
                emp.setEmp_personal_email(rs.getString("emp_personal_email"));
                emp.setEmp_id_no(rs.getString("emp_id_no"));
                emp.setEmp_nssf_no(rs.getString("emp_nssf_no"));
                emp.setEmp_pin_no(rs.getString("emp_pin_no"));
                emp.setEmp_lasc_no(rs.getString("emp_lasc_no"));
                emp.setEmp_nxt_kin_sname(rs.getString("emp_nxt_kin_sname"));
                emp.setEmp_nxt_kin_onames(rs.getString("emp_nxt_kin_onames"));
                emp.setEmp_nxt_kin_tel_no(rs.getString("emp_nxt_kin_tel_no"));
                emp.setEmp_pr_code(rs.getBigDecimal("emp_pr_code"));
                System.out.println("emp_surname=" + rs.getString("emp_surname")+" "+
                        rs.getString("emp_other_names"));
                
                employeeData.add(emp);

            }
            return employeeData;

        }
        catch(Exception e){
            System.out.println("Error...");
            System.out.println(e.getMessage());
        }
        finally{
            try{
            rs.close();
            statement.close();
            conn.close();
            }
            catch(Exception e){
            System.out.println("Error...");
            System.out.println(e.getMessage());
            }
        
        }
        return employeeData;
    }

    /////////////---- EVENT LISTENERS BEGIN
    public void selectListener(SelectEvent event) {
        addEvent((employee)event.getObject(), "selected");
    }

    public void deselectListener(UnselectEvent event) {
        addEvent((employee)event.getObject(), "deselected");
    }
    
    /////////////---- PRIVATE METHODS BEGIN
    private void addEvent(employee employee, String action) {
        StringBuilder sb = new StringBuilder(40);
        sb.append("employee \"");
        sb.append(employee.getEmp_surname());
        sb.append("\" (id ");
        sb.append(employee.getEmp_code());
        sb.append(") was ");
        sb.append(action);
        sb.append(".");
        getEventLog().add(0, sb.toString());
        System.out.println("SUR NAME="+employee.getEmp_surname()+" "+employee.getEmp_other_names());
        
        // Cap the list at the displayed row size
        if (getEventLog().size() > getEVENT_SIZE()) {
            setEventLog(getEventLog().subList(0, getEVENT_SIZE()));
        }
    }
    /**
     * @return the session
     */
    public HttpSession getSession() {
        return session;
    }

    /**
     * @param session the session to set
     */
    public void setSession(HttpSession session) {
        this.session = session;
    }

    /**
     * @return the EVENT_SIZE
     */
    public static int getEVENT_SIZE() {
        return EVENT_SIZE;
    }

    /**
     * @return the eventLog
     */
    public List<String> getEventLog() {
        return eventLog;
    }

    /**
     * @param eventLog the eventLog to set
     */
    public void setEventLog(List<String> eventLog) {
        this.eventLog = eventLog;
    }

    /**
     * @return the selectedRows
     */
    public List getSelectedRows() {
        return selectedRows;
    }

    /**
     * @param selectedRows the selectedRows to set
     */
    public void setSelectedRows(List selectedRows) {
        this.selectedRows = selectedRows;
    }

    /**
     * @return the stateMap
     */
    public RowStateMap getStateMap() {
        return stateMap;
    }

    /**
     * @param stateMap the stateMap to set
     */
    public void setStateMap(RowStateMap stateMap) {
        this.stateMap = stateMap;
    }

    /**
     * @return the employeeData
     */
    public List<employee> getEmployeeData() {
        return employeeData;
    }

    /**
     * @param employeeData the employeeData to set
     */
    public void setEmployeeData(List<employee> employeeData) {
        this.employeeData = employeeData;
    }
    
    
}

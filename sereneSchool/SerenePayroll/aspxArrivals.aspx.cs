using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using MySql.Data.MySqlClient;

using System.Configuration;
using System.ComponentModel;

using System.Globalization;
using System.Text.RegularExpressions;

using System.IO;
using System.Text;

using System.Drawing;

namespace SerenePayroll
{
    public partial class aspxArrivals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int v_cnt;

            btnSave.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            pnlDisplayAllRecs.Visible = true;
            txtOriginSrch.Text = ddlOriginSrch.Text;
            if (txtOriginSrch.Text == "") { txtOriginSrch.Text = "%"; }
            txtDestSrch.Text = ddlDestSrch.Text;
            if (txtDestSrch.Text == "") { txtDestSrch.Text = "%"; }

            GridView1.Visible = true;
            GridView1.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = false;
            Editing.Visible = true;
            pnlEditingData.Visible = true;

            clearCtrls();

        }

        protected void clearCtrls()
        {
            txt_dst_code1.Text = "";
            txt_dst_code2.Text = "";
            txt_dst_sht_desc1.Text = "";
            txt_dst_sht_desc2.Text = "";
            txt_min_amt.Text = "";
            txt_max_amt.Text = "";

        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean PriceDtls_Update()
        {
            Boolean v_bool;
            String errMessage;
            int v_txt_dst_code1;
            int v_txt_dst_code2;
            String v_user;
            decimal v_amt;
            try
            {
                v_user = System.Web.HttpContext.Current.User.Identity.Name;
                if (String.IsNullOrEmpty(txt_dst_code1.Text))
                {
                    v_txt_dst_code1 = 0;
                }
                else
                {
                    v_txt_dst_code1 = Convert.ToInt32(txt_dst_code1.Text);
                }
                if (String.IsNullOrEmpty(txt_dst_code2.Text))
                {
                    v_txt_dst_code2 = 0;
                }
                else
                {
                    v_txt_dst_code2 = Convert.ToInt32(txt_dst_code2.Text);
                }
                if (String.IsNullOrEmpty(txt_min_amt.Text))
                {
                    v_amt = 0;
                }
                else
                {
                    v_amt = Convert.ToDecimal(txt_min_amt.Text);
                }

                MySqlCommand cmd = new MySqlCommand("serenefleet.update_prices", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_dst_code1", v_txt_dst_code1));
                cmd.Parameters.Add(new MySqlParameter("v_dst_code2", v_txt_dst_code2));
                cmd.Parameters.Add(new MySqlParameter("v_amt", v_amt));
                cmd.Parameters.Add(new MySqlParameter("v_updated_by", v_user));
                cmd.Parameters.Add(new MySqlParameter("v_category", "MATATU"));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                v_bool = true;
                //Editing.Visible = false;
                //pnlEditingData.Visible = false;
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully');", true);
            }
            catch (Exception ex)
            {
                v_bool = false;
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error saving record.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
            return v_bool;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try {
                if (PriceDtls_Update())
                {
                    //btnAdd.Enabled = true;
                    //btnSave.Enabled = false;
                    //btnSaveNAddNew.Enabled = false;
                    //btnDelete.Enabled = false;
                    //Editing.Visible = false;
                    //pnlEditingData.Visible = false;
                    GridView1.Visible = true;
                    GridView1.DataBind();
                    GridView2.Visible = true;
                    GridView2.DataBind();

                    //clearCtrls();
                }
                else
                {

                }
            }
            catch { 
            
            }
        }
        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            try {
                if (PriceDtls_Update())
                {
                    btnAdd.Enabled = false;
                    btnSave.Enabled = true;
                    btnSaveNAddNew.Enabled = true;
                    btnDelete.Enabled = false;
                    Editing.Visible = true;
                    pnlEditingData.Visible = true;
                    GridView1.Visible = true;
                    GridView1.DataBind();
                    
                    clearCtrls();
                }
                else
                {

                }
            }
            catch { 
            
            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = true;
            btnSave.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            GridView1.Visible = true;

            clearCtrls();

        }
        protected void btnPopup_Click(object sender, EventArgs e)
        {
            string title = "Information";
            string msg = "This is not an error man.";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('" + title + "','" + msg + "');", true);

        }


        protected void btnEditPnl_Click(object sender, EventArgs e)
        {
            if (pnlEditingData.Visible == true)
            {
                pnlEditingData.Visible = false;
            }
            else
            {
                pnlEditingData.Visible = true;
            }
        }


        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings
                ["serenehrdbConnectionString"].ConnectionString;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string name = GridView1.SelectedRow.Cells[2].Text;
            txt_dst_code1.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txt_dst_code2.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txt_dst_sht_desc1.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            txt_dst_sht_desc2.Text =  GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txt_min_amt.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            txt_max_amt.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");


            btnSave.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            pnlPriceLists.Visible = true;
            GridView2.Visible = true;
            GridView2.DataBind();

        }
        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnExportPricesToExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = Create_DtFromGv(GridView1);

            Response.ContentType = "Application/x-msexcel";
            Response.AddHeader("content-disposition", "attachment;filename=test.csv");
            Response.Write(ExportToCSVFile(dt));
            Response.End();
        }

        protected DataTable Create_DtFromGv(GridView gv)
        {
            DataTable dt = new DataTable();

            if (gv.HeaderRow != null)
            {

                for (int i = 0; i < gv.HeaderRow.Cells.Count; i++)
                {
                    dt.Columns.Add(gv.HeaderRow.Cells[i].Text);
                }
            }

            for (int j = 0; j < gv.Rows.Count; j++)
            {
                DataRow dr;
                GridViewRow row = gv.Rows[j];
                dr = dt.NewRow();

                for (int i = 0; i < row.Cells.Count; i++)
                {
                    //dr[i] = row.Cells[i].Text;
                    dr[i] = row.Cells[i].Text.Replace("&nbsp;", "");
                    System.Diagnostics.Debug.WriteLine("row.Cells[i].Text==>" + row.Cells[i].Text.ToString());
                }

                dt.Rows.Add(dr);
            }
            return dt;

        }

        public string ExportToCSVFile(DataTable dtTable)
        {
            StringBuilder sbldr = new StringBuilder();
            if (dtTable.Columns.Count != 0)
            {
                foreach (DataColumn col in dtTable.Columns)
                {
                    sbldr.Append(col.ColumnName + ',');
                }
                sbldr.Append("\r\n");
                foreach (DataRow row in dtTable.Rows)
                {
                    foreach (DataColumn column in dtTable.Columns)
                    {
                        sbldr.Append(row[column].ToString() + ',');
                    }
                    sbldr.Append("\r\n");
                }
            }
            return sbldr.ToString();
        }

        


    }
}
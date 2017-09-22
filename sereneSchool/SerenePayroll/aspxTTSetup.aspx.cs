using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace SerenePayroll
{
    public partial class aspxTTSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //create_calender();
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            {
                create_calender();
            }
        }
        protected void Page_PreInit(object sender, EventArgs e)
        {
            //create_calender();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {

        }
        protected void btnSave_Click(object sender, EventArgs e)
        {

        }
        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {

        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }
        protected void btnPopup_Click(object sender, EventArgs e)
        {

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

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            create_calender();
        }
        protected void create_calender()
        {

           // Total number of rows.
           int rowCnt;
           // Current row count.
           int rowCtr;
           // Total number of cells per row (columns).
           int cellCtr;
           // Current cell counter.
           int cellCnt;
           rowCnt = 6; //int.Parse(TextBox1.Text);
           cellCnt = 7; // int.Parse(TextBox2.Text);

            
           DateTime today = DateTime.Today;
           DateTime todayLastMonth = DateTime.Today.AddMonths(-1);
           System.Diagnostics.Debug.WriteLine("today=" + today.ToString("dd/MM/yyyy"));
           System.Diagnostics.Debug.WriteLine("1st Day of Monthg== 01" + today.ToString("dd/MM/yyyy").Substring(2));
           System.Diagnostics.Debug.WriteLine("ddd=" + today.ToString("ddd"));
           System.Diagnostics.Debug.WriteLine("Long Day=" + today.ToString("dddd"));
           string iString = "2005-05-05 22:12 PM";
           DateTime oDate = DateTime.ParseExact(iString, "yyyy-MM-dd HH:mm tt", null);
           DateTime endOfMonth = new DateTime(today.Year,
                                  today.Month,
                                  DateTime.DaysInMonth(today.Year,
                                                       today.Month));
           DateTime endOfLastMonth = new DateTime(todayLastMonth.Year,
                                  todayLastMonth.Month,
                                  DateTime.DaysInMonth(todayLastMonth.Year,
                                                       todayLastMonth.Month));
           DateTime firstDayOfMonth = new DateTime(today.Year, today.Month, 1);

           System.Diagnostics.Debug.WriteLine("firstDayOfMonth ====" + firstDayOfMonth.ToString("dd/MM/yyyy"));
           System.Diagnostics.Debug.WriteLine("endOfMonth ====" + endOfMonth.ToString("dd/MM/yyyy"));
           System.Diagnostics.Debug.WriteLine("endOfLastMonth ====" + endOfLastMonth.ToString("dd/MM/yyyy"));

           String strFirstDateofMonth = "01"+today.ToString("dd/MM/yyyy").Substring(2,8);
           DateTime dtFirstDateofMonth = DateTime.ParseExact(strFirstDateofMonth, "dd/MM/yyyy", null);
           String firstDay = dtFirstDateofMonth.ToString("dddd");

           for(rowCtr=1; rowCtr <= rowCnt; rowCtr++) {
              // Create a new row and add it to the table.
              //TableRow tRow = new TableRow();
              System.Web.UI.HtmlControls.HtmlTableRow tRow = new System.Web.UI.HtmlControls.HtmlTableRow();
              tRow.ID = "trTT" + rowCtr;
              tblTTMonthx.Rows.Add(tRow);
              for (cellCtr = 1; cellCtr <= cellCnt; cellCtr++) {
                  // Create a new cell and add it to the row.
                 //TableCell tCell = new TableCell();
                 System.Web.UI.HtmlControls.HtmlTableCell tCell = new System.Web.UI.HtmlControls.HtmlTableCell();
                 tRow.Cells.Add(tCell);               
                 // Mock up a product ID.
                 string prodID = rowCtr + "_" + cellCtr;

                 tCell.VAlign = "top";
                 tCell.Align = "left";
                 tCell.Height = "50px";
                 tCell.BorderColor = "#dddddd";
                 tCell.ID = "tdTT"+rowCtr + cellCtr;
                 
                 if (cellCtr == 1) { tCell.BgColor = "#c4eef2"; }
                 if (cellCtr == 7) { tCell.BgColor = "#a2e6e0"; }
                 // Add a literal text as control.
                 tCell.Controls.Add(new LiteralControl("Buy: "));
                 // Create a Hyperlink Web server control and add it to the cell.
                 System.Web.UI.WebControls.HyperLink h = new HyperLink();
                 h.Text = rowCtr + ":" + cellCtr;
                 h.NavigateUrl = "http://www.microsoft.com/net";
                 h.Style.Value = " width:100%; text-align:left; padding:0; ";
                 tCell.Controls.Add(h);
                 tCell.Controls.Add(new LiteralControl("<br/>"));
                 /*System.Web.UI.WebControls.Button l = new Button();
                 l.Attributes.Add("runat", "client");
                 l.Text = "Event " + rowCtr + ":" + cellCtr;
                 l.BackColor = System.Drawing.ColorTranslator.FromHtml("#eee7e9");
                 l.Attributes.Add("OnClick", "MyJavaFun('Event', 'Edit Event details...')");*/
                  //Or
                 //l.Click += new EventHandler(tdTT_Click);
                 HtmlButton l = new HtmlButton();
                 l.Attributes.Add("runat", "client");
                 l.Attributes.Add("onclick", "return  MyJavaFun('Event', 'Edit Event details...')");
                 l.Style.Add(HtmlTextWriterStyle.TextAlign, "left");
                 l.Controls.Add(new LiteralControl("Html Event"));
                 l.Style.Value = " width:100%; text-align:left; padding:0; ";
                 tCell.Controls.Add(l);
                 tCell.Controls.Add(new LiteralControl("<br/>"));
                 System.Web.UI.WebControls.Label l2 = new Label();
                 l2.Text = "Event " + rowCtr + ":" + cellCtr;
                 l2.BackColor = System.Drawing.ColorTranslator.FromHtml("#efd7e9");
                 //MyJavaFunction(title, msg)
                 tCell.Controls.Add(l2);
              }
           }

        }

        protected void btnEventPopup_Click(object sender, EventArgs e)
        {

            System.Web.UI.HtmlControls.HtmlGenericControl createDiv =
               new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
            createDiv.ID = "createDiv";
            createDiv.Style.Add(HtmlTextWriterStyle.BackgroundColor, "blue");
            createDiv.Style.Add(HtmlTextWriterStyle.Color, "Red");
            createDiv.Style.Add(HtmlTextWriterStyle.Height, "300px");
            createDiv.Style.Add(HtmlTextWriterStyle.Width, "600px");
            //createDiv.Style.Add(HtmlTextWriterStyle.Visibility, "hidden");
            //createDiv.Style.Add(HtmlTextWriterStyle.Display, "none");

            //createDiv.Style.Value = " overflow-x:auto; ";
            //createDiv.InnerHtml = " I'm a div, from code behind ";
            System.Web.UI.HtmlControls.HtmlTable eventPopupTable = new System.Web.UI.HtmlControls.HtmlTable();
            eventPopupTable.Style.Value = "background-color:white; height:inherit; width:inherit"; //<---Add some style
            eventPopupTable.Attributes.Add("class", "calTable"); //<---Apply a css class if wanted

            //Add Table Row
            System.Web.UI.HtmlControls.HtmlTableRow tpRow = new System.Web.UI.HtmlControls.HtmlTableRow();
            System.Web.UI.HtmlControls.HtmlTableCell tpCell = new System.Web.UI.HtmlControls.HtmlTableCell();

            System.Web.UI.WebControls.Label lp = new Label();
            lp.Text = "Event Trials";
            lp.Style.Value = "font-weight:bold ";
            lp.ToolTip = "The event popup.";
            lp.Style.Add(HtmlTextWriterStyle.Width, "100%");

            tpCell.Style.Value = "background-color:gray; height:10px; width:inherit; vertical-align:top "; //<---Add some style
            tpCell.Controls.Add(lp);
            tpRow.Controls.Add(tpCell);
            eventPopupTable.Controls.Add(tpRow);

            //Add Table Row
            System.Web.UI.HtmlControls.HtmlTableRow tpRow2 = new System.Web.UI.HtmlControls.HtmlTableRow();
            System.Web.UI.HtmlControls.HtmlTableCell tpCell2 = new System.Web.UI.HtmlControls.HtmlTableCell();

            //Add label
            System.Web.UI.WebControls.Label lp2 = new Label();
            lp2.Text = "Description";
            lp2.Style.Value = "font-weight:bold ";
            tpCell2.Controls.Add(lp2);

            //Add Text Area
            System.Web.UI.HtmlControls.HtmlTextArea tArea = new HtmlTextArea();
            tArea.Style.Value = "background-color:white; height:200px; width:560px; vertical-align:top; ";
            tpCell2.Controls.Add(tArea);

            tpCell2.Style.Value = "background-color:white; width:inherit; vertical-align:top "; 
            tpRow2.Controls.Add(tpCell2);
            eventPopupTable.Controls.Add(tpRow2);

            //Add Table Row
            System.Web.UI.HtmlControls.HtmlTableRow tpRow3 = new System.Web.UI.HtmlControls.HtmlTableRow();
            System.Web.UI.HtmlControls.HtmlTableCell tpCell3 = new System.Web.UI.HtmlControls.HtmlTableCell();
            //Add label
            System.Web.UI.WebControls.Label lp3 = new Label();
            lp3.Text = "Time period";
            lp3.Style.Value = "font-weight:bold ";
            tpCell3.Controls.Add(lp3);
            tpRow3.Controls.Add(tpCell3);
            eventPopupTable.Controls.Add(tpRow3);

            /*
            //Add Table Row
            System.Web.UI.HtmlControls.HtmlTableRow tpRow4 = new System.Web.UI.HtmlControls.HtmlTableRow();
            System.Web.UI.HtmlControls.HtmlTableCell tpCell4 = new System.Web.UI.HtmlControls.HtmlTableCell();
                //Controls Table
                System.Web.UI.HtmlControls.HtmlTable buttonsTable = new System.Web.UI.HtmlControls.HtmlTable();
                buttonsTable.Style.Value = "background-color:gray; height:inherit; width:inherit"; //<---Add some style
                buttonsTable.Attributes.Add("class", "calTable"); //<---Apply a css class if wanted
                //Add Table Row
                System.Web.UI.HtmlControls.HtmlTableRow btRow = new System.Web.UI.HtmlControls.HtmlTableRow();
                //Add Save button
                System.Web.UI.HtmlControls.HtmlTableCell btCell = new System.Web.UI.HtmlControls.HtmlTableCell();
                System.Web.UI.WebControls.Button btnSaveEvent = new Button();
                btnSaveEvent.Text = "Save";
                btCell.Controls.Add(btnSaveEvent);
                btRow.Controls.Add(btCell);
                //Add Cancel button
                System.Web.UI.HtmlControls.HtmlTableCell btCell2 = new System.Web.UI.HtmlControls.HtmlTableCell();
                System.Web.UI.WebControls.Button btnCancelEvent = new Button();
                btnCancelEvent.Text = "Cancel";
                btCell2.Controls.Add(btnCancelEvent);
                btRow.Controls.Add(btCell2);
                //Add Delete button
                System.Web.UI.HtmlControls.HtmlTableCell btCell3 = new System.Web.UI.HtmlControls.HtmlTableCell();
                System.Web.UI.WebControls.Button btnDeleteEvent = new Button();
                btnDeleteEvent.Text = "Delete";
                btCell3.Controls.Add(btnDeleteEvent);
                btRow.Controls.Add(btCell3);
                buttonsTable.Controls.Add(btRow);

            tpCell4.Controls.Add(buttonsTable);
            tpRow4.Controls.Add(tpCell4);
            eventPopupTable.Controls.Add(tpRow4);*/
            createDiv.Controls.Add(eventPopupTable);
            this.Controls.Add(createDiv);

        }

        protected void Popup_Click(object sender, EventArgs e)
        {
            pup.HeaderText = "Event";
            pup.ShowPopupWindow();
        }
        protected void HidePopup_Click(object sender, EventArgs e)
        {
            pup.HidePopupWindow();
        }
        protected void MycloseWindow(object sender, EventArgs e)
        {
            //pup.HidePopupWindow();
        }

        protected void tdTT_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("clickedButton =========================== YES..");
            Button clickedButton = sender as Button;
            //OR 
            //Button clickedButton = (Button)sender;
            System.Diagnostics.Debug.WriteLine("clickedButton ===========================" + clickedButton.ID.ToString());
            if (clickedButton == null) // just to be on the safe side
                return;

            if (clickedButton.ID == "tdTT11")
            {
                Popup_Click(sender, e);
            }
            else if (clickedButton.ID == "tdTT12")
            {
            }
        }




    }
}
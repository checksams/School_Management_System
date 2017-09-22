<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxArrivals.aspx.cs" Inherits="SerenePayroll.aspxArrivals" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="JavaScript" type="text/javascript" src="/Scripts/CustomeFunctions.js">  </script>

    <script type="text/javascript">
        function MyJavaFunction(title, msg) {
            //alert("This is another function bbbbbbbbbbbbb.");
            var orignalstring = document.getElementById("msgbox").innerHTML;
            var newstring = orignalstring.replace("[TITLE]", title);
            document.getElementById("msgbox").innerHTML = newstring;

            orignalstring = document.getElementById("msgbox").innerHTML;
            newstring = orignalstring.replace("[MESSAGE]", msg);
            document.getElementById("msgbox").innerHTML = newstring;

            document.getElementById('pagedimmer').style.visibility = 'visible';
            document.getElementById('pagedimmer').style.display = 'inline';
            document.getElementById('msgbox').style.visibility = 'visible';
            document.getElementById('msgbox').style.display = 'inline';
        }

        function DisplayReport(title, msg) {
            var orignalstring = document.getElementById("Div2").innerHTML;
            var newstring = orignalstring.replace("[TITLE]", "Employee Listing Report.");
            document.getElementById("Div2").innerHTML = newstring;

            orignalstring = document.getElementById("Div2").innerHTML;
            newstring = orignalstring.replace("[MESSAGE]", "");
            document.getElementById("Div2").innerHTML = newstring;

            document.getElementById('Div1').style.visibility = 'visible';
            document.getElementById('Div1').style.display = 'inline';
            document.getElementById('Div2').style.visibility = 'visible';
            document.getElementById('Div2').style.display = 'inline';
        }

        function MyKeyPress(domItem) {
            var orignalstring = document.getElementById(domItem).innerHTML;
            var newstring;
            for (var i = 0; i < orignalstring.length; i++) {
                var myChar = orignalstring.charAt(i)
            }
            newstring = "9";
            document.getElementById("msgbox").innerHTML = newstring;
        }
    </script>
    
    
    <style type="text/css">
        .TableCSS 
        { 
            border-style:none; 
            background-color:#3BA0D8; 
            width: 100%; 
        } 

        .TableHeader 
        { 
            background-color:#66CCFF; 
            color:#0066FF; 
            font-size:large; 
            font-family:Verdana; 
            }     

        .TableData 
        { 
            background-color:#82C13E;
            color:#fff; 
            font-family:Courier New; 
            font-size:medium;  
        } 
        .auto-style1 {
            height: 59px;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    

    <div class="page_dimmer" id="pagedimmer" style="display:none "> </div> 
    <div class="msg_box_container" id="msgbox" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:inherit;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;"> 
    <td colspan="2" style="font-weight:bolder">[TITLE]</td> 
    </tr> 
    <tr> 
    <td>[MESSAGE]</td> 
    </tr> 
    <tr> 
    <td colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="Button" value="OK" 
        onClick="document.getElementById('pagedimmer').style.visibility = 'hidden';
    document.getElementById('msgbox').style.visibility = 'hidden'"></td> 
    </tr> 
    </table> 
    </div> 


    
    <div id="Div1" style="display:none "> </div> 
    <div class="report_container" id="Div2" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:#99DDF0;"> 
    <td colspan="2" style="font-weight:bolder"  align="left">[TITLE]</td> 
    <td colspan="2" align="right">
        <input type="Button" value="X" 
        onClick="document.getElementById('Div1').style.visibility = 'hidden';
    document.getElementById('Div2').style.visibility = 'hidden'"></td> 
    </tr> 
    <tr style="background-color:white;"> 
        <td>[MESSAGE]<br>    
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
       
            <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Width="100%" bottom="0px"
                Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"
                 ZoomMode="Percent" ZoomPercent="10"
                >
                <LocalReport ReportPath="Report1.rdlc">
                     <DataSources>
                         <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                     </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>  
    
        </td> 
        <td>
        </td>
    </tr> 
    </table> 
    </div>    




    
    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:250px; height:inherit" style="overflow-x:auto; white-space: nowrap;">

                <div style="background-color:#99CCFF; height:inherit; width:auto" style="overflow-x:auto; white-space: nowrap;">
                     <table style="width:100%;">
                        <tr><td>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                onclick="btnSearch_Click" />
                            <asp:Button ID="btnExportPricesToExcel" runat="server" 
                                    Text="Export to Excel" onclick="btnExportPricesToExcel_Click" />
                        </td>
                        </tr>
                         <tr><td>
                            <table style="width:inherit;">
                                <tr><td>
                                    <asp:Label ID="lblOriginSrch" runat="server" Text="Source"></asp:Label>
                                </td><td>
                                        <asp:Label ID="lblDestinationSrch" runat="server" Text="Destination"></asp:Label>
                                </td></tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlOriginSrch" runat="server" Width="150px" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="dst_desc" DataValueField="dst_desc"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" SelectCommand="get_dest_listing" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        <asp:TextBox ID="txtOriginSrch" runat="server" Width="217px" Visible="false"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDestSrch" runat="server" Width="150px"  DataSourceID="SqlDataSource3" DataTextField="dst_desc" DataValueField="dst_desc">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" SelectCommand="get_dest_listing" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        <asp:TextBox ID="txtDestSrch" runat="server" Width="217px" Visible="false"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td></tr>

                        <tr><td>
                            
                            <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0"> 
                                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                    AllowSorting="True" AutoGenerateColumns="False" 
                                    DataSourceID="SqlDataSource1"
                                    onselectedindexchanged="GridView1_SelectedIndexChanged"
                                    onitemcommand="GridView1_ItemCommand" PageSize="30">

                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <EditRowStyle BackColor="#2461BF" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" />
                                        <asp:BoundField DataField="dst_code1" HeaderText="O" SortExpression="dst_code1"  ItemStyle-Width="5%" />
                                        <asp:BoundField DataField="dst_code2" HeaderText="D"   ItemStyle-Width="5%"
                                            SortExpression="dst_code2" />
                                        <asp:BoundField DataField="source" HeaderText="Origin" 
                                            SortExpression="source" />
                                        <asp:BoundField DataField="destination" HeaderText="Destination" SortExpression="destination" />
                                        <asp:BoundField DataField="lowest_price" HeaderText="Lowest price" SortExpression="lowest_price" />
                                        <asp:BoundField DataField="highest_price" HeaderText="Highest price" SortExpression="highest_price" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>  
                        </td></tr>
                    </table>
                </div>
            </td>
            <td>
                <div  style="height:inherit;">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" Visible="false"/>
                    <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                        Enabled="False" />
                    <asp:Button ID="btnSaveNAddNew" runat="server" Text="Save and Add New" Visible="false"
                        onclick="btnSaveNAddNew_Click" Enabled="False" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="false"
                        onclick="btnDelete_Click" Enabled="False" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                        onclick="btnCancel_Click" />
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />

                    
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_pricelist_from" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtOriginSrch" Name="v_desc1"
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtDestSrch" Name="v_desc2"
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>   
                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Price Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                        
                    </asp:Panel>
                        
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False"
                        BackColor="#99CCFF">                
                            <table style="width: 80%; ">
                                <tr>
                                    <td valign="top">
                                        <table style="width: 100%; ">
                                            <tr style="visibility:hidden">
                                                <td style="width:20%;">
                                                    <asp:Label ID="lbl_dst_code" runat="server" Text="ID : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dst_code1" runat="server" Width="217px" Enabled="True"> </asp:TextBox>
                                                    <asp:TextBox ID="txt_dst_code2" runat="server" Width="217px" Enabled="True"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_dst_sht_desc" runat="server" Text="Origin-Destination : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dst_sht_desc1" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                    <asp:TextBox ID="txt_dst_sht_desc2" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_min_amt" runat="server" Text="Price Amount : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_min_amt" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="visibility:hidden">
                                                <td>
                                                    <asp:Label ID="lbl_max_amt" runat="server" Text="Minimum Price : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_max_amt" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                    </table>
                                    <td valign="top">
                                        <asp:Image ID="imgDrvPhoto" runat="server" CssClass="img" Height="100px" Visible="false" Width="100px" />
                                    </td>
                                </tr>
                            </table>

                    </asp:Panel>
                    
                    <asp:Panel ID="pnlPriceLists" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0"> 
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" 
                            DataSourceID="SqlDataSource4"
                            onselectedindexchanged="GridView2_SelectedIndexChanged"
                            onitemcommand="GridView2_ItemCommand" PageSize="30">

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="desc1" HeaderText="Origin" SortExpression="desc1" />
                                <asp:BoundField DataField="desc1" HeaderText="Destination"
                                    SortExpression="desc1" />
                                <asp:BoundField DataField="fpr_amt" HeaderText="Price" 
                                    SortExpression="fpr_amt" />
                                <asp:BoundField DataField="fpr_wef" HeaderText="Effective Date" SortExpression="fpr_wef" />
                                <asp:BoundField DataField="fpr_wet" HeaderText="Effect To Date" SortExpression="fpr_wet" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" SelectCommand="get_existing_pricelists" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txt_dst_sht_desc1" Name="v_desc1" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="txt_dst_sht_desc2" Name="v_desc2" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>  
                </div>

            </td>
        </tr>
    </table>



</asp:Content>



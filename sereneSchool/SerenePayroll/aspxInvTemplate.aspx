<%@ Page Title="" Language="C#" MasterPageFile="~/SiteInventory.Master" AutoEventWireup="true" CodeBehind="aspxInvTemplate.aspx.cs" Inherits="SerenePayroll.aspxInvTemplate" %>

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
            <td style="background-color:#99CCFF; width:250px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit; width:250px">
                     <table style="width:100%;">
                        <tr><td>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                onclick="btnSearch_Click" />
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblDestinationSrch" runat="server" Text="Destination"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtDestinationSrch" runat="server" AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                    </table>
                </div>
            </td>
            <td>
                <div  style="height:inherit;">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                        Enabled="False" />
                    <asp:Button ID="btnSaveNAddNew" runat="server" Text="Save and Add New" 
                        onclick="btnSaveNAddNew_Click" Enabled="False" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                        onclick="btnDelete_Click" Enabled="False" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                        onclick="btnCancel_Click" />
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />

                    
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_destinations" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtDestinationSrch" Name="v_desc"  DefaultValue="%" 
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>   
                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Employee Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                        
                    </asp:Panel>
                        
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False"
                        BackColor="#99CCFF">                
                            <table style="width: 80%; ">
                                <tr>
                                    <td valign="top">
                                        <table style="width: 100%; ">
                                            <tr style="visibility:collapse">
                                                <td style="width:20%;">
                                                    <asp:Label ID="lbl_dst_code" runat="server" Text="ID : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dst_code" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_dst_sht_desc" runat="server" Text="Destinations's Code : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dst_sht_desc" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_dst_desc" runat="server" Text="Destination : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dst_desc" runat="server" Width="400px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                    </table>
                                    <td valign="top">
                                    </td>
                                </tr>
                            </table>

                    </asp:Panel>

                </div>

            </td>
        </tr>
    </table>



</asp:Content>



<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="SerenePayroll._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    
    <style type="text/css">
    div {
          text-align: left;
        }
        table {
          display: inline-table;
        }
    </style>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div>
    
        <table style="width:50%; " cellpadding="0" cellspacing="0" >
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnSchool" runat="server" Text="School Management System" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnSchool_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top;" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnLiblary" runat="server" Text="School Library" OnClick="btnLiblary_Click" Width="100%" Height="40px"  Font-Bold="true"
                        Font-Size="Large"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnInventory" runat="server" Text="School Inventory" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnInventory_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnTransport" runat="server" Text="Transport Management" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnTransport_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnHR" runat="server" Text="Human Resource Management" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnHR_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnFinancial" runat="server" Text="Financial Accounting" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnFinancial_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnAssets" runat="server" Text="Assets Management" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnAssets_Click"/>
                </td>
            </tr>
            <tr style="vertical-align:top" align="center" >
                <td style="background-color:#99CCFF" style="overflow-x:auto; white-space: nowrap;">
                
                    <asp:Button ID="btnSysAdmin" runat="server" Text="System Administration" Width="100%" Height="40px" Font-Bold="true" 
                        Font-Size="Large" OnClick="btnSysAdmin_Click"/>
                </td>
            </tr>
        </table>

    </div>

</asp:Content>

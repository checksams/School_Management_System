﻿<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="aspxMap1.aspx.cs" Inherits="SerenePayroll.aspxMap1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
    <script type="text/javascript" src="http://www.google.com/jsapi?key=AIzaSyAhs9udMaWndFyAPntbUmJi_8OxUFTJ0PU"></script>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >


<br />
    <table>
        <tr>
            <td>
                <div id="map" style="width: 511px; height: 400px; border: 1px solid #ccc"></div>   
                <script type="text/javascript">
                    google.load("maps", "2.x");

                    // Call this function when the page has been loaded
                    function initialize() {
                        var map = new google.maps.Map2(document.getElementById("map"));
                        //map.addControl(new GSmallMapControl());
                        //map.setCenter(new google.maps.LatLng(50.86961044984257, 4.419143199920654), 15);
                        map.setCenter(new google.maps.LatLng(-1.29210000000000, 36.82190000000000),7);

                        //var info = '<div style="background-color: #fff; width: px; font-size: 11px; FONT-FAMILY: Verdana, Tahoma, Arial, Sans-Serif;"><B>Recytyre</B> VZW<BR>Avenue Jules Bordet 164<BR>1140 Evere<BR>Belgium<br></div>';
                        var info = '<div style="background-color: #fff; width: px; font-size: 11px; FONT-FAMILY: Verdana, Tahoma, Arial, Sans-Serif;"><B>Recytyre</B> VZW<BR>Moi Avenue<BR>1140 Nairobi<BR>Kenya<br></div>';

                        //var point = new GLatLng(50.86961044984257, 4.419143199920654);
                        var point = new GLatLng(-1.29210000000000, 36.82190000000000);
                        var marker = new GMarker(point);
                        GEvent.addListener(marker, "click", function () {
                            marker.openInfoWindowHtml(info);
                        });
                        map.addOverlay(marker);
                        marker.openInfoWindowHtml(info);
                    }
                    google.setOnLoadCallback(initialize);

                    ////////////////////////////////////////////////////////////////
                    
                    function initMap() {
                        // Create a map object and specify the DOM element for display.
                        var map = new google.maps.Map(document.getElementById('map'), {
                            center: {lat: -34.397, lng: 150.644},
                            scrollwheel: false,
                            zoom: 8
                        });
                    }

                    //google.setOnLoadCallback(initMap);
                    //////////////////////////////////////////////////////////////////

                </script>
    

            </td>
            <td>

                <asp:Panel ID="pnlLocation" runat="server" 
                        BackColor="#99CCF0">
                    
                        <asp:Button ID="btnLocation" runat="server" OnClientClick="initialize();"
                            Text="Get Current Location" Height="20px" 
                            Width="261px" BackColor="#7AC1C7" />
                            <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLong" runat="server" Width="217px" Text="Longitude : "> </asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLong" runat="server" Width="217px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLat" runat="server" Width="217px" Text="Latitude : "> </asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLat" runat="server" Width="217px"></asp:TextBox>
                                        </td>
                                    </tr>
                            </table>
                </asp:Panel>

            </td>
        </tr>
    </table>
</asp:Content>
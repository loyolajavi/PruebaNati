﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/LayoutAdministracion.Master" AutoEventWireup="true" CodeBehind="FacturasCliente.aspx.cs" Inherits="TFI.GUI.Areas.Intranet.Forms.FacturasCliente" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/Shared/LayoutAdministracion.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiContenido" runat="server">
    <div class="container paddingPaginas">

        <div class="row">
            <div class="col-md-12">
                <h1 class="page-header">
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Global, FacturasCliente %>"></asp:Label>
                </h1>
            </div>
        </div>
        
<%--        Panel de busqueda de las facturas del Cliente--%>
        <div class="row">
<%--            <div class="list-group col-md-4">
                <div class="form-group">--%>

                    <label for="txtClienteBusqueda" class="control-label">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Global, Cliente %>"></asp:Label></label>
                    <div class="form-inline">
                    <asp:TextBox ID="txtClienteBusqueda" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                    <asp:Button ID="btnBuscarCliente" runat="server" Text="<%$Resources:Global, Buscar %>" CssClass="form-control btn-success" OnClick="btnBuscarCliente_Click"></asp:Button>

                    </div>

<%--                </div>--%>

        </div>

         <hr />
<%--        Tabla de las facturas--%>
        <div class="row">

     <%--       <div class="col-md-8">--%>
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                    <ContentTemplate>
                        <asp:GridView ID="grilladefacturas" AllowPaging="true" OnPageIndexChanging="grilladefacturas_PageIndexChanging" PageSize="10" AutoGenerateColumns="false" BorderStyle="NotSet" CssClass="table table-hover table-responsive table-striped" DataKeyNames="NroComprobante" runat="server" OnRowCommand="grilladefacturas_RowCommand" GridLines="None">
                            <Columns>
                                <asp:ButtonField CommandName="VerDetalle" HeaderText="<%$Resources:Global, VerDetalle %>" Text="<%$Resources:Global, VerDetalle %>" ButtonType="Button" HeaderStyle-CssClass="bg-primary" ControlStyle-CssClass="btn btn-info" />
                                <asp:BoundField DataField="NroComprobante" HeaderText="<%$Resources:Global, NumeroFactura %>" HeaderStyle-CssClass="bg-primary" />
                                <asp:BoundField DataField="FechaComprobante" HeaderText="<%$Resources:Global, FechaFactura %>" HeaderStyle-CssClass="bg-primary" />
                                <asp:BoundField DataField="TipoComprobante" HeaderText="<%$Resources:Global, Tipo %>" HeaderStyle-CssClass="bg-primary" />
                                <asp:BoundField DataField="Total" HeaderText="Total" HeaderStyle-CssClass="bg-primary" />
                                <asp:TemplateField HeaderText="<%$Resources:Global, GenerarND %>" HeaderStyle-CssClass="bg-primary">
                                    <ItemTemplate>
                                        <%if (this.Master.Autenticar(new string[] { "NDebitoAlta" }))
                                          {%>
                                        <asp:LinkButton runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CommandName="GenerarNDeb" Text="<%$Resources:Global, GenerarND %>" ButtonType="Button" HeaderStyle-CssClass="bg-primary" ControlStyle-CssClass="btn btn-info" />
                                        <%} %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:ButtonField CommandName="GenerarNDeb" HeaderText="<%$Resources:Global, GenerarND %>" Text="<%$Resources:Global, GenerarND %>" ButtonType="Button" ControlStyle-CssClass="btn btn-primary" />--%>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>

                </asp:UpdatePanel>
      
        </div>

<%--        Error sin facturas--%>
                <div class="row" runat="server" clientidmode="Static" id="contenedorsinfacturas">
            <div class="col-md-9">
                <div class="alert alert-info alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <i class="fa fa-info-circle"></i>
                    <div id="sinfacturas" clientidmode="Static" runat="server"></div>
                </div>
            </div>
        </div>



    </div>










<%--    </div>--%>

    <div id="currentdetail" class="modal fade">
        <div class="modal-dialog" style="width: 55%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">
                        ×</button>
                    <h3 id="myModalLabel">
                        <asp:Label ID="Label3" runat="server" Text="<%$Resources:Global, DetalleFactura %>"></asp:Label></h3>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:DetailsView ID="DetailsView1" runat="server"
                                CssClass="table table-bordered table-hover"
                                BackColor="White" ForeColor="Black"
                                FieldHeaderStyle-Wrap="false"
                                FieldHeaderStyle-Font-Bold="true"
                                FieldHeaderStyle-BackColor="LavenderBlush"
                                FieldHeaderStyle-ForeColor="Black"
                                BorderStyle="Groove" AutoGenerateRows="False">
                                <Fields>
                                    <asp:BoundField DataField="NroComprobante" HeaderText="<%$Resources:Global, NumeroFactura %>" />
                                </Fields>
                            </asp:DetailsView>
                            <asp:GridView ID="grilladedetallesdefactura" runat="server" CssClass="table"></asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="grilladefacturas" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <button class="btn btn-info" data-dismiss="modal"
                            aria-hidden="true">
                            <asp:Label ID="Label4" runat="server" Text="<%$Resources:Global, Cerrar %>"></asp:Label></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="mdl_MontoNotaDebito" data-backdrop="static" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.GenerarND%></h3>
                </div>
                <div class="modal-body text-center">
                    <input type="text" readonly="readonly" class="form-control" clientidmode="static" id="NroFactAsocND" runat="server" maxlength="50" />
                    <nav><b><asp:Label CssClass="" runat="server" Text="<%$Resources:Global, Ajuste%>" ></asp:Label></b></nav><input type="text" pattern="[0-9]{1,8}" title="Solo números hasta 8 dígitos"  class="form-control" clientidmode="static" id="MontoNotaDebito" runat="server" />
                </div>
                <div class="modal-footer">
                    <div class="text-center">
                        <a class="btn btn-success" style="width: 200px; background-color: black; color: #fff;" href="#" id="btnGenerarNotaDeb"><%=Resources.Global.Continuar%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptSection" runat="server">

    <script src="../../../Scripts/shared/Validaciones.js"></script>

    <script>
        var obtenerTags = function () {
            var result;
            $.ajax({
                type: "POST",
                url: "OrdenesPedido.aspx/ObtenerClientes",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                error: function (xhr, status, error) {
                    alert(error);
                },
                success: function (data) {
                    result = data.d;
                }
            });

            return result;
        }

        var availableTags = obtenerTags();

        //$("#txtClienteBusqueda").change(function () {
        //    $(this).autocomplete({
        //        source: availableTags
        //    });
        //});

        $("#txtClienteBusqueda").autocomplete({
            source: availableTags
        });
    </script>
</asp:Content>

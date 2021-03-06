﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/LayoutAdministracion.Master" AutoEventWireup="true" CodeBehind="GestionStock.aspx.cs" Inherits="TFI.GUI.Areas.Intranet.Forms.GestionStock" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/Shared/LayoutAdministracion.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiContenido" runat="server">


    <div class="container paddingPaginas">

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <h1 class="page-header">
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Global, GestionStock %>"></asp:Label>
                    <small>
                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Global, Productos %>"></asp:Label></small>
                </h1>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <label class="control-label">Sucursal</label>
                <asp:DropDownList ID="cboSucursal" runat="server" CssClass="form-control"></asp:DropDownList>
                <div class="form-inline">
                    <asp:TextBox ID="txtProductoaBuscar" ClientIDMode="Static" CssClass="form-control" placeholder="Ingreso producto" runat="server" Width="40%"></asp:TextBox>
                    <asp:Button ID="btnConsultar" CssClass="form-control" runat="server" Text="<%$Resources:Global, Buscar %>" OnClick="btnConsultar_Click" />
                    <%if (this.Master.Autenticar(new string[] { "StockAjustar" }))
                      {%>
                    <span style="margin-left: 30%;">
                        <a href="#modalStock" class="btn btn-info" data-toggle="modal">
                            <asp:Label ID="Label3" runat="server" Text="Ajustar Stock"></asp:Label></a>
                    </span>
                    <%} %>
                </div>
            </div>






        <div class="row">
              <div class="col-md-8 col-md-offset-2">         
                     <div class="form-group">
                            <label for="grillastock"></label>
                            <asp:GridView ID="grillastock"   BorderStyle="NotSet" CssClass="table table-hover table-responsive table-striped" runat="server" GridLines="None"  >
                                <Columns>
                                    <asp:BoundField DataField="IdProducto" HeaderText="<%$Resources:Global, IdProducto %>" HeaderStyle-CssClass="bg-primary" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="<%$Resources:Global, DescripcionProducto %>" HeaderStyle-CssClass="bg-primary" />
                                    <asp:BoundField DataField="CantidadEnStock" HeaderText="Stock" HeaderStyle-CssClass="bg-primary" />
                                </Columns>
<%--                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <PagerSettings Mode="NextPreviousFirstLast" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />--%>
                            </asp:GridView>
                        </div>
              </div>
        </div>

                <div class="modal fade" id="modalStock">
                    <div class="modal-dialog">
                        <%--<asp:UpdatePanel ID="upModal" ChildrenAsTriggers="false" UpdateMode="Conditional" runat="server">--%>
                        <%--<ContentTemplate>--%>
                        <div class="modal-content">
                            <div class="modal-header text-center">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h2>
                                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Global, AjustarStock %>"></asp:Label></h2>
                                <div id="notificationStock" runat="server">
                                </div>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="upmodalStock">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnGrabarStock" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <asp:HiddenField ID="hIdProd" ClientIDMode="Static" runat="server" />
                                        <asp:HiddenField ID="hIdSuc" ClientIDMode="Static" runat="server" />
                                        <form role="form" class="col-xs-12">
                                            <div class="form-group">
                                                <label for="NroAdq">
                                                    <asp:Label ID="Label7" runat="server" class="control-label col-xs-2" Text="<%$Resources:Global, Adquisicion %>"></asp:Label></label>
                                                <input type="number" id="NroAdq" class="form-control" placeholder="Ingrese el Nro de Adquisición" runat="server" clientidmode="static" />
                                            </div>
                                            <div class="form-group">
                                                <label for="ajuste">
                                                    <asp:Label ID="Label6" runat="server" class="control-label col-xs-2" Text="<%$Resources:Global, Cantidad %>"></asp:Label></label>
                                                <input type="number" id="ajuste" class="form-control" placeholder="Ingrese el ajuste de stock" runat="server" clientidmode="static" />
                                            </div>
                                        </form>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <%--Agrego boton, con update panel, le agrege ClientIDMode a los elementos del modal.--%>
                                <div style="text-align: center;">
                                    <asp:Button runat="server" ID="btnGrabarStock" ClientIDMode="static" CssClass="btn btn-primary" Text="<%$Resources:Global, Aceptar %>" OnClientClick="return onbtnGrabarStock(this)" OnClick="btnGrabarStock_Click" />
                                </div>
                            </div>
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
                url: "GestionStock.aspx/ObtenerProductos",
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

        $("#txtProductoaBuscar").autocomplete({
            source: availableTags

        });
    </script>
</asp:Content>

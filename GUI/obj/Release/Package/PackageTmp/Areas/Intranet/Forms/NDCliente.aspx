﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/LayoutAdministracion.Master" AutoEventWireup="true" CodeBehind="NDCliente.aspx.cs" Inherits="TFI.GUI.Areas.Intranet.Forms.NDCliente" %>
<%@ MasterType VirtualPath="~/Shared/LayoutAdministracion.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiContenido" runat="server">
      <div class="container paddingPaginas">

            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Global, NDClientes %>"></asp:Label>
                    </h1>
                </div>
            </div>



            <div class="row">
                <div class="list-group col-md-4">
                    <div class="form-group">
                        <label for="txtClienteBusqueda" class="control-label">
                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Global, Cliente %>"></asp:Label></label>
                        <div class="form-inline">

                               <asp:TextBox ID="txtClienteBusqueda" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                               <asp:Button ID="btnBuscarCliente" runat="server" Text="<%$Resources:Global, Buscar %>" CssClass="form-control col-md-" OnClick="btnBuscarCliente_Click" />
                        </div>
                    </div>

                </div>




                <div class="row">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                        <ContentTemplate>
                            <asp:GridView ID="grilladend" CssClass="table table-hover table-responsive table-striped" DataKeyNames="NroComprobante" runat="server" OnRowCommand="grilladend_RowCommand" AllowPaging="true" OnPageIndexChanging="grilladend_PageIndexChanging" PageSize="10" AutoGenerateColumns="false" GridLines="None">
                                <Columns>
                                    <asp:ButtonField CommandName="VerDetalle" HeaderText="<%$Resources:Global, VerDetalle %>" Text="<%$Resources:Global, VerDetalle %>" ButtonType="Button" HeaderStyle-CssClass="bg-primary" ControlStyle-CssClass="btn btn-primary" />
                                    <asp:BoundField DataField="NroComprobante" HeaderText="<%$Resources:Global, NDNumero %>" HeaderStyle-CssClass="bg-primary" />
                                    <asp:BoundField DataField="FechaComprobante" HeaderText="<%$Resources:Global, NDFecha %>" HeaderStyle-CssClass="bg-primary" />
                                    <asp:BoundField DataField="TipoComprobante" HeaderText="<%$Resources:Global, Tipo %>" HeaderStyle-CssClass="bg-primary" />
                                    <asp:BoundField DataField="Total" HeaderText="Total" HeaderStyle-CssClass="bg-primary" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>

                    </asp:UpdatePanel>
                </div>



            
            </div>



            <div class="row" runat="server" id="contenedorsinnd">
                    <div class="col-md-9">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>
                            <div id="sinnd" runat="server"></div>
                        </div>
                    </div>
                </div>


       </div>

      <div id="currentdetail" class="modal fade">
                <div class="modal-dialog" style="width:55%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                aria-hidden="true">
                                ×</button>
                            <h3 id="myModalLabel">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Global, NDDetalle %>"></asp:Label></h3>
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
                                            <asp:BoundField DataField="NroComprobante" HeaderText="<%$Resources:Global, NDNumero %>" />
                                        </Fields>
                                    </asp:DetailsView>
                                    <asp:GridView ID="grilladedetallesdend" runat="server" CssClass="table"></asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="grilladend" EventName="RowCommand" />
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

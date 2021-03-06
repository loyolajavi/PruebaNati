﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/LayoutBasico.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Catalogo.aspx.cs" Inherits="TFI.GUI.Catalogo" %>

<%@ MasterType VirtualPath="~/Shared/LayoutBasico.Master" %>

<asp:Content ID="ContenidoCuerpo" ClientIDMode="Static" ContentPlaceHolderID="ContentPlaceHolderCuerpo" runat="server">

    <div class="container">

        <div class="col-md-3">
            <p class="lead">
                <asp:Label ID="lblCategorias" runat="server" Text="<%$Resources:Global, Categorias %>"></asp:Label>
            </p>
            <div class="list-group">
                <asp:Repeater ID="rptCategorias" runat="server">
                    <ItemTemplate>
                        <h4><a runat="server" class="responsive" href='<%#Eval("IdCategoria", "Catalogo.aspx?Categoria={0}")%>'><%#Eval("DescripCategoria") %></a></h4>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="list-group">
                <p class="lead">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Global, OrdenarPor %>"></asp:Label>

                    <div class="col-xs-9">
                        <asp:DropDownList CssClass="form-control" ID="dropdownfiltro" AutoPostBack="true" runat="server" OnSelectedIndexChanged="dropdownfiltro_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </p>
            </div>
        </div>

        <div class="col-md-3" style="">
        </div>

        <div class="col-md-9">

            <div id="notif" class="notification text-center" runat="server" hidden="hidden"></div>

            <div id="catalogoContainer" class="row">
                <%-- ITEMS --%>
                <asp:Repeater ID="catalogo" ClientIDMode="Static" runat="server">
                    <ItemTemplate>
                        <div class="col-sm-4 col-lg-4 col-md-4">
                            <div class="thumbnail" style="text-align: center;">
                                <a runat="server" class="responsive linkProducto" href='<%#Eval("IdProducto","Producto.aspx?IdProducto={0}")%>'>
                                    <img src='/Content/Images/Productos/<%#Eval("URL")%>' class="img-responsive col-md-12 linkProducto" alt="IMAGE" /></a>
                                <div class="caption">
                                    <h4><a runat="server" class="responsive linkProducto" href='<%#Eval("IdProducto","Producto.aspx?IdProducto={0}")%>'><%#Eval("DescripProducto")%></a></h4>
                                    <h5 class="precio"><span><%=moneda.SimboloMoneda%></span><span><%#Eval("PrecioUnitario")%></span></h5>
                                </div>
                                <div class="item-toolbar">
                                    <%--<input type="button" value="Comprar" clientidmode="static" class="btn btn-success btn-comprar" runat="server" data-producto='<%#Eval("IdProducto")%>' />--%>
                                    <input type="button" value="<%$Resources:Global, Comprar %>" clientidmode="static" class="btn btn-success btn-comprar" runat="server" data-producto='<%#Eval("IdProducto")%>' />
                                    <%--<input type="button" value="Mas" data-producto='<%#Eval("IdProducto")%>' clientidmode="static" class="btn btn-info" runat="server" onclick="btnInfoClick" />--%>
                                    <%if (this.Master.Autenticar("Desear"))
                                        {%>
                                    <%--<asp:Button CssClass="btn btn-info" ID="btnDesear" runat="server" data-producto='<%#Eval("IdProducto")%>' Text="Desear" OnClientClick="return onBtnAddClick(this)" OnClick="btnDesear_Click" />--%>
                                    <%--<input type="button" class="btn btn-info" clientidmode="static" runat="server" data-producto='<%#Eval("IdProducto")%>' value="Desear" onclick="onBtnAddClick(this)" />--%>
                                    <input type="button" class="btn btn-info" clientidmode="static" runat="server" data-producto='<%#Eval("IdProducto")%>' value="<%$Resources:Global, Desear %>" onclick="onBtnAddClick(this)" />
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog">
        <form id="mdl_pedido_agregado">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <%--<h3 class="modal-title" style="color: #29ab29;">Felicitaciones!</h3>--%>
                        <h3 class="modal-title" style="color: #29ab29;">
                            <asp:Label ID="Label4" runat="server" Text="<%$Resources:Global, Felicitaciones %>"></asp:Label></h3>
                    </div>
                    <div class="modal-body text-center">
                        <%--<h4 id="mdl_pedido_titulo" style="color: black;">El producto <span id="prod"></span>fue correctamente agregado en tu carrito!</h4>--%>
                        <h4 id="mdl_pedido_titulo" style="color: black;">
                            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Global, ElProducto %>"></asp:Label>
                            <span id="prod"></span>
                            <asp:Label ID="Label2" runat="server" Text="<%$Resources:Global, ProductoCorrectamenteAgregadoAlCarrito %>"></asp:Label></h4>
                    </div>
                    <div class="modal-footer">
                        <div class="text-center">
                            <%--<button type="button" id="btn-pedidos" class="btn btn-warning" style="width: 200px;">Ir a Pedidos</button>--%>
                            <button type="button" id="btn-pedidos" class="btn btn-warning" style="width: 200px;">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Global, IrAPedidos %>"></asp:Label></button>
                            <%--<button type="button" class="btn" style="width: 200px; background-color: black; color: #fff;" data-dismiss="modal">Seguir Comprado</button>--%>
                            <asp:Button ID="Button1" runat="server" Text="<%$Resources:Global, SeguirComprando %>" class="btn" Style="width: 200px; background-color: black; color: #fff;" data-dismiss="modal" />

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ClientIDMode="Static" ContentPlaceHolderID="ScriptSection" runat="server">
</asp:Content>

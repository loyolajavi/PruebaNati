﻿<%@ Page Title="Pago" Language="C#" MasterPageFile="~/Shared/LayoutBasico.Master" AutoEventWireup="true" CodeBehind="PedidosConfirmacion.aspx.cs" Inherits="TFI.GUI.Areas.Public.Forms.PedidosConfirmacion" %>

<%--<%@ Page Title="Pago" Language="C#" MasterPageFile="~/Shared/LayoutBasico.Master" AutoEventWireup="true" CodeBehind="PedidosConfirmacion.aspx.cs" Inherits="TFI.GUI.PedidosConfirmacion" %>--%>
<%@ MasterType VirtualPath="~/Shared/LayoutBasico.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/propios/Pedido.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ClientIDMode="Static" ContentPlaceHolderID="ContentPlaceHolderCuerpo" runat="server">

    <input type="text" id="pedidoId" value="<%=pedido%>" hidden="hidden" />

    <div>
        <h1>
            <asp:Label ID="Label2" runat="server" Text="<%$Resources:Global, ResumenDePedido%>"></asp:Label></h1>
        <hr />
    </div>

    <div class="col-md-12 col-sm-6">
        <div class="box" id="resumenBox" style="padding-bottom: 70px;">
            <h4 class="box-title"><%=Resources.Global.SeleccionaFormadePago%></h4>
            <hr class="barras" />
            <div>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th colspan="3">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Global, Resumen%>"></asp:Label></th>
                        </tr>
                        <tr>
                            <td><%=Resources.Global.Descripcion%></td>
                            <td class="td-centrado"><%=Resources.Global.Cantidad%></td>
                            <td class="td-centrado"><%=Resources.Global.Total%></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%if (lista.Any())
                            {
                                foreach (var item in lista)
                                {%>
                        <tr>
                            <td><%=item.Producto.DescripProducto%></td>
                            <td class="td-centrado"><%=item.Cantidad%></td>
                            <td class="td-centrado"><%=item.Cantidad * item.Producto.PrecioUnitario%></td>
                        </tr>
                        <%}
                            }%>
                    </tbody>
                    <tfoot>
                        <% if (FormaEntrega != null)
                            {
                        %>
                        <tr>
                            <td colspan="2"><%=Resources.Global.FormaDeEnvio%> <strong><%=((TFI.Entidades.FormaEntregaEntidad.Options)FormaEntrega).ToString() %></strong></td>
                            <td class="td-centrado"><%if (FormaEntrega == 1)
                                                        {%> 100.00 <% }
                                                                       else
                                                                       { %> Gratis! <%} %></td>
                        </tr>
                        <% } %>
                        <tr>
                            <td colspan="2">
                                <h4><%=Resources.Global.Total%></h4>
                            </td>
                            <td class="td-centrado"><%=Math.Round(totalizado,2) %></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <div class="pasos" style="margin-bottom: 20px;">
                <button class="btn btn-lg btn-warning pull-right btn-caja"
                    type="button"
                    runat="server"
                    id="btnConfirmar"
                    style="margin-bottom: 30px;">
                    <%=Resources.Global.ConfirmarPedido%>
                </button>
            </div>
        </div>
        <div id="pagos" class="box text-center" hidden="hidden" style="padding-bottom: 180px;">
            <div class="col-md-8">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th colspan="2" class="text-center">
                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Global, MediosDePago %>"></asp:Label>
                            </th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Global, Transferencia %>"></asp:Label></td>
                        <td>
                            <button type="button" class="btn btn-success" id="btTrasnferencia" value="">
                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Global, EnviarDatos %>"></asp:Label></button>
                        </td>
                    </tr>
                    <%--  <tr>
                        <td>Mercado Pago</td>
                        <td>

                            <%@ Import Namespace="mercadopago" %>
                            <%@ Import Namespace="System.Collections" %>

                            <%
                                MP mp = new MP("3663689865954092", "beN3ndKWpKW2QYdFl0iF8LsU6i05wXhg");

                                var Current = HttpContext.Current;

                                var prods = (List<TFI.GUI.Helpers.DTO.PedidoLista>)Current.Session["Pedido"];
                                
                                var count = 0;
                                string list = "";
                                foreach (var p in prods)
                                {
                                    var o = new
                                    {
                                        title = p.Producto.DescripProducto,
                                        quantity = p.Cantidad,
                                        currency_id = "ARS",
                                        unit_price = p.Producto.PrecioUnitario
                                    };
                                    var coma = "";
                                    if(count < prods.Count-1)
                                        coma = ",";                                    
                                    list = list + Newtonsoft.Json.JsonConvert.SerializeObject(o) + coma;
                                    count++;
                                };
                                
                                string preferenceData = "{\"items\":" +
                                                            "[" + list + "]" +
                                                         "}";

                                Hashtable preference = mp.createPreference(preferenceData);

                            %>
                            <a class="btn btn-success" target="_blank" href="<%Response.Write(((Hashtable)preference["response"])["init_point"]); %>" id="btnPagarMP">Mercado Pago</a>
                        </td>
                      </tr>--%>
                    <tr>
                        <td><%=Resources.Global.TarjetaDeCredito%></td>
                        <td>
                            <asp:Button CssClass="btn btn-success" ID="btnPagar" runat="server"  Style="display: none" Text="<%$Resources:Global, Pagar%>"></asp:Button>
                            <%--Lo quite del asp:button para probar y que solo funcione el pagarwebmethodOnClick="btnPagar_Click"--%>
                            <a href="#mdl_tarjeta" class="btn btn-success" data-toggle="modal"><%=Resources.Global.Pagar%></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div id="mdl_pedido" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.Felicitaciones%></h3>
                </div>
                <div class="modal-body text-center">
                    <h4 id="mdl_pedido_titulo" style="color: black;"><%=Resources.Global.Pedido %><span id="prod"></span><%=Resources.Global.PedidoCorrectamenteAgregado%></h4>
                    <h4><%=Resources.Global.SeleccionaFormadePago%></h4>
                </div>
                <div class="modal-footer">
                    <div class="text-center">
                        <button type="button" class="btn" style="width: 200px; background-color: black; color: #fff;" data-dismiss="modal"><%=Resources.Global.Continuar%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="mdl_transferencia" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.Enviado%></h3>
                </div>
                <div class="modal-body text-center">
                    <h4><%=Resources.Global.CorreoEnviadoConDatosDeTransferencia%></h4>
                </div>
                <div class="modal-footer">
                    <div class="text-center">
                        <a class="btn" style="width: 200px; background-color: black; color: #fff;" href="Home.aspx" id="btnContinuarCierre"><%=Resources.Global.Continuar%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="mdl_tarjeta" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.PagarConTarjeta%></h3>
                </div>
                <div class="modal-body text-center">
                    <h4 class="box-title"><%=Resources.Global.TarjetaSeleccionada%></h4>
                    <hr class="barras" />
                    <%if (MiTarjeta != null)
                        { %>
                    <div class="modal-body text-center">
                        <table>
                            <tr>
                                <td id="lblTitular" class="td-lbl"><%=Resources.Global.Titular%> : </td>
                                <td><%=MiTarjeta.Titular%></td>
                            </tr>
                            <tr>
                                <td id="lblTipo" class="td-lbl"><%=Resources.Global.Tipo%> : </td>
                                <td>
                                    <%if (MiTarjeta.miTipoTarjeta.IdTipoTarjeta == 1)
                                        { %> 
                                Visa
                                <%  }
                                    else
                                    { %> 
                                Master Card
                                <%} %>
                                </td>
                            </tr>
                            <tr>
                                <td id="lblNumero" class="td-lbl"><%=Resources.Global.Numero%> : </td>
                                <td><%=MiTarjeta.Numero %></td>
                            </tr>
                            <tr>
                                <td id="lblFechaExpiracion" class="td-lbl"><%=Resources.Global.FechaExpiracion%> : </td>
                                <td><%=MiTarjeta.Vencimiento.Date %></td>
                            </tr>
                        </table>
                    </div>
                    <% }
                        else
                        {%>
                    <div>
                        <p><%=Resources.Global.NoPoseeTarjetaRegistrada%> </p>
                    </div>
                    <%} %>
                    <div style="margin-top: 40px;">
                        <a class="btn btn-warning" id="cambiartarjeta" href="Tarjetas.aspx"><%=Resources.Global.ElegirOtraTarjeta%> </a>
                    </div>
                </div>
                <%if (MiTarjeta != null)
                    { %>
                <div class="modal-footer">
                    <div class="text-center">
                        <a href="#" id="btnpagarmodal" clientidmode="static" style="width: 200px; background-color: black; color: #fff;" class="btn btn-primary" data-toggle="modal"><%=Resources.Global.Pagar%></a>
                        <%--  <a class="btn" style="width: 200px; background-color: black; color: #fff;" href="#mdl_pagocompletado" id="btnPagoDefinitivo">Pagar</a>--%>
                    </div>
                </div>
                <% }%>
            </div>
        </div>
    </div>

    <div id="mdl_pagocompletado" data-backdrop="static" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.PagoRegistrado%></h3>
                </div>
                <div class="modal-body text-center">
                    <h4><%=Resources.Global.MuchasGraciasPorSuCompra%></h4>
                </div>
                <div class="modal-footer">
                    <div class="text-center">
                        <a class="btn" style="width: 200px; background-color: black; color: #fff;" href="Home.aspx" id="btnSalir"><%=Resources.Global.Continuar%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="mdl_PagoFallo" data-backdrop="static" class="modal fade" tabindex="-1" role="dialog">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                    <h3 class="modal-title" style="color: #de5900;"><%=Resources.Global.Pago%></h3>
                </div>
                <div class="modal-body text-center">
                    <h4><%=Resources.Global.PagoFallo%></h4>
                </div>
                <div class="modal-footer">
                    <div class="text-center">
                        <a class="btn" style="width: 200px; background-color: black; color: #fff;" href="UltimosPedidos.aspx" id="btnContinuarPagloFallo"><%=Resources.Global.Continuar%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptSection" runat="server">

    <script>


        Validar();//Está en Funciones.js


        var showComplete = function () {
            var $modal = $('#mdl_transferencia');
            $modal.modal("show");
        };

        $('#btTrasnferencia').click(function () {
            $.ajax({
                type: "POST",
                url: "PedidosConfirmacion.aspx/EnviarMailTrasnferencia",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (xhr, status, error) {
                    alert(error);
                },
                success: function () {
                    showComplete();
                }
            });
        });


        var limpiarPedido = function () {
            $.ajax({
                type: "POST",
                url: "PedidosConfirmacion.aspx/LimpiarPedido",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (xhr, status, error) {
                    alert(error);
                },

            });
        };

        //$('#btnPagarMP').click(function () {
        //    limpiarPedido();
        //})

        $('#mdl_transferencia').on('hidden.bs.modal', function () {
            limpiarPedido();
            app.redirect('UltimosPedidos.aspx');
        });

        //$('#mdl_pagocompletado').on('hidden.bs.modal', function () {
        //    limpiarPedido();
        //})

        $('#btnContinuarCierre').click(function () {
            limpiarPedido();
            app.redirect('UltimosPedidos.aspx');
        });

        $('#btnpagarmodal').click(function () {
            //var button = $('#btnPagar');
            //button.click();
            $.ajax({
                type: "POST",
                url: "PedidosConfirmacion.aspx/PagarWebMethod",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {                      // función que se va a ejecutar si el pedido resulta exitoso
                    // $('#notification').text('La información ha sido guardada exitosamente.');
                    if (data.d == true) {
                        var $modalpagoListo = $('#mdl_pagocompletado');
                        $modalpagoListo.modal("show");
                    }
                    else {
                        var $modalPagoFallo = $('#mdl_PagoFallo');
                        $modalPagoFallo.modal("show");
                    }
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });

            var $modal = $('#mdl_tarjeta');
            $modal.modal("hide");

        });

        $('#cambiartarjeta').click(function () {
            //var button = $('#btnPagar');
            //button.click();
            $.ajax({
                type: "POST",
                url: "PedidosConfirmacion.aspx/CambiarTarjeta",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (xhr, status, error) {
                    alert(error);
                },
            });

        });

    </script>
</asp:Content>

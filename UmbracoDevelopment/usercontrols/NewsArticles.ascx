<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsArticles.ascx.cs" Inherits="UmbracoDevelopment.usercontrols.NewsArticles" %>
<asp:Literal runat="server" ID="lout" />

<div class="form-inline input-append">
    <input runat="server" id="txtSrch" class="span2" placeholder="Search terms" />
    <input runat="server" class="datePicker span2" id="txtDateFrom" placeholder="From" />
    <input runat="server" class="datePicker span2" id="txtDateTo" placeholder="To" />
    <asp:CustomValidator runat="server" ID="custValDates" ErrorMessage="Please check search dates" />
    <asp:Button runat="server" ID="btnSrch" Text="Search" CssClass="btn btn-primary" />
</div>
<asp:ValidationSummary runat="server" ID="valsum" EnableClientScript="true"
    DisplayMode="List" />
<asp:Repeater runat="server" ID="rpt">
    <HeaderTemplate>
        <table class="table table-hover">
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><a href='<%# Eval("url") %>' title="Full article ...">
                <img class='img-rounded' src='<%# Eval("imgPath") %>' />
            </a>
            </td>
            <td>
                <%# Eval("title") %>
            </td>
            <td>
                <p><%# Eval("summary") %></p>
            </td>
            <td>
                <a href='<%# Eval("url") %>'>Link</a>
            </td>
            <td><%# Eval("NewsDate","{0:d}") %></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>

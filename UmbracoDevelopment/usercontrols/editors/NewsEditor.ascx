<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsEditor.ascx.cs" Inherits="UmbracoDevelopment.usercontrols.editors.NewsEditor" %>
<asp:PlaceHolder runat="server" ID="phAdd" Visible="false">
    <div class="well">
        <p class="lead">
            Your NewsItem was successfully added. <a runat="server" id="aPreview">Click here</a>
            to read it.
        </p>
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="pnGui">
    <div class="form-horizontal">
        <div class="control-group">
            <div class="control-label">
                Title
            </div>
            <div class="controls">
                <asp:TextBox runat="server" ID="txtTitle" CssClass="span2" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle" Text="Title missing" EnableClientScript="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                News Date
            </div>
            <div class="controls">
                <input runat="server" id="txtNewsDate" type="text" class="span2 datePicker" placeholder="News Date" />
                <asp:CustomValidator runat="server" ControlToValidate="txtNewsDate" Text="Check Date" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                Summary
            </div>
            <div class="controls">
                <input runat="server" type="text" class="span3 tinymce" placeholder="Summary" id="txtSummary" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSummary" ErrorMessage="Summary missing" EnableClientScript="true" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                Story
            </div>
            <div class="controls">
                <asp:TextBox runat="server" CssClass="span6 tinymce" TextMode="MultiLine" Rows="5" ID="txtStory" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStory" ErrorMessage="Story missing" />
            </div>
        </div>
        <div class="control-group">
            <div class="control-label">
                Legacy Image
            </div>
            <div class="controls">
                <input type="text" runat="server" placeholder="Legacy Image" class="span2" />
            </div>
        </div>
        <div class="btn-group pull-right">
            <button type="reset" value="Clear" class="btn">Clear</button>
            <asp:Button runat="server" ID="btnAdd" Text="Add" CssClass="btn btn-primary" />
        </div>
        <%--
    <div class="control-group">
        <div class="control-label">
            New Button
        </div>
        <div class="controls">
            <input type="button" class="btn" value="new button" />
        </div>
    </div>--%>
    </div>
</asp:PlaceHolder>

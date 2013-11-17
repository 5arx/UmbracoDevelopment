using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Umbraco.Core.Models;
using Umbraco.Web;
using umbWeb = Umbraco.Web.UI.Controls;
using umbraco;

namespace UmbracoDevelopment.usercontrols.editors
{
    public partial class NewsEditor : umbWeb.UmbracoUserControl
    {
        int __NEWS_HOMEPAGE_ID;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnAdd.Click += btnAdd_Click;
            __NEWS_HOMEPAGE_ID = Int32.Parse(ConfigurationManager.AppSettings["NewsRoomRootID"]);
        }

        void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) {
                addArticle();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void addArticle() {
            IContent newsItem;
            /*newsDate
ContentTags
legacyimage
headline
newsembargodate
newsSummary
NewsStory
NewsImage
NewsThumbnail
newsImageCaption
articleId*/
            var services = Services.ContentService;

            newsItem = services.CreateContent(txtTitle.Text.Trim(), __NEWS_HOMEPAGE_ID, "newsItem", 0);
            
            newsItem.SetValue("title", txtTitle.Text.Trim());
            newsItem.SetValue("summary", txtSummary.Value.Trim());
            newsItem.SetValue("story", txtStory.Text.Trim());

            DateTime dt;

            if (DateTime.TryParseExact(txtNewsDate.Value, "dd-MM-yyyy",
                new CultureInfo("en-GB"), DateTimeStyles.None, out dt))
            {
                newsItem.SetValue("newsDate", dt);
            }

            services.SaveAndPublish(newsItem);
            
            phAdd.Visible = false;

        }
    }
}
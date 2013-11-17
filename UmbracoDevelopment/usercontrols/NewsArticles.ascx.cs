using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

using Umbraco.Core.Models;
using Umbraco.Web;
using umbWeb = Umbraco.Web.UI.Controls;
using umbraco;

namespace UmbracoDevelopment.usercontrols
{
    public partial class NewsArticles : umbWeb.UmbracoUserControl
    {
        /// <summary>
        /// Deprecated. Remove from next build.
        /// </summary>
        public int Year
        {
            get;
            set;
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnSrch.Click += btnSrch_Click;
            custValDates.ServerValidate += custValDates_ServerValidate;
        }

        void custValDates_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime to, from;

            if ((DateTime.TryParseExact(txtDateFrom.Value, "dd-MM-yyyy",
                new CultureInfo("en-GB"), DateTimeStyles.None, out from))
                &&
                (DateTime.TryParseExact(txtDateTo.Value, "dd-MM-yyyy",
                new CultureInfo("en-GB"), DateTimeStyles.None, out to))
                && from <= to
               )
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        void btnSrch_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                displayItems();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                buildGui();
                displayItems();
            }
        }

        private void displayItems()
        {
            CultureInfo culture = new CultureInfo("en-GB");

            var dateFrom = DateTime.Parse(txtDateFrom.Value, culture.DateTimeFormat);
            var dateTo = DateTime.Parse(txtDateTo.Value, culture.DateTimeFormat);

            var articles = uQuery.GetNodesByType("NewsItem").ToList()
                            .FindAll(x => DateTime.Parse(x.GetProperty("newsDate").Value) >= dateFrom
                                    //x.CreateDate.Date >= dateFrom.Date
                                    && DateTime.Parse(x.GetProperty("newsDate").Value) <= dateTo.Date
                                    //x.CreateDate.Date <= dateTo.Date
                                    &&
                                    ( txtSrch.Value == string.Empty 
                                        ||
                                        (x.GetProperty("title").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                            || x.GetProperty("summary").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                            || x.GetProperty("story").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                        )
                                    )
                             );

            //            lout.Text += jobs.;
            var barticles = from node in articles
                            select new
                            {
                                Title = node.GetProperty("title").Value,
                                Story = node.GetProperty("story").Value,
                                Summary = node.GetProperty("summary").Value,
                                url = node.NiceUrl,
                                Thumbnail = node.GetProperty("thumbnail").Value,
                                ImgPath = uQuery.GetMedia(node.GetProperty("thumbnail").Value).GetImageThumbnailUrl(),
                                NewsDate = node.GetProperty("newsDate")
                            };

            rpt.DataSource = barticles;//newsitems.ToList();
            rpt.DataBind();
        }

        private void buildGui()
        {
            txtDateFrom.Value = DateTime.Now.AddMonths(-12).ToString("dd-MM-yyyy");
            txtDateTo.Value = DateTime.Now.ToString("dd-MM-yyyy");
        }
    }
}
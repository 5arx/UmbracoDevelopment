using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

using Umbraco.Core.Models;
using Umbraco.Web;
using umbraco;

namespace UmbracoDevelopment.usercontrols
{
    public partial class JobVacancyList : System.Web.UI.UserControl
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

            var jobs = uQuery.GetNodesByType("JobAd").ToList()
                            .FindAll(x => DateTime.Parse(x.GetProperty("closingDate").Value) >= DateTime.Now
                                    &&
                                    (txtSrch.Value == string.Empty
                                        ||
                                        (x.GetProperty("jobTitle").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                            || x.GetProperty("directorate").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                            || x.GetProperty("jobDescription").ToString().IndexOf(txtSrch.Value, StringComparison.OrdinalIgnoreCase) > 0
                                        )
                                    )
                             );

            //            lout.Text += jobs.;
            var barticles = from node in jobs
                            select new
                            {
                                JobTitle = node.GetProperty("jobTitle").Value,
                                Directorate = node.GetProperty("directorate").Value,
                                url = node.NiceUrl,
                                JobDescription = node.GetProperty("jobDescription").Value,
                                //ImgPath = uQuery.GetMedia(node.GetProperty("thumbnail").Value).GetImageThumbnailUrl(),
                                ClosingDate = node.GetProperty("closingDate").Value
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
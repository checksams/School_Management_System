using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SerenePayroll
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLiblary_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxLibTemplate.aspx", true);
        }

        protected void btnSchool_Click(object sender, EventArgs e)
        {
            //Response.Redirect("~/Default.apsx", true);
        }

        protected void btnInventory_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxInvTemplate.aspx", true);

        }

        protected void btnTransport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxTMTemplate.aspx", true);

        }

        protected void btnHR_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxHRTemplate.aspx", true);

        }

        protected void btnFinancial_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxFCTemplate.aspx", true);

        }

        protected void btnAssets_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxAMTemplate.aspx", true);

        }

        protected void btnSysAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/aspxSysAdminTemplate.aspx", true);

        }
    }
}

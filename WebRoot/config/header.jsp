<script src="js/frame/om_code.js" type="text/javascript"></script>
<%@ page import="java.net.URLEncoder"%>
<%!
public class CS{
    private  int siteId = 0;
    private final String imageDomain = "c.cnzz.com";
    private HttpServletRequest request = null;
    private HttpServletResponse response = null;

    public CS(int siteId){
        this.setAccount(siteId);
    };   

    public void setAccount(int siteId){
        this.siteId = siteId;
    };

    public String trackPageView(){
        String imageLocation = this.request.getScheme() + "://"+ this.imageDomain + "/wapstat.php";
        String r = this.request.getHeader("referer") == null ? "" : this.request.getHeader("referer");
        String rnd = Integer.toString((int)(Math.random() * 0x7fffffff));
        String imageUrl = imageLocation + "?" + "siteid=" + this.siteId + "&r=" + URLEncoder.encode(r) + "&rnd=" + rnd;
        return imageUrl;
    };

    public void setHttpServlet(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
}
%>
<%CS cs = new CS(1257987634);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  style="display:none"/> 
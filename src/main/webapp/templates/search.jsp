<%@ page language="java" import="gov.nysenate.openleg.util.JSPHelper, gov.nysenate.openleg.util.OpenLegConstants,gov.nysenate.openleg.search.SenateResponse,gov.nysenate.openleg.search.Result,java.text.SimpleDateFormat, java.util.Iterator"  contentType="text/html" pageEncoding="utf-8" %><%

String appPath = request.getContextPath();

String term = (String)request.getAttribute("term");

String sortField = (String)request.getAttribute("sortField");
String type = (String)request.getAttribute("type");
String search = (String)request.getAttribute("search");
String urlPath = (String)request.getAttribute("urlPath");
String filter = (String) request.getAttribute("filter");

if(search != null)
	term = search;

term = java.net.URLEncoder.encode(term, "UTF-8");

boolean sortOrder = true;
if (request.getAttribute("sortOrder")!=null)
			sortOrder = Boolean.parseBoolean((String)request.getAttribute("sortOrder"));
			
if (sortField == null)
	sortField = "";
	
if (type == null)
	type = "";

int pageIdx = Integer.parseInt((String)request.getAttribute(OpenLegConstants.PAGE_IDX));
int pageSize = Integer.parseInt((String)request.getAttribute(OpenLegConstants.PAGE_SIZE));

int startIdx = (pageIdx - 1) * pageSize;
int endIdx = startIdx + pageSize;

SenateResponse sr = (SenateResponse)request.getAttribute("results");
int resultCount = sr.getResults().size();

int total = (Integer)sr.getMetadataByKey("totalresults");

if (total < endIdx) {
	endIdx = total;
}

String mode = (String)request.getAttribute("type");
		
	SimpleDateFormat sdf = new SimpleDateFormat();
	sdf.applyPattern("EEE, MMM d, yyyy");
	
	String prevUrl = null;
if (pageIdx-1 > 0)
{
	if(urlPath != null) {
		prevUrl = urlPath + (pageIdx-1) + (pageSize != 20 ? "/" + pageSize:"") + (filter != null ? "?filter=" + filter:"");
	}
	else {
		prevUrl = "/legislation/search/" + term + "/" + (pageIdx - 1) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	}
}
	
String nextUrl = null;

if (total > endIdx)
{
	if(urlPath != null) {
		nextUrl = urlPath + (pageIdx+1) + (pageSize != 20 ? "/" + pageSize:"") + (filter != null ? "?filter=" + filter:"");
	}
	else {
		nextUrl = "/legislation/search/" + term + "/" + (pageIdx + 1) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	}
}
	
%>
<div id="content">

<% String encodedTerm = java.net.URLEncoder.encode(term,"UTF-8"); %>
<div class='formats'>
	Formats:
	<a href="/legislation/api/atom/search/<%=encodedTerm%>/">ATOM</a>,
	<a href="/legislation/api/rss/search/<%=encodedTerm%>/">RSS</a>
</div>
<div class="content-bg">
<h2 class='page-title'><%=type.toUpperCase()%> SEARCH RESULTS</h2>

    <div id="subcontent">
 <%
 	if (resultCount>0){
 %>
 <div class="search-nav">
<%-- <%
	if (prevUrl!=null){
%><a href="">&lt; prev</a> - <%
	}
%> --%>
<div class="result-totals">
Showing Results <%=startIdx+1%> - <%=endIdx%> of <%=total%>
</div>
<div class="pagination">
<ul>
<%
	int totalPages = (total+20-1)/20;
	int currentPage = ((startIdx+20-1)/20)+1;
	
	String currentPageLink = "/legislation/search/" + term + "/" + (currentPage) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	
	int back4 = (currentPage-4);
	int back3 = (currentPage-3);
	int back2 = (currentPage-2);
	int back1 = (currentPage-1);
	int forward1 = (currentPage+1);
	int forward2 = (currentPage+2);
	int forward3 = (currentPage+3);
	int forward4 = (currentPage+4);
	String FirstPageLink = "/legislation/search/" + term + "/1/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	
	String totalPagesLink =  "/legislation/search/" + term + "/" + (totalPages) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	
	String back4Link = "/legislation/search/" + term + "/" + (back4) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String back3Link = "/legislation/search/" + term + "/" + (back3) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String back2Link = "/legislation/search/" + term + "/" + (back2) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String back1Link = "/legislation/search/" + term + "/" + (back1) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String forward1Link = "/legislation/search/" + term + "/" + (forward1) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String forward2Link = "/legislation/search/" + term + "/" + (forward2) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String forward3Link = "/legislation/search/" + term + "/" + (forward3) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	String forward4Link = "/legislation/search/" + term + "/" + (forward4) + "/" + pageSize
			+ "?sort=" + sortField
			+ "&sortOrder=" + sortOrder;
	
 	System.out.println(currentPage);
		
	if (prevUrl!=null){%>
		<li><a href="<%=prevUrl%>" title="Previous page">«</a></li>
	<%}else{%>
		<li class="disabled"><a>«</a></li>
	<%}
	if ((currentPage >= totalPages || currentPage > 4 ) && totalPages > 4 ){%>
		<li><a href="<%=FirstPageLink%>">1</a></li>
		<li><a>...</a></li>
	<%}
	
	if (back4 >= 1 && ((totalPages-currentPage) < 3) ){%>
		<li><a href="<%=back4Link%>"><%=back4%></a></li>
	<%}
	if (back3 >= 1 && ((totalPages-currentPage) < 2) ){%>
		<li><a href="<%=back3Link%>"><%=back3%></a></li>
	<%}
	if (back2 >= 1){%>
		<li><a href="<%=back2Link%>"><%=back2%></a></li>
	<%}
	if (back1 >= 1){%>
		<li><a href="<%=back1Link%>"><%=back1%></a></li>
	<%}
	 %>
     <li class="active"><a href="<%=currentPageLink%>"><%=currentPage%></a></li>
     <%
     if (forward1 < totalPages){%>
		<li><a href="<%=forward1Link%>"><%=forward1%></a></li>
	<%}
     if (forward2 < totalPages){%>
		<li><a href="<%=forward2Link%>"><%=forward2%></a></li>
	<%}
     if (forward3 < totalPages && currentPage < 3 ){%>
		<li><a href="<%=forward3Link%>"><%=forward3%></a></li>
	<%}
     if (forward4 < totalPages && currentPage < 2){%>
		<li><a href="<%=forward4Link%>"><%=forward4%></a></li>
	<%}
     if (forward3 < totalPages){%>
		<li><a>...</a></li>
	<%}
     if (currentPage < totalPages){%>
		<li><a href="<%=totalPagesLink%>"><%=totalPages%></a></li>
	<%}	
	if (nextUrl!=null){%>
		<li><a href="<%=nextUrl%>" title="Next page">»</a></li>
	<%}else{%>
		<li class="disabled"><a>»</a></li>
	<%}
%>
                
 	</ul>
 </div>

            <div class='sortby'>
                Order by:
                <% if (sortField.equals("modified") && sortOrder){%>
                    Recent Updates
                <%} else{ %>
                    <a href="/legislation/search/<%=term%>?sort=modified&sortOrder=true">Recent Updates</a>
                <%}%>,

				<%if (sortField.equals("modified") && (!sortOrder)){%>Oldest Updates<%}
				else{ %><a href="/legislation/search/<%=term%>?sort=modified&sortOrder=false">Oldest Updates</a><%}%>,
				
				<%if (sortField.equals("committee")){%>Committee<%}
				else{ %><a href="/legislation/search/<%=term%>?sort=committee&sortOrder=false">Committee</a><%}%>,
				
				<%if (sortField.equals("")){%>Best Match<%}
				else{ %><a href="/legislation/search/<%=term%>?sort=oid&sortOrder=false"">Best Match</a><%}%>
				</div>
            </div>
            <hr/>
        <% }

		Iterator it = sr.getResults().iterator();
		Result sresult = null;
		  
		String resultType = null;
		String resultId = null;
		 
		String contentType = null;
		String contentId = null;
		String resultTitle = null;

		String senateType = null;
	
	    while (it.hasNext()) {
	        sresult = (Result) it.next();	
            resultType = sresult.getOtype();
            
            //System.out.println("got result type: " + resultType);
            if (resultType.indexOf(".")!=-1) {
                resultType = resultType.substring(resultType.lastIndexOf(".")+1);
            }

            resultId = sresult.getOid();

            contentType = resultType;
            contentId = java.net.URLEncoder.encode(resultId,"UTF-8");
            resultTitle = sresult.getTitle();
            senateType = (String)sresult.getFields().get("type").toUpperCase();

            if (contentType.equals("vote")) {
	            contentType = "bill";
	            contentId = (String)sresult.getFields().get("billno");
            }
            else if (contentType.equals("action")) {
                contentType = "bill";
                contentId = (String)sresult.getFields().get("billno");
            }
            else if (contentType.equals("bill")) {
                String billNo = sresult.getFields().get("billno");
                if (billNo != null) {
                    if (!billNo.startsWith("A") && !billNo.startsWith("S")) {
                        senateType = "RESOLUTION";
                    }
                }
            }
             
            if (resultTitle == null) {
                resultTitle = "(no title)";
            } else {
            	if(contentType.equals("bill")) {
            	    senateType += " " + sresult.getFields().get("billno");
                }
            }

            String resultPath = appPath + "/" + contentType + "/" + contentId; %>
            <div class="row">
                <a href="<%=resultPath%>"><%=senateType%>: <%=resultTitle%></a>
                <span class="subrow">
               	<a href="<%=resultPath%>">
                <%if (sresult.getSummary()!=null && sresult.getSummary().length() > 0){ %>
                    <br/>
                    <%=sresult.getSummary() %>
                <%} %>
 				</a>
			    <%if (sresult.getFields().get("sameAs")!=null && sresult.getFields().get("sameAs").length()>0){ %>
			        <br/>
			        Same As: <a href="<%=appPath%>/search/?term=oid:%22<%=sresult.getFields().get("sameAs")%>%22" class="sublink"><%=sresult.getFields().get("sameAs")%></a>
			    <%} %>
			 
			    <%if ((!contentType.equals("bill")) && sresult.getFields().get("billno")!=null && sresult.getFields().get("billno").length()>0){ %>
			        <br/>
			        Bill: <a href="<%=appPath%>/search/?term=oid:%22<%=sresult.getFields().get("billno")%>%22" class="sublink"><%=sresult.getFields().get("billno")%></a>
			    <%} %>
			 
			    <%if (sresult.getFields().containsKey("sponsor")){ %>
			        <br/>
				    <% if (sresult.getFields().get("otherSponsors").isEmpty()) { %>
				        Sponsor: <%=JSPHelper.getPersonLink(sresult.getFields().get("sponsor"),appPath)%>
				    <% } else { %>
				        Sponsors: <%=JSPHelper.getPersonLink(sresult.getFields().get("sponsor"),appPath)%>, <%=JSPHelper.getSponsorLinks(sresult.getFields().get("otherSponsors").split(", ?"), appPath) %>
				    <% } %>  
				   
			    <%} %>
			 
			    <%if (sresult.getFields().get("chair")!=null){ %>
			        <br/>
			        Chairperson: <a href="<%=appPath%>/search/?term=chair:%22<%=java.net.URLEncoder.encode((String)sresult.getFields().get("chair"),"UTF-8")%>%22"  class="sublink"><%=sresult.getFields().get("chair")%></a>
			    <%} %>
 
			    <%if (sresult.getFields().get("committee")!=null && !sresult.getFields().get("committee").isEmpty()){ %>
			        <br/>
			        Committee: <a href="<%=appPath%>/committee/<%=sresult.getFields().get("committee").replaceAll(" ","-")%>"  class="sublink"><%=sresult.getFields().get("committee")%></a>
			    <%} %>
			 
			 
			    <%if (sresult.getFields().get("location")!=null){ %>
			        <br/>
			        Location: <a href="<%=appPath%>/search/?term=location:<%=java.net.URLEncoder.encode("\"" + sresult.getFields().get("location") + "\"")%>"  class="sublink"><%=sresult.getFields().get("location")%></a>
			    <%} %>
			 
			    <%if (sresult.getFields().get("date")!=null){ %>
			        <br/>
			        Date: <a href="<%=appPath%>/search/?term=<%=java.net.URLEncoder.encode("\"" + sresult.getFields().get("date") + "\"")%>"  class="sublink"><%=sresult.getFields().get("date")%></a>
			    <%} %>
               </span>
            </div>
        <% } %>
        <hr/>
        <% if (resultCount>0) { %>
<div class="footer-pagination">

<div class="pagination">
<ul>
<%
int totalPages = (total+20-1)/20;
int currentPage = ((startIdx+20-1)/20)+1;
String currentPageLink = "/legislation/search/" + term + "/" + (currentPage) + "/" + pageSize
+ "?sort=" + sortField
+ "&sortOrder=" + sortOrder;

int back4 = (currentPage-4);
int back3 = (currentPage-3);
int back2 = (currentPage-2);
int back1 = (currentPage-1);
int forward1 = (currentPage+1);
int forward2 = (currentPage+2);
int forward3 = (currentPage+3);
int forward4 = (currentPage+4);
String FirstPageLink = "/legislation/search/" + term + "/1/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;

String totalPagesLink = "/legislation/search/" + term + "/" + (totalPages) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;

String back4Link = "/legislation/search/" + term + "/" + (back4) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String back3Link = "/legislation/search/" + term + "/" + (back3) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String back2Link = "/legislation/search/" + term + "/" + (back2) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String back1Link = "/legislation/search/" + term + "/" + (back1) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String forward1Link = "/legislation/search/" + term + "/" + (forward1) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String forward2Link = "/legislation/search/" + term + "/" + (forward2) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String forward3Link = "/legislation/search/" + term + "/" + (forward3) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;
String forward4Link = "/legislation/search/" + term + "/" + (forward4) + "/" + pageSize
		+ "?sort=" + sortField
		+ "&sortOrder=" + sortOrder;

	System.out.println(totalPages-currentPage);
	
if (prevUrl!=null){%>
	<li><a href="<%=prevUrl%>" title="Previous page">«</a></li>
<%}else{%>
	<li class="disabled"><a>«</a></li>
<%}
if ((currentPage >= totalPages || currentPage > 4 ) && totalPages > 4 ){%>
	<li><a href="<%=FirstPageLink%>">1</a></li>
	<li><a>...</a></li>
<%}

if (back4 >= 1 && ((totalPages-currentPage) < 3) ){%>
	<li><a href="<%=back4Link%>"><%=back4%></a></li>
<%}
if (back3 >= 1 && ((totalPages-currentPage) < 2) ){%>
	<li><a href="<%=back3Link%>"><%=back3%></a></li>
<%}
if (back2 >= 1){%>
	<li><a href="<%=back2Link%>"><%=back2%></a></li>
<%}
if (back1 >= 1){%>
	<li><a href="<%=back1Link%>"><%=back1%></a></li>
<%}
 %>
 <li class="active"><a href="<%=currentPageLink%>"><%=currentPage%></a></li>
 <%
 if (forward1 < totalPages){%>
	<li><a href="<%=forward1Link%>"><%=forward1%></a></li>
<%}
 if (forward2 < totalPages){%>
	<li><a href="<%=forward2Link%>"><%=forward2%></a></li>
<%}
 if (forward3 < totalPages && currentPage < 3 ){%>
	<li><a href="<%=forward3Link%>"><%=forward3%></a></li>
<%}
 if (forward4 < totalPages && currentPage < 2){%>
	<li><a href="<%=forward4Link%>"><%=forward4%></a></li>
<%}
 if (forward3 < totalPages){%>
	<li><a>...</a></li>
<%}
 if (currentPage < totalPages){%>
	<li><a href="<%=totalPagesLink%>"><%=totalPages%></a></li>
<%}	
if (nextUrl!=null){%>
	<li><a href="<%=nextUrl%>" title="Next page">»</a></li>
<%}else{%>
	<li class="disabled"><a>»</a></li>
<%}
%>
                
 	</ul>
 </div>
        <% } %>
    </div>
    </div>
    </div>
</div>


<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page session="true" %>
<%
    Log objLog  = objLog = new Log();

    try 
    {     
        //session
        HttpSession hs = request.getSession(true);

        //argument
        String username = hs.getAttribute("x").toString();
        int requestid = Integer.parseInt(request.getParameter("index"));
        String status = request.getParameter("index1");
       
        Log.logger.info("requestid:"+requestid);
        Log.logger.info("status:"+status);
        
        if (((username != null) && (!username.trim().equals(""))) && (requestid != 0)) 
        {
            if (status.equals("Approved")) 
            {              
                status = "Un Approved";               
            } 
            else if (status.equals("Un Approved")) 
            {               
                status = "Approved";
            } 
            else 
            {
                status = "Suspected";
            }

            String sql = "UPDATE user_appointment "
                   + "SET Status = '" + status + "' "
                   + "WHERE App_Id = '" + requestid + "' ";
                
            Log.logger.info("sql:"+sql);
            
            DatabaseFile.getInstance().codeupdate(sql);
          
            %>
                <jsp:forward page="appdetails.jsp">
                    <jsp:param name="msg" value="110"/>
                </jsp:forward>
            <%
        } 
        else 
        {
            %>
                <jsp:forward page="appdetails.jsp">
                    <jsp:param name="msg" value="102"/>
                </jsp:forward>
            <%
        }
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
        
        Log.logger.error("Error:", e);
        Log.logger.warn("This is a warning message");
        Log.logger.trace("This message will not be logged since log level is set as DEBUG");
    }

%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
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
       
        if (((username != null) && (!username.trim().equals(""))) && (requestid != 0)) 
        {          
               String sql = "DELETE FROM blood_banks "
                          + "WHERE Blood_bank_id = '" + requestid + "' ";

               DatabaseFile.getInstance().codeinsert(sql);     

               %>
                   <jsp:forward page="bloodbanks.jsp">
                       <jsp:param name="msg" value="109"></jsp:param>               
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
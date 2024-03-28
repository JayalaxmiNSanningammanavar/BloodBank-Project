<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page session="true" %>
<%
    Log objLog  = objLog = new Log();

    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        //argument
        String username =  hs.getAttribute("x").toString();
        
        //getting values from design page
        String name = request.getParameter("name");        
        String address = request.getParameter("address");
        String phoneno = request.getParameter("phoneno");
        String id = request.getParameter("hide");
                         
        if(((name!=null) && (!name.trim().equals(""))) && ((address!=null) && (!address.trim().equals("")))
                && ((phoneno!=null) && (!phoneno.trim().equals(""))) && ((id!=null) && (!id.trim().equals(""))))
        {     
            String sql = "UPDATE blood_banks "
                       + "SET Blood_bank_name = '"+name+"', "                  
                       + "Blood_bank_address = '"+address+"', "
                       + "Blood_bank_address = '"+phoneno+"' "     
                       + "WHERE Blood_bank_id = '" + id + "' ";
                  
            DatabaseFile.getInstance().codeupdate(sql);
                        
                     %>
                        <jsp:forward page="bloodbanks.jsp">
                             <jsp:param name="msg" value="Account modified Successfully!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                        <jsp:forward page="bloodbanks.jsp">
                             <jsp:param name="msg" value="Record Not Modified Successfully!"/>
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
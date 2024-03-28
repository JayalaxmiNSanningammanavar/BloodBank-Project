<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
    <head profile="http://gmpg.org/xfn/11">
        <title>Blood Bank Management System</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="imagetoolbar" content="no" />
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />
        <%@page errorPage="ErrorPage.jsp"%>
        <%@page session="true" %>
    </head>
    <body id="top">
        <div class="wrapper row1">
            <div id="header" class="clear">
                <div class="fl_left">
                    <h1><a href="index.jsp">Blood Bank Management System</a></h1>
                    <p>Management System
                        <span style="padding-left: 250px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>                           
                    </p>
                </div>
                <div class="fl_right">
                  
                </div>
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row2">
            <div class="rnd">
                <!-- ###### -->
                <div id="topnav">
                    <ul>                                                       
                        <li><a href="adminhome.jsp">Blood Bank</a></li>
                        <li class="active"><a href="bloodbanks.jsp">Search Blood Bank</a></li>
                        <li><a href="bloodgroups.jsp">Search Blood Groups</a></li>
                        <li><a href="suggestions.jsp">Search Suggestions</a></li>
                        <li><a href="donors.jsp">Search Donors</a></li>
                        <li><a href="appdetails.jsp">Appointment Details</a></li>
                        <li class="last"><a href="Signout.jsp">Sign Out</a></li>
                    </ul>
                </div>
                <!-- ###### -->
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row3">
            <div class="rnd">
                <div id="container" class="clear">
                    <!-- ####################################################################################################### -->
                              
                   <h1>Edit Blood Bank Details</h1>
                    
                   <form action="codebankedit.jsp" method="post">
          
                    <%   
                       Log objLog  = objLog = new Log();                                      
                       Vector<Object> rsp = null;
                       Statement st = null;
                       ResultSet rs = null;
                       Connection con = null;
    
                        try
                        {                                                      
                             if ((request.getParameter("index") != null) && (!(request.getParameter("index").trim().equals("")))) 
                             {
                                 String sql = "SELECT Blood_bank_name, Blood_bank_address, Blood_bank_ph_no "
                                            + "FROM blood_banks "
                                            + "WHERE Blood_bank_id = '"+request.getParameter("index")+"'";
                                
                                rsp = DatabaseFile.getInstance().codeselect(sql);

                                st = (Statement) rsp.get(0);
                                rs = (ResultSet) rsp.get(1);
                                con = (Connection) rsp.get(2);
                            
                                while(rs.next())
                                {          
                                   %>
                                   
                                      <table align="center" border="0px" width="100px">

                                          <tr style="color: red;">
                                              <td>Blood Bank Name:</td><td><input type="text" name="name" size="45px" value="<%=rs.getString(1)%>" />*</td>
                                          </tr>

                                          <tr style="color: red;">
                                              <td>Blood Bank Address:</td><td><textarea cols="42" rows="6" name="address" ><%=rs.getString(2)%></textarea>*</td>
                                          </tr>

                                          <tr style="color: red;">
                                              <td>Blood Bank Phone No:</td><td><input type="text" name="phoneno" value="<%=rs.getString(3)%>"  size="45px"/>*</td>
                                          </tr>

                                          <tr>
                                                <td>&nbsp;</td><td><input type="hidden" name="hide" value="<%=request.getParameter("index")%>" size="54px"/></td><td>&nbsp;</td>
                                          </tr>

                                          <tr>
                                              <td>&nbsp;</td>
                                              <td><input type="submit" value="Update"/><input type="reset" value="Reset"/></td><td>&nbsp;</td>
                                          </tr>

                                      </table>
                                   <%
                                 }                               
                             }                             
                        }
                        catch(Exception e)
                        {
                            e.printStackTrace();

                            Log.logger.error("Error:", e);
                            Log.logger.warn("This is a warning message");
                            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                        }
                        finally
                        {
                            try
                            {
                                if(st != null)
                                {
                                    st.close(); 
                                    st = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            try
                            {
                                if(rs != null)
                                {
                                    rs.close(); 
                                    rs = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            try
                            {
                                if(con != null)
                                {
                                    DatabaseFile.cp.surrenderConnection(con);

                                    con.close();
                                    con = null;
                                }
                            }
                            catch(Exception e)
                            {
                                e.printStackTrace();

                                Log.logger.error("Error:", e);
                                Log.logger.warn("This is a warning message");
                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                            }

                            rsp = null;
                        }
                        %>

                  </form>
                               
                    </div>

                    <%
                        //getting response
                        try 
                        {
                            out.println("<font color = 'red'>");

                            if ((request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals("")))) 
                            {
                                String respMsg = AppBundle.getInstance().loadpropertyfile(request.getParameter("msg"), Constants.Config);
              
                                out.println(respMsg != null ? respMsg : AppBundle.getInstance().loadpropertyfile("100", Constants.Config));
                            }

                            out.println("</font>");
                        } 
                        catch (Exception e) 
                        {
                            e.printStackTrace();
                
                            Log.logger.error("Error:", e);
                            Log.logger.warn("This is a warning message");
                            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                        }
                    %>
                    <!-- ####################################################################################################### -->
                </div>
            </div>        
    </body>
</html>

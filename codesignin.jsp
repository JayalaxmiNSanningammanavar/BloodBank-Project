<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>

<%!

public boolean isAlphabet(String s)
{
        Pattern p = Pattern.compile("^[A-Za-z]+$", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        boolean b = m.find();
       
        if(b)
        {
            System.out.println("true");
            
            return true;
        }
        else
        {
             System.out.println("false");
         
             return false;   
        }               
}

public boolean isNumeric(String s)
{
        Pattern p = Pattern.compile("^[0-9]+$", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        boolean b = m.find();
       
        if(b)
        {       
            return true;
        }
        
        return false;   
}

public boolean isAlphaNumeric(String s)
{
        Pattern p = Pattern.compile("^[a-zA-Z0-9]+$", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        boolean b = m.find();
       
        if(b)       
        {
            return true;
        }
        
        return false;   
}

public boolean isEmail(String s)
{
        String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

        Pattern p = Pattern.compile(EMAIL_PATTERN, Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        boolean b = m.find();
       
        if(b)       
        {
            return true;
        }
        
        return false;   
}

%>

<%

Log objLog  = objLog = new Log();
 
try
{
    Vector<Object> rsp = null;
    Statement st = null;
    ResultSet rs = null;
    Connection con = null;
    int count = 0;
            
    //getting values from design page
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String phoneno = request.getParameter("phone");
    String email = request.getParameter("email");
    String bloodtype = request.getParameter("bloodtype");
    String address = request.getParameter("address");    
    String username = request.getParameter("username");
    String password = request.getParameter("password");      
    
    if( ((name!=null) && (!name.trim().equals(""))) && ((gender!=null) && (!gender.trim().equals("")))                  
            && ((phoneno!=null) && (!phoneno.trim().equals(""))) && ((email!=null) && (!email.trim().equals(""))) 
            && ((bloodtype != null) && (!bloodtype.trim().equals("-select-")))
            && ((address!=null) && (!address.trim().equals(""))) && ((username!=null) && (!username.trim().equals(""))) 
            && ((password!=null) && (!password.trim().equals(""))))
    {    
        if(isAlphabet(name))    
        {      
            if((phoneno.length() >= 10) && isNumeric(phoneno))    
            {    
                if(isEmail(email))
                {     
                    if(isAlphaNumeric(password))
                    {                                                         
                        //type casting
                        Long mobile = Long.parseLong(phoneno);

                        //jdbc connection
                        try
                        {            
                            //calling database class            
                            String sql1 = "SELECT COUNT(*) AS c "
                                        + "FROM userdetails "
                                        + "WHERE User_Username = '"+username+"' "
                                        + "AND User_Password = '"+password+"' ";

                            rsp = DatabaseFile.getInstance().codeselect(sql1);

                            st = (Statement) rsp.get(0);
                            rs = (ResultSet) rsp.get(1);
                            con = (Connection) rsp.get(2);

                            while(rs.next())
                            {
                                count = rs.getInt(1);
                                System.out.println("count:"+ count);
                            }

                            if(count > 0)
                            {
                               %>
                               <jsp:forward page="Signin.jsp">
                                   <jsp:param name="msg" value="105"></jsp:param>
                               </jsp:forward>
                               <%
                            }

                            if(count == 0)
                            {
                                String sql = "insert into userdetails(User_Name, Gender, User_PhoneNo, User_Email, BloodType, User_Addres, User_Username, User_Password, Created_Date)"
                                    + " values('"+name+"', '"+gender+"', '"+mobile+"', '"+email+"', '"+bloodtype+"', '"+address+"', '"+username+"', '"+password+"', now())";

                                DatabaseFile.getInstance().codeinsert(sql);

                               %>
                                   <jsp:forward page="index.jsp">
                                       <jsp:param name="msg" value="106"></jsp:param>

                                   </jsp:forward>
                               <%
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
                     }
                    else
                    {
                                        %>
                                           <jsp:forward page="Signin.jsp">
                                               <jsp:param name="msg" value="115"></jsp:param>
                                           </jsp:forward>
                                        <%
                    }                    
                }
                else
                {
                            %>
                               <jsp:forward page="Signin.jsp">
                                   <jsp:param name="msg" value="119"></jsp:param>
                               </jsp:forward>
                            <%
                }
            }
            else
            {
                    %>
                       <jsp:forward page="Signin.jsp">
                           <jsp:param name="msg" value="118"></jsp:param>
                       </jsp:forward>
                    <%
            }
        }
        else
        {
            %>
               <jsp:forward page="Signin.jsp">
                   <jsp:param name="msg" value="116"></jsp:param>
               </jsp:forward>
            <%
        }                      
    }
    else
    {
           %>
           <jsp:forward page="Signin.jsp">
               <jsp:param name="msg" value="102"></jsp:param>
           </jsp:forward>
           <%
    }    
}
catch(Exception e)
{
    e.printStackTrace();
                
    Log.logger.error("Error:", e);
    Log.logger.warn("This is a warning message");
    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
}    
%>
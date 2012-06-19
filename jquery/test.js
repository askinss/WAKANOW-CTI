$(function(){
  

    var client = new Faye.Client('http://10.10.5.96:9292/faye');
    client.subscribe("/ajaxsearches", function(data) {
       var exten = (data.exten_no);
       var searcharray = (data.resarray);
       var contact = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'>Create Contact</a>"
       var contactImage = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'><img title='Create Contact' border=0 src='jquery/images/contact_plus.gif'/></a>"
       var service = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'>Service Request</a>"
       var serviceImage = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><img title='Service Request' border=0 src='jquery/images/cases.gif'/></a>"

       $("<div>").html("<table cell-spacing='3' width='100%'>" + searcharray + "<tr colspan=2><td>&nbsp;<td></tr><tr><td>" + contact + "&nbsp;" + contactImage  + "</td><td>" + service + "&nbsp;" + serviceImage + "</td></tr></table>" ).dialog({width: 600,});
       console.log(contact);
       
      });  
    client.subscribe("/incomings", function(data) {
      
      var a = (data.caller_number);
      var b = new String(data.caller_name);
      var c = new String($('#agentExten').text());
      var d = (data.exten_id);
      var e = (data.caller_id)
      var f = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index'><h1><FONT COLOR= red>create contact</FONT></h1></a>"
      var h = "<a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + e + "><img border=0 src='jquery/images/contacts.gif' title=" + b + "/></a>"
      
      var j = "<a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + e + ">" + b + "</a>"
      var z = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'><img title='Create Contact' border=0 src='jquery/images/contact_plus.gif'/></a>"
      var y = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Leads&action=EditView&return_module=Leads&return_action=index' title='Create Lead'><img title='Create Lead' border=0 src='jquery/images/leads.gif'/></a>"
      var x = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><img title='Service Request' border=0 src='jquery/images/cases.gif'/></a>"
      


   // 
      var g = "<font face='arial' size = 1em><br>Phone:  </font><b>" + a + "</b><font face='arial' size=1em><br><br>Search by name:&nbsp;<input type='text' name='txtValue' value='' id='name'>"

      

// "</button></div><br></label>Contact: </font>" + "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'><font face='arial' size=1em><b>Create Contact</b></font></a><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Leads&action=EditView&return_module=Leads&return_action=index' title='Create Lead'><font face='arial' size=1em><b>Create Lead</b></font></a><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><font size=1em><b>Service Request</b></font></a>" + z + "<br>" + y + "<br>" + x 
    //else 

      var i = "<table cellspacing = '10'><tr colspan = '3'><td><font face='arial' size = 1em>Phone:</font></td><td height='32' align='left'><b>" + a + "</b></td></tr><tr valign='top'><td><font face='arial' size=1em>Contact: </font></td><td><font face='arial' size=1em><b>" + j + "</b></font></a><br><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index&account_name=" + b + "' title='Service Request'><font face='arial' size=0.4.5em><b>Attach service request</b></font></a></td><td>" + h + "</td><td>" + x + "</td></tr></table>"
      
      if (d == c) { //this is used to check pick up the right message from the queues for the extensions 
         if (e == undefined) { //used to create a new contact where one does not exist
            $("<div>").html(g).dialog({ 
              title: "Incoming Call from Unknown Number",
              draggable: false,
              modal: true,
              buttons: {
               "Search": function(){
               var strng = ($('#name').val());
               var ca = new String($('#agentExten').text());
               $.post("http://10.10.5.96:3000/ajaxsearch/new/?name=" + strng + "&extenno=" + ca); }},
              height: 170,
	      width: 310,
              
            });   
         }
         else {
              
           $("<div>").html(i).dialog({ 
            title: "Incoming Call:",
            draggable: false,
            modal: true,
            height: 160,
	    width: 330,
          });  
         } 
      }});

    
   $('#dial').click(function(){
       sendValue($('#call').val());  
   });
   function sendValue(str){
       
       var c = new String($('#agentExten').text());
       $.post("http://10.10.5.96:3000/externcall/new/?a=" + str + "&b=" + c); } });//ajax POST request to initiate a call
 
 
 




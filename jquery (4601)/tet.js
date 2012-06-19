$(function(){
    var client = new Faye.Client('http://10.10.5.41:9292/faye');
    client.subscribe("/incomings", function(data) {
      var a = (data.caller_number);
      var b = new String(data.caller_name);
      var c = new String($('#agentExten').text());
      var d = (data.exten_id);
      var e = (data.caller_id)
      var f = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index'><h1><FONT COLOR= red>create contact</FONT></h1></a>"
      var h = "<a href='http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record='" + e + "title=" + b + "><img title=" + b + "src='images/contacts.png'/></a>"
      
      var j = "<a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + e + ">" + b + "</a>"
      var z = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'><img title='Create Contact' src='images/contact_plus.png'/></a>"
      var y = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Leads&action=EditView&return_module=Leads&return_action=index' title='Create Lead'><img title='Create Lead' src='images/lead_plus.png'/></a>"
      var x = "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><img title='Service Request' src='images/cases.png'/></a>"
      
      


      var g = "<table cellspacing = '2'><tr colspan = '3'><td><b>Phone:</b></td><td height='32' ><b>" + a + "</b></td></tr><tr valign='top'><td><b>Contact:</b></td><td>" + "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index' title='Create Contact'><font size=0.6em><b>Create Contact</b></font></a><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Leadss&action=EditView&return_module=Leadss&return_action=index' title='Create Lead'><font size=0.6em><b>Create Lead</b></font></a><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><font size=0.6em><b>Service Request</b></font></a></td><td>" + z + "</td><td>" + y + "</td><td>" + x + "</td></tr></table>"

      var i = "<table cellspacing = '2'><tr colspan = '3'><td><b>Phone:</b></td><td align='left'><b>" + a + "</b></td></tr><tr valign='top'><td><b>Contact: </b></td><td>" + "<a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=EditView&return_module=Contacts&return_action=index'><font size=0.6em><b>" + b + "</b></font></a><br><br><a href= 'http://10.10.5.104:8080/wakanow/index.php?module=Cases&action=EditView&return_module=Cases&return_action=index' title='Service Request'><font size=0.4.5em><b>Attach service request</b></font></a></td><td>" + h + "</td><td>" + x + "</td></tr></table>"
      
      if (d == c) { //this is used to check pick up the right message from the queues for the extensions 
         if (e == undefined) { //used to create a new contact where one does not exist
            $("<div>").html(g).dialog({ 
              title: "Incoming Call:",
              draggable: false,
              modal: true,
              height: 130,
            });   
         }
         else {
              
           $("<div>").html(i).dialog({ 
            title: "Incoming Call:",
            draggable: false,
            modal: true,
            height: 130,
          });  
         } 
      }
  
});   
   $('#dial').click(function(){
       sendValue($('#call').val());  
   });
   function sendValue(str){
       
       var c = new String($('#agentExten').text());
       $.post("http://10.10.5.148:3000/externcall/new/?a=" + str + "&b=" + c); } });//ajax POST request to initiate a call

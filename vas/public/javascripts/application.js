// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

    $(function() {  
      var faye = new Faye.Client('http://10.10.5.208:9292/faye');  
        faye.subscribe('/incomings', function (message) {
         eval(message);
    });
   });
    

    require File.expand_path("../environment", __FILE__)
    require 'faye'
    require 'eventmachine'
      
    job "sugar.find" do |args| 
     begin 
      @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{args["name"]}%'"})
#.collect{ |user| "<tr><td><b><a href='http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record="+"#{user.id}" + "'>" + "#{user.account_name}"+"</b></td>" + "</a><td>Email address: <b>" +  "#{user.email1}"+"</b><a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + "#{user.id}" + "><img border=0 src='jquery/images/contacts.gif' title=" + "#{user.account_name}" + "/></a></tr>" }
    #  faye = Faye::Client.new('http://10.10.5.96:9292/faye')
     #       msge = JSON.dump('channel' => "/ajaxsearches", 'data' => {'exten_no' => "#{args["extenno"]}", 'resarray' =>  "#{@search.to_s.delete '["",]'}", 'nameSearch' => "#{args["name"]}", 'newcallid' => "#{args["caller_id"]}"})
      #      uri = URI.parse('http://0.0.0.0:9292/faye')
       #     Net::HTTP.post_form(uri, :message => msge)

#      faye = Faye::Client.new('http://10.10.5.96:9292/faye')
#          EM.run {
#           faye.publish("/ajaxsearches", {'resarray' =>  "#{@search}"})
#          }

      
     rescue

      #faye = Faye::Client.new('http://10.10.5.96:9292/faye')
       #     msge = JSON.dump('channel' => "/ajaxsearches", 'data' => {'exten_no' => "#{args["extenno"]}", 'resarray' =>  "#{@search.to_s.delete "[", "]", '""'}", 'nameSearch' => "#{args["name"]}", 'newcallid' => "#{args["caller_id"]}"})
        #    uri = URI.parse('http://0.0.0.0:9292/faye')
         #   Net::HTTP.post_form(uri, :message => msge)

      #faye = Faye::Client.new('http://10.10.5.96:9292/faye')
       #   EM.run {
        #   faye.publish("/ajaxsearches", {'resarray' =>  "#{@search}"})
         # }
      @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{args["name"]}%'"})
#.collect{ |user| "<tr><td><b><a href='http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record="+"#{user.id}" + "'>" + "#{user.account_name}"+"</b></td>" + "</a><td>Email address: <b>" +  "#{user.email1}"+"</b><a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + "#{user.id}" + "><img border=0 src='jquery/images/contacts.gif' title=" + "#{user.account_name}" + "/></a></tr>" }

     
     end 
    end  

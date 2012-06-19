class AjaxsearchController < ApplicationController
require 'stalker'
respond_to :json
  def new

=begin
      
       @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{params[:name]}%'"}).collect{ |user| "<tr><td><b><a href='http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record="+"#{user.id}" + "'>" + "#{user.account_name}"+"</b></td>" + "</a><td>Email address: <b>" +  "#{user.email1}"+"</b><a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + "#{user.id}" + "><img border=0 src='jquery/images/contacts.gif' title=" + "#{user.account_name}" + "/></a></tr>" }
#      @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{params[:name]}'"}).collect{ |user| { :first_name => user.first_name :id => user.account_id, :name => user.account_name }}
    rescue
       @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{params[:name]}%'"}).collect{ |user| "<tr><td><b><a href='http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record="+"#{user.id}" + "'>" + "#{user.account_name}"+"</b></td>" + "</a><td>Email address: <b>" +  "#{user.email1}"+"</b>&nbsp;<a href=" + 'http://10.10.5.104:8080/wakanow/index.php?module=Contacts&action=DetailView&record=' + "#{user.id}" + "><img border=0 src='jquery/images/contacts.gif' title=" + "#{user.account_name}" + "/></a></tr>" }
#      @search = Sugar.find(:all, :conditions => {:first_name => "LIKE '%#{params[:name]}'"}).collect{ |user| { :first_name => user.first_name :id => user.account_id, :name => user.account_name }}
    end
=end
      #@search = Ajaxsearch.fetch(params[:name])
      @ajaxsearches = Ajaxsearch.create({:name => params[:name], :extenno => params[:extenno], :caller_id => params[:caller_id]})
      if @ajaxsearches.update_attributes(params[:ajaxsearch])
      #s = Stalker.enqueue('search', :id => @search.id)
      Stalker.enqueue("sugar.find", {:name => params[:name], :extenno => params[:extenno], :caller_id => params[:caller_id]})
      end
      respond_to do |format|
       format.js {render :json =>  @search}
      end
  end

  def create
    @ajaxsearches = Ajaxsearch.new(params[:incoming])
  end

end

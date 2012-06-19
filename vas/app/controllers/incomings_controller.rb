require 'switchvox'
class IncomingsController < ApplicationController
  def index
    @incoming = Incoming.all

  end 
  #the new method creates a record of the calls in database, queries sugarCRM for records matching the caller's phone number and publishes the data via the messaging server(faye)
  def new
Rails.logger.info("Ayo")
    @incoming = Incoming.create({:exten_number => params[:exten_number], :cid_number => params[:cid_number]})
    if (params[:cid_number])[0] == "8"
      params[:cid_number] = "0" + params[:cid_number]
      begin
        @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      rescue
        begin
          @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        rescue
          @count = 1
        end
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      end
    elsif (params[:cid_number])[0] == "7"
      params[:cid_number] = "0" + params[:cid_number]
      begin
        @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      rescue
        begin
          @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        rescue
          @count = 1
        end
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      end
    elsif (params[:cid_number])[0] == "1"
      params[:cid_number] = "0" + params[:cid_number]
      begin
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
        @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
      rescue
        begin
          @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        rescue
          @count = 1
        end
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      end
    else
      begin
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
          @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        rescue
      rescue
        begin
          @count = Sugar.count(:conditions => {:phone_work => "LIKE #{params[:cid_number]}"})
        rescue
          @count = 1
        end
        @contact = Sugar.find_by_phone_fax(params[:cid_number]) || Sugar.find_by_phone_mobile(params[:cid_number]) || Sugar.find_by_phone_other(params[:cid_number]) || Sugar.find_by_phone_work(params[:cid_number])
Rails.logger.info("Ayo #{@contact.inspect}")
      end
    end


      #Rails.logger.info (@contact.inspect)
    if @incoming.update_attributes(params[:incoming])

      #Rails.logger.info (@contact.inspect)
      require 'eventmachine'
      #the IP address for the machine hosting the faye messaging server should be passed here
      faye = Faye::Client.new('http://0.0.0.0:9292/faye')
      if @contact.nil?
        msg = JSON.dump('channel' => "/incomings", 'data' => {"exten_id" => "#{@incoming.exten_number}", "caller_number" => "#{params[:cid_number]}", "caller_name" => "no details exists for this user"})
        uri = URI.parse('http://0.0.0.0:9292/faye')
        Net::HTTP.post_form(uri, :message => msg) 
      else
        if @count.nil?
          (@contact.account_name == nil) ? (msg = JSON.dump('channel' => "/incomings", 'data' => {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.first_name} #{@contact.last_name}", 'caller_number' => "#{params[:cid_number]}" })) :          (msg = JSON.dump('channel' => "/incomings", 'data' => {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.account_name}", 'caller_number' => "#{params[:cid_number]}" }))
          uri = URI.parse('http://0.0.0.0:9292/faye')
          Net::HTTP.post_form(uri, :message => msg)
        elsif @count > 1
          msg = JSON.dump('channel' => "/incomings", 'data' => {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.account_name}", 'caller_number' => "#{params[:cid_number]}", 'count' => "There are ,<b>" + "#{@count}" + " contacts</b> with this phone number<a href='http://10.10.5.104:8080/wakanow/index.php?action=UnifiedSearch&query_string=" + "#{params[:cid_number]}" + "'> Click here to view them</a>"})
          uri = URI.parse('http://0.0.0.0:9292/faye')
          Net::HTTP.post_form(uri, :message => msg)
        else
          (@contact.account_name == nil) ? (msg = JSON.dump('channel' => "/incomings", 'data' => {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.first_name} #{@contact.last_name}", 'caller_number' => "#{params[:cid_number]}" })) :          (msg = JSON.dump('channel' => "/incomings", 'data' => {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.account_name}", 'caller_number' => "#{params[:cid_number]}" }))
          uri = URI.parse('http://0.0.0.0:9292/faye')
          Net::HTTP.post_form(uri, :message => msg)
        end
        #EM.run {
        #faye.publish("/incomings", {'exten_id' => "#{@incoming.exten_number}", 'caller_id' =>  "#{@contact.id}", 'caller_name' =>  "#{@contact.account_name.capitalize}", 'caller_number' => "#{params[:cid_number]}" })
        #}

        #EM.run {
        #faye.publish("/incomings", {"exten_id" => "#{@incoming.exten_number}", "caller_number" => "#{params[:cid_number]}", "caller_name" => "no details exists for this user"})
        #}
      end
      #       end

    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @incoming }
    end
  end

  def create
    @incoming = Incoming.new(params[:incoming])
  end

  # GET /incomings/1
  # GET /incomings/1.xml

  def call
    Switchvox_call.calling(params[:dial_number])
  end


  def update
  end
end

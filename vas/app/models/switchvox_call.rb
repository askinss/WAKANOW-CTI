require 'switchvox'
 class Switchvox_call
   def self.calling(dial_number, exten_number)
      switchvox = Switchvox::Base.new("#{CONFIG[:switchvox_ip]}", 'admin', 'Passw0rd', {:debug => false})

      getInfo = switchvox.request("switchvox.extensions.getInfo", {
        "extensions" => [exten_number],
      })
      account_id = getInfo.extensions.extension.account_id
      dial = switchvox.request("switchvox.call", {
      "dial_first" => exten_number,
      "dial_second" => dial_number,
      "dial_as_account_id" => account_id,
      "auto_answer" => "1",
      })
   end
 end


def self.getinfo(exten_number)
   switchvox = Switchvox::Base.new("#{CONFIG[:switchvox_ip]}", 'admin', 'Passw0rd', {:debug => true})
   account_id = switchvox.request("switchvox.extensions.getInfo", {
   "extension" => exten_number})


end


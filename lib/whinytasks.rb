class WhinyTasks
    VERSION = '0.1.1'
    def self.whine(subject, message)
        WhinyTasks.send("whine_via_" + CONFIG[:delivery_method], build_message(subject, message))
    end

    def self.build_message(subject, message)
        msg = <<END_OF_MESSAGE 
From: #{WhinyTasks::CONFIG[:from_alias]} <#{WhinyTasks::CONFIG[:from]}>
To: #{WhinyTasks::CONFIG[:to_alias]} <#{WhinyTasks::CONFIG[:to]}>
Subject: #{subject}

        #{message}
END_OF_MESSAGE
    end

    def self.whine_via_smtp(message)
        Net::SMTP.start('localhost') do |smtp|
            smtp.send_message message, WhinyTasks::CONFIG[:from], WhinyTasks::CONFIG[:to]
        end
    end

    def self.whine_via_sendmail(message)
        sendmail = IO.popen("#{WhinyTasks::CONFIG[:sendmail_path]} #{WhinyTasks::CONFIG[:to]}", 'w+')
        sendmail.puts message
        sendmail.close
    end
end

class Object
    def whiny_task(deps, &block)
        if eval(WhinyTasks::CONFIG[:whine_if])
            block_with_exception_handling = Proc.new do 
                begin
                    block.call
                rescue Exception => e 
                    WhinyTasks.whine(e.message, e.backtrace.join("\n"))
                end
            end 
            task deps, &block_with_exception_handling
        else
            task deps, &block
        end
    end
end

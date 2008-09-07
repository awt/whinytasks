module WhinyTasks
    VERSION = '0.0.2'
end

class Object
    def whine(subject, message)
        msg = <<END_OF_MESSAGE
        From: #{WhinyTasks::CONFIG[:from_alias]} <#{WhinyTasks::CONFIG[:from]}>
        To: #{WhinyTasks::CONFIG[:to_alias]} <#{WhinyTasks::CONFIG[:to]}>
        Subject: #{subject}

        #{message}
END_OF_MESSAGE
        
    Net::SMTP.start('localhost') do |smtp|
            smtp.send_message msg, WhinyTasks::CONFIG[:from], WhinyTasks::CONFIG[:to]
        end
    end

    def whiny_task(deps, &block)
        if eval(WhinyTasks::CONFIG[:whine_if])
            block_with_exception_handling = Proc.new do 
                begin
                    block.call
                rescue Exception => e 
                    whine(e.message, e.backtrace.join("\n"))
                end
            end 
            task deps, &block_with_exception_handling
        else
            task deps, &block
        end
    end
end

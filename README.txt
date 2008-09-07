= whinytasks

* http://adamthorsen.com/whinytasks

== DESCRIPTION:

WhinyTasks is sort of like ExceptionMailer but specifically designed for rake tasks that
run in the background.  With any website, background jobs tend to accumulate and sometimes
it's hard to tell if they're working properly.  WhinyTasks defines the whiny_task method,
which can be used in place of the task method and results in tasks that send emails to
a designated address when an exception occurrs during the execution of the task.

== FEATURES/PROBLEMS:

* Sends an email to a configurable address if an exception occurs during the
execution of a rake task.

== SYNOPSIS:

    WhinyTasks::CONFIG = {
                              :to => "alice@example.com", 
                              :to_alias => "Alice",
                              :from => "no-reply@example.com",
                              :from_alias => "Site Exception Notifier"
                              :whine_if => "Merb.environment == 'production'"
                          }

    whiny_task :run_background_jobs => :environment do
        raise "Uh oh!"
    end

== REQUIREMENTS:

* requires rake

== INSTALL:

    sudo gem install whinytasks

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

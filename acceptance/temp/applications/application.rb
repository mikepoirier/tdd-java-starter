require 'colorize'

class Application
  def run
    if healthcheck_is_200? @health_url
      puts "Application #{@name} is already up. Taking no action".yellow
    else
      `rm #{@name}*.log`

      command = "SERVER_PORT=#{@port} ./gradlew clean assemble bootRun"
      puts "Attempting to start #{@name} at #{@base_url} with command: #{command}".yellow

      @pid = Process.spawn(
        command,
        chdir: "../../#{@dir}",
        pgroup: true,
        out: "#{@name}.std.log",
        err: "#{@name}.err.log"
      )

      wait_for_app_to_start

      at_exit {
        puts "Shutting down #{@name}".yellow

        puts "Killing pid #{@pid}".yellow
        Process.kill('TERM', @pid)
      }
    end
  end

  def wait_for_app_to_start
    attempts = 0
    until healthcheck_is_200? @health_url
      if attempts >= max_timeout_in_seconds
        puts ''
        puts `cat *.log`
        raise "#{@name} never came up. See logs above".red
      end

      if address_in_use? @name
        puts `cat *.log`
        raise "Address #{@base_url} already in use. See logs above".red
      end

      if build_failed? @name
        puts `cat *.log`
        raise 'Build failed. See logs above'.red
      end

      attempts += 1
      sleep 1
      print "\r[#{attempts} / #{max_timeout_in_seconds}] Waiting for #{@name} to start".yellow
    end
    puts ''
  end

  def address_in_use?(name)
    `cat #{name}*`.include? 'Address already in use'
  end

  def healthcheck_is_200?(healthcheck_url)
    HTTParty.get(healthcheck_url).code == 200
  rescue Errno::ECONNREFUSED
    false
  end

  def build_failed?(name)
    `cat #{name}*`.include? 'FAILURE: Build failed with an exception.'
  end

  def max_timeout_in_seconds
    @max_timeout_in_seconds || 20
  end
end

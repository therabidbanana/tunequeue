## Phased out for pusher app support
# Eventually may want ability to toggle back and forth - just need this socket
# to emulate a few events that pusher does.
Cramp::Websocket.backend = :thin

class SocketAction < Cramp::Websocket
  self.transport = :websocket

  on_data :received_data
  on_start :opened_conn
  on_finish :closed_conn


  def opened_conn
    puts "Browser connecting..."
    @@clients ||= []
    @@clients << Proc.new do |data|
      puts "rendering"
      render data
    end
  end

  def received_data(data)
    @@clients.each do |c|
      c.call(data)
    end
  end

  def closed_conn
    puts "Browser disconnecting..."
  end

end



#!/usr/bin/env ruby

require "webrick"
require "github/markup"

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
        file = request.path[1..-1]
        extensions = [".md", ".wiki", ".creole", ".org"]
        extensions.each do |extension|
            if File.file?("wiki/" + file + extension)
                response.status = 200
                #response.content_type = "text/plain" #test output
                response.body = GitHub::Markup.render(file + extension, File.read("wiki/" + file + extension))
            end
        end
    end
end

server = WEBrick::HTTPServer.new(:Port => 80)

server.mount "/", MyServlet

trap("INT") {
    server.shutdown
}

server.start
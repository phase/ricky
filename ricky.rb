#!/usr/bin/env ruby

require "webrick"
require "github/markup"

def render_page(file, extension)
    markup = GitHub::Markup.render(file + extension, File.read("wiki/" + file + extension))
    theme = File.read("theme.html")
    theme = theme.gsub! "{% title %}", file
    theme = theme.gsub! "{% content %}", markup
    return theme
end

class RickyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
        file = request.path[1..-1]
        extensions = [".md", ".wiki", ".creole", ".org"]
        extensions.each do |extension|
            if File.file?("wiki/" + file + extension)
                response.status = 200
                #response.content_type = "text/plain" #test output
                response.body = render_page file, extension
            end
        end
    end
end

server = WEBrick::HTTPServer.new(:Port => 80)

server.mount "/", RickyServlet

trap("INT") {
    server.shutdown
}

server.start
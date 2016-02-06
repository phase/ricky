#!/usr/bin/env ruby

require "webrick"
require "github/markup"

def render_page(file, extension)
    markup = GitHub::Markup.render(file + extension, File.read("wiki/" + file + extension))
    theme = File.read(ARGV[0])
    theme = theme.gsub! "{% title %}", file
    theme = theme.gsub! "{% content %}", markup
    return theme
end

class RickyServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
        file = request.path[1..-1]
        extensions = [".md", ".wiki", ".creole", ".org"]
        file_found = false
        extensions.each do |extension|
            if File.file?("wiki/" + file + extension)
                file_found = true
                response.status = 200
                #response.content_type = "text/plain" #test output
                response.body = render_page file, extension
            end
        end
        if not file_found 
            extensions.each do |extension|
                if File.file?("wiki/" + "404" + extension)
                    file_found = true
                    response.status = 404
                    response.body = render_page "404", extension
                end
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
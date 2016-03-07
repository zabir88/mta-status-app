class StatusesController < ApplicationController
	def index
		require 'open-uri'
		require 'nokogiri'
		data= Nokogiri::HTML(open("http://web.mta.info/status/serviceStatus.txt"))

		@service_types = params[:service_types]
		@service_types_capital= params[:service_types].to_s.upcase
		@line_name, @status, @text, @timestamp= [], [], [], ''
	
		data.css("service/timestamp").each do |time|
			@timestamp<<time
		end 		
		
		data.css("#{@service_types}/line").each do |categories|
			@line_name<<categories.at_css('name').text
			@status<<categories.at_css('status').text
			@text<<categories.at_css('text').text.gsub(/<\/?[^>]*>/, '').gsub(/\n\n+/, "\n").gsub(/^\n|\n$/, '')
		end
		
	end
end

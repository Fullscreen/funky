module Funky
  module Connection
    class Base

    private

      def self.get_http_request(uri)
        Net::HTTP::Get.new(uri.request_uri)
      end

      def self.response_for(http_request, uri)
        response = Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
          http.request http_request
        end
        response
      end
    end
  end
end
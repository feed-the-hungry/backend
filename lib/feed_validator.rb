# frozen_string_literal: true

require 'faraday'
require 'faraday/follow_redirects'
require 'nokogiri'

class FeedValidator
  attr_reader :url

  def initialize(url)
    @url = url
    @valid = true
  end

  def call
    begin
      response = fetch(@url)

      @valid = parse_response(response.body) if response.success?
    rescue StandardError
      @valid = false
    end

    self
  end

  def valid?
    @valid == true
  end

  private

  def fetch(url)
    connection = Faraday.new('https://validator.w3.org') do |f|
      f.request :url_encoded

      f.response :follow_redirects, limit: 5

      f.adapter Faraday.default_adapter
    end

    connection.get('/feed/check.cgi', { url:, output: 'soap12' })
  end

  def parse_response(xml_content)
    document = Nokogiri.XML(xml_content)

    document.remove_namespaces!

    document.xpath('/Envelope/Body/feedvalidationresponse/validity').first.children.to_s == 'true'
  end
end

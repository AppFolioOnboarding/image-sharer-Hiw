require 'rest-client'

class Image < ApplicationRecord
  validate :check_url_valid

  def check_url_valid
    # get the HTTP response
    res = RestClient.get(url)
    check_response(res) if res
  rescue StandardError => e
    determine_error(e)
  end

  private

  def check_response(res)
    # check header OK
    if res.code != 200
      errors.add(:url, "- Could not fetch the given url :( Got HTTP #{res.code}")
    # check MIME content type
    elsif !res.headers[:content_type].start_with?('image')
      errors.add(:url, '- Hey! Wait a second, the URL is not an image')
    end
  end

  def determine_error(err)
    case err
    when SocketError
      errors.add(:url, "- Could not find #{url}. Make sure it's correct!")
    when RestClient::NotFound
      errors.add(:url, '- Could not fetch the given url :( Got HTTP 404')
    else
      errors.add(:url, '- Oops, something went wrong!')
    end
  end
end

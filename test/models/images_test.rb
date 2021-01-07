require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @image_url = 'https://www.example.com/image1.jpg'
    @invalid_url = 'test'
    @text_url = 'google.com'
    @tags = %w[foo bar thisisatag]
  end

  test 'valid url' do
    image = Image.new(url: @image_url)
    assert image.valid?
  end

  test 'invalid url' do
    image = Image.new(url: @invalid_url)
    assert_not image.valid?
  end

  test 'text url' do
    image = Image.new(url: @text_url)
    assert_not image.valid?
  end

  test 'valid url with tags' do
    image = Image.new(url: @image_url, tag_list: @tags.join(', '))

    assert image.valid?
    assert_equal image.tag_list, @tags
  end
end

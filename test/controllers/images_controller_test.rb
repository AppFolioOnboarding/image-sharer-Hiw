require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_url = 'https://www.example.com/image1.jpg'
    @invalid_url = 'test'
    @text_url = 'google.com'
    @image = Image.create(url: @image_url)
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_url, params: { image: { url: @image.url } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should show image' do
    get image_url(@image)
    assert_response :success
  end

  test 'should not add invalid URL' do
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: @invalid_url } }
    end
  end

  test 'should not add text URL' do
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: @text_url } }
    end
  end
end

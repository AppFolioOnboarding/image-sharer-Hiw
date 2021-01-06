require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_url = images(:image_url)
    @invalid_url = images(:not_url)
    @text_url = images(:text_url)
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_url, params: { image: { url: @image_url.url } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should show image' do
    get image_url(@image_url)
    assert_response :success
  end

  test 'should not add invalid URL' do
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: @invalid_url.url } }
    end
  end

  test 'should not add text URL' do
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: @text_url.url } }
    end
  end
end

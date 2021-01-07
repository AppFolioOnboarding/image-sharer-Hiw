require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Image.delete_all

    @image_url = 'https://www.example.com/image1.jpg'
    @invalid_url = 'test'
    @text_url = 'google.com'
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image' do
    assert_difference 'Image.count' do
      post images_url, params: { image: { url: @image_url } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should show image' do
    @image = Image.create!(url: @image_url)

    get image_url @image
    assert_response :success
  end

  test 'should not add invalid URL' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: @invalid_url } }
    end
  end

  test 'should not add text URL' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: @text_url } }
    end
  end

  test 'should show index' do
    image2_url = 'https://www.example.com/image2.jpg'

    Image.create!(url: @image_url)
    Image.create!(url: image2_url)

    get images_url

    assert_response :success
    assert_select 'img', count: 2
    assert_select 'img' do |elements|
      assert_equal image2_url, elements[0].attr('src')
      assert_equal @image_url, elements[1].attr('src')
    end
  end
end

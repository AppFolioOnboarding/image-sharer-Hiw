require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Image.delete_all

    @image_url = 'https://www.example.com/image1.jpg'
    @image2_url = 'https://www.example.com/image2.jpg'
    @invalid_url = 'test'
    @text_url = 'google.com'
    @tags = %w[foo bar thisisatag]
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

  test 'should destroy image' do
    @image = Image.create!(url: @image_url)

    assert_difference 'Image.count', -1 do
      delete image_url @image
    end

    assert_redirected_to images_path
  end

  test 'should destroy image that doesn\'t exist' do
    assert_no_difference 'Image.count' do
      delete image_url id: 42
    end

    assert_redirected_to images_path
  end

  test 'should show image' do
    @image = Image.create!(url: @image_url)

    get image_url @image
    assert_response :success

    assert_select 'img', count: 1
    assert_select 'img' do |elements|
      assert_equal @image_url, elements[0].attr('src')
    end
  end

  test 'should show image tags' do
    @image = Image.create!(url: @image_url, tag_list: @tags.join(','))

    get image_url @image
    assert_response :success

    assert_select 'li', count: @tags.count
    assert_select 'li' do |elements|
      (0..@tags.count - 1).each do |i|
        assert_equal @tags[i], elements[i].content
        assert_equal "/images/tags/#{@tags[i]}", elements[i].children.attr('href').value
      end
    end
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
    Image.create!(url: @image_url)
    Image.create!(url: @image2_url)

    get images_url

    assert_response :success
    assert_select 'img', count: 2
    assert_select 'img' do |elements|
      assert_equal @image2_url, elements[0].attr('src')
      assert_equal @image_url, elements[1].attr('src')
    end
  end

  test 'should show tags on index' do
    Image.create!(url: @image_url, tag_list: @tags.join(','))

    get images_url

    assert_response :success

    assert_select 'a.index-image-tags' do |elements|
      (0..@tags.count - 1).each do |i|
        assert_equal @tags[i], elements[i].content.gsub(/\s*,*/, '')
        assert_equal "/images/tags/#{@tags[i]}", elements[i].attr('href')
      end
    end
  end

  test 'should shows images on tags' do
    tags2 = %w[foo bar2]

    Image.create!(url: @image_url, tag_list: @tags.join(','))
    Image.create!(url: @image2_url, tag_list: tags2.join(','))

    get '/images/tags/foo'

    assert_select 'h1', count: 1, text: 'foo'
    assert_select 'img', 2
    assert_select 'img' do |elements|
      assert_equal @image2_url, elements[0].attr('src')
      assert_equal @image_url, elements[1].attr('src')
    end
  end
end

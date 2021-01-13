require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should validate all params present' do
    post api_feedbacks_path params: { feedback: { name: 'foo', comments: 'bar' } }

    assert_response :success
    assert_equal JSON.parse(response.body), 'status' => 'success'
  end

  test 'should invalidate no name' do
    post api_feedbacks_path params: { feedback: { comments: 'bar' } }

    assert_response :bad_request
    assert_equal JSON.parse(response.body), 'status' => 'error', 'error' => 'Name cannot be empty'
  end

  test 'should invalidate empty name' do
    post api_feedbacks_path params: { feedback: { name: '   ', comments: 'bar' } }

    assert_response :bad_request
    assert_equal JSON.parse(response.body), 'status' => 'error', 'error' => 'Name cannot be empty'
  end

  test 'should invalidate no comments' do
    post api_feedbacks_path params: { feedback: { name: 'foo' } }

    assert_response :bad_request
    assert_equal JSON.parse(response.body), 'status' => 'error', 'error' => 'Comments cannot be empty'
  end

  test 'should invalidate empty comments' do
    post api_feedbacks_path params: { feedback: { name: 'foo', comments: '    ' } }

    assert_response :bad_request
    assert_equal JSON.parse(response.body), 'status' => 'error', 'error' => 'Comments cannot be empty'
  end
end

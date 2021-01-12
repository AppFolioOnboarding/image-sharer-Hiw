/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import fetch from 'node-fetch';
import App from '../../components/App';

describe('<App />', () => {
  beforeEach(() => {
    sinon
      .stub(fetch, 'Promise')
      .returns(Promise.resolve({
        status: 200,
        json: () => Promise.resolve({ status: 'success' })
      }));
  });

  afterEach(() => {
    sinon.restore();
  });

  it('should render correctly', () => {
    const wrapper = shallow(<App />);

    assert.strictEqual(wrapper.find('Header').length, 1);
    assert.strictEqual(wrapper.find('Header').prop('title'), 'Tell us what you think');
    assert.strictEqual(wrapper.find('Button').length, 1);
    assert.strictEqual(wrapper.find('#nameForm').length, 1);
    assert.strictEqual(wrapper.find('#commentsForm').length, 1);
    assert.strictEqual(wrapper.find('Footer').length, 1);
    assert.strictEqual(wrapper.find('Footer').prop('text'), 'Copyright: Appfolio Inc. Onboarding');
  });

  it('should be able to populate name', () => {
    const wrapper = shallow(<App />);
    const name = 'Foo Bar';

    wrapper.setState({ name });
    const nameForm = wrapper.find('#nameForm');

    assert.strictEqual(nameForm.prop('value'), name);
  });

  it('should be able to set name state', () => {
    const wrapper = shallow(<App />);
    const name = 'Foo Bar';
    const event = { target: { value: name } };

    const nameForm = wrapper.find('#nameForm');
    nameForm.simulate('change', event);

    assert.strictEqual(wrapper.state('name'), name);
  });

  it('should be able to populate comments', () => {
    const wrapper = shallow(<App />);
    const comments = 'Foo Bar\nThis is a comment!';

    wrapper.setState({ comments });
    const commentsForm = wrapper.find('#commentsForm');

    assert.strictEqual(commentsForm.prop('value'), comments);
  });

  it('should be able to set comments state', () => {
    const wrapper = shallow(<App />);
    const comments = 'Foo Bar\nThis is a comment!';
    const event = { target: { value: comments } };

    const commentsForm = wrapper.find('#commentsForm');
    commentsForm.simulate('change', event);

    assert.strictEqual(wrapper.state('comments'), comments);
  });

  it('should not show alert on mount', () => {
    const wrapper = shallow(<App />);

    assert.strictEqual(wrapper.find('Alert').length, 0);
  });

  it('should show danger alert on error', () => {
    const wrapper = shallow(<App />);
    const error = 'this is an error';

    wrapper.setState({ submitted: true, error });
    const alertWrapper = wrapper.find('Alert');

    assert.strictEqual(alertWrapper.length, 1);
    assert.strictEqual(alertWrapper.prop('color'), 'danger');
    assert.strictEqual(alertWrapper.render().text(), error);
  });

  it('should show success alert on success', () => {
    const wrapper = shallow(<App />);

    wrapper.setState({ submitted: true });
    const alertWrapper = wrapper.find('Alert');

    assert.strictEqual(alertWrapper.length, 1);
    assert.strictEqual(alertWrapper.prop('color'), 'success');
    assert.strictEqual(alertWrapper.render().text(), 'Successfully submitted!');
  });

  it('should reset name field on successful submission', (done) => {
    const wrapper = shallow(<App />);
    const nameForm = wrapper.find('#nameForm');

    nameForm.simulate('change', { target: { value: 'Foo Bar' } });
    wrapper.find('Form').simulate('submit', { preventDefault: () => {} });


    // Wait for fetch Promise to resolve
    setImmediate(() => {
      wrapper.update();

      assert.strictEqual(nameForm.prop('value'), '');

      done();
    });
  });

  it('should reset comments field on successful submission', (done) => {
    const wrapper = shallow(<App />);
    const commentsForm = wrapper.find('#commentsForm');

    commentsForm.simulate('change', { target: { value: 'Foo Bar\nThis is a comment' } });
    wrapper.find('Form').simulate('submit', { preventDefault: () => {} });

    setImmediate(() => {
      wrapper.update();

      assert.strictEqual(commentsForm.prop('value'), '');

      done();
    });
  });

  it('should show server error on submit', (done) => {
    const error = 'Foo bar error';
    const wrapper = shallow(<App />);

    sinon.restore();
    sinon
      .stub(fetch, 'Promise')
      .returns(Promise.resolve({
        status: 400,
        json: () => Promise.resolve({ error })
      }));

    wrapper.find('Form').simulate('submit', { preventDefault: () => {} });

    setImmediate(() => {
      wrapper.update();
      const alertWrapper = wrapper.find('Alert');

      assert.strictEqual(alertWrapper.prop('color'), 'danger');
      assert.strictEqual(alertWrapper.render().text(), error);

      done();
    });
  });

  it('should show success alert on submit', (done) => {
    const wrapper = shallow(<App />);

    wrapper.find('Form').simulate('submit', { preventDefault: () => {} });

    setImmediate(() => {
      wrapper.update();
      const alertWrapper = wrapper.find('Alert');

      assert.strictEqual(alertWrapper.prop('color'), 'success');
      assert.strictEqual(alertWrapper.render().text(), 'Successfully submitted!');

      done();
    });
  });
});
